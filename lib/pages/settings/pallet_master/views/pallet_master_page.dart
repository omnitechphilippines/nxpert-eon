import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../components/footer.dart';
import '../../../../components/header_banner.dart';
import '../../../../components/side_nav.dart';
import '../../../../components/custom_app_bar.dart';
import '../../../../components/pallet_master/add_pallet_modal.dart';
import '../../../../components/pallet_master/pallet_table.dart';
import '../../../../components/pallet_master/search_pallet_modal.dart';
import '../models/pallet_model.dart';
import '../controllers/pallet_master_controller.dart';

class PalletMasterPage extends StatefulWidget {
  const PalletMasterPage({super.key});

  @override
  State<PalletMasterPage> createState() => _PalletMasterPageState();
}

class _PalletMasterPageState extends State<PalletMasterPage> {
  final PalletMasterController _controller = PalletMasterController();
  List<Pallet> _pallets = [];
  bool _isLoading = true;
  String _error = '';
  int _currentPage = 1;
  int _entriesPerPage = 10;
  int _totalCount = 0;

  // Filters
  String? _filterCode;
  String? _filterCategory;
  String? _filterColor;
  String? _filterStatus;

  Future<void> _loadPallets({
    String? palletCode,
    String? palletCategory,
    String? palletColor,
    String? palletStatus,
  }) async {
    setState(() {
      _isLoading = true;
      _error = '';
    });

    try {
      final response =
          (palletCode != null ||
                  palletCategory != null ||
                  palletColor != null ||
                  palletStatus != null)
              ? await _controller.searchPallets(
                page: _currentPage,
                limit: _entriesPerPage,
                palletCode: palletCode,
                palletCategory: palletCategory,
                palletColor: palletColor,
                palletStatus: palletStatus,
              )
              : await _controller.getPallets(
                page: _currentPage,
                limit: _entriesPerPage,
              );

      setState(() {
        _pallets = response.pallets;
        _totalCount = response.totalCount;
        _isLoading = false;
        _filterCode = palletCode;
        _filterCategory = palletCategory;
        _filterColor = palletColor;
        _filterStatus = palletStatus;
      });
    } catch (e) {
      setState(() {
        _error = 'Failed to load pallets: $e';
        _isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _loadPallets();
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
          const HeaderBanner(subtitle: 'PALLET MASTER'),

          // Top Controls
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 8.0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
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
                          _loadPallets(
                            palletCode: _filterCode,
                            palletCategory: _filterCategory,
                            palletColor: _filterColor,
                            palletStatus: _filterStatus,
                          );
                        }
                      },
                    ),
                    const Text(" entries"),
                  ],
                ),
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        showSearchPalletModal(context, ({
                          palletCode,
                          palletCategory,
                          palletColor,
                          palletStatus,
                        }) {
                          _currentPage = 1;
                          _loadPallets(
                            palletCode: palletCode,
                            palletCategory: palletCategory,
                            palletColor: palletColor,
                            palletStatus: palletStatus,
                          );
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                        minimumSize: const Size(150, 50),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero,
                        ),
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
                          () => showAddPalletModal(context, () {
                            _currentPage = 1;
                            _loadPallets();
                          }),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                        minimumSize: const Size(150, 50),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero,
                        ),
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.add),
                          SizedBox(width: 8),
                          Text('Add Pallet'),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Table or Loader/Error
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child:
                  _isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : _error.isNotEmpty
                      ? Center(child: Text(_error))
                      : PalletTable(pallets: _pallets),
            ),
          ),

          // Pagination Controls
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
                    _pallets.isEmpty
                        ? 'Showing 0 entries'
                        : 'Showing ${((_currentPage - 1) * _entriesPerPage) + 1} '
                            'to ${((_currentPage - 1) * _entriesPerPage) + _pallets.length} '
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
                                  _loadPallets(
                                    palletCode: _filterCode,
                                    palletCategory: _filterCategory,
                                    palletColor: _filterColor,
                                    palletStatus: _filterStatus,
                                  );
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
                                  _loadPallets(
                                    palletCode: _filterCode,
                                    palletCategory: _filterCategory,
                                    palletColor: _filterColor,
                                    palletStatus: _filterStatus,
                                  );
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
