import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../components/footer.dart';
import '../../../../components/header_banner.dart';
import '../../../../components/side_nav.dart';
import '../../../../components/custom_app_bar.dart';
import '../../../../components/locator_master/add_locator_modal.dart';
import '../../../../components/locator_master/search_locator_modal.dart';
import '../../../../components/locator_master/locator_table.dart';
import '../models/locator_model.dart';
import '../controllers/locator_master_controller.dart';

class LocatorMasterPage extends StatefulWidget {
  const LocatorMasterPage({super.key});

  @override
  State<LocatorMasterPage> createState() => _LocatorMasterPageState();
}

class _LocatorMasterPageState extends State<LocatorMasterPage> {
  final LocatorMasterController _controller = LocatorMasterController();
  List<Locator> _locators = [];
  bool _isLoading = true;
  String _error = '';

  int _entriesPerPage = 10;
  int _currentPage = 1;
  int _totalCount = 0;

  void _updateLocator(int index, Locator updatedLocator) {
    setState(() {
      _locators[index] = updatedLocator;
    });
  }

  Future<void> _loadLocators() async {
    setState(() {
      _isLoading = true;
      _error = '';
    });

    try {
      final result = await _controller.getLocators(
        page: _currentPage,
        limit: _entriesPerPage,
      );
      setState(() {
        _locators = result.locators;
        _totalCount = result.total;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = 'Error loading locators: $e';
        _isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _loadLocators();
  }

  @override
  Widget build(BuildContext context) {
    final int totalPages =
        _totalCount == 0 ? 1 : (_totalCount / _entriesPerPage).ceil();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBar(title: 'NXPERT EON'),
      drawer: SideNav(
        currentRoute:
            GoRouter.of(
              context,
            ).routerDelegate.currentConfiguration.uri.toString(),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          const HeaderBanner(subtitle: 'LOCATOR MASTER'),

          // Top Controls Row
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 8.0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Entry limit dropdown
                Row(
                  children: [
                    const Text("Show "),
                    DropdownButton<int>(
                      value: _entriesPerPage,
                      items:
                          [5, 10, 25, 50, 100]
                              .map(
                                (count) => DropdownMenuItem<int>(
                                  value: count,
                                  child: Text('$count'),
                                ),
                              )
                              .toList(),
                      onChanged: (value) {
                        if (value != null) {
                          setState(() {
                            _entriesPerPage = value;
                            _currentPage = 1;
                          });
                          _loadLocators();
                        }
                      },
                    ),
                    const Text(" entries"),
                  ],
                ),

                // Buttons: Search + Add
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        showSearchLocatorModal(context, ({
                          locatorCode,
                          locatorType,
                          locatorArea,
                          locatorOccupancyStatus,
                          locatorStatus,
                          userLogin,
                        }) {
                          setState(() => _isLoading = true);
                          _controller
                              .searchLocator(
                                page: 1,
                                limit: _entriesPerPage,
                                locatorCode: locatorCode,
                                locatorType: locatorType,
                                locatorArea: locatorArea,
                                locatorOccupancyStatus: locatorOccupancyStatus,
                                locatorStatus: locatorStatus,
                                userLogin: userLogin,
                              )
                              .then((result) {
                                setState(() {
                                  _locators =
                                      result.locators; // ✅ This is Step 1
                                  _totalCount = result.total;
                                  _currentPage = 1;
                                  _isLoading = false;
                                });
                              })
                              .catchError((e) {
                                setState(() {
                                  _error = 'Search failed: $e';
                                  _isLoading = false;
                                });
                              });
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero,
                        ),
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                        minimumSize: const Size(150, 50),
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.search),
                          SizedBox(width: 8),
                          Text('Search'),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton(
                      onPressed:
                          () => showAddLocatorModal(context, _loadLocators),
                      style: ElevatedButton.styleFrom(
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero,
                        ),
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                        minimumSize: const Size(150, 50),
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.add),
                          SizedBox(width: 8),
                          Text('Add Locator'),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Locator Table
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child:
                  _isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : _error.isNotEmpty
                      ? Center(
                        child: Text(
                          _error,
                          style: const TextStyle(color: Colors.grey),
                        ),
                      )
                      : _locators.isEmpty
                      ? const Center(
                        child: Text(
                          'No locators found',
                          style: TextStyle(color: Colors.grey),
                        ),
                      )
                      : LocatorTable(
                        locators: _locators,
                        onUpdate: _updateLocator,
                      ),
            ),
          ),

          // Pagination Controls & Footer
          if (!_isLoading && _error.isEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 8.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    _locators.isEmpty
                        ? 'Showing 0 entries'
                        : 'Showing ${((_currentPage - 1) * _entriesPerPage) + 1} '
                            'to ${((_currentPage - 1) * _entriesPerPage) + _locators.length} '
                            'of $_totalCount entries',
                  ),
                  Row(
                    children: [
                      TextButton(
                        onPressed:
                            _currentPage > 1
                                ? () {
                                  setState(() {
                                    _currentPage--;
                                  });
                                  _loadLocators();
                                }
                                : null,
                        child: const Text("Previous"),
                      ),
                      Text('Page $_currentPage of $totalPages'),
                      TextButton(
                        onPressed:
                            (_currentPage * _entriesPerPage < _totalCount)
                                ? () {
                                  setState(() {
                                    _currentPage++;
                                  });
                                  _loadLocators();
                                }
                                : null,
                        child: const Text("Next"),
                      ),
                    ],
                  ),
                ],
              ),
            ),

          const Footer(),
        ],
      ),
    );
  }
}
