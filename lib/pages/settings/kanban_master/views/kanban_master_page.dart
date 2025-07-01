import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../components/footer.dart';
import '../../../../components/header_banner.dart';
import '../../../../components/side_nav.dart';
import '../../../../components/custom_app_bar.dart';
import '../../../../components/kanban_master/add_kanban_modal.dart';
import '../../../../components/kanban_master/kanban_table.dart';
import '../../../../components/kanban_master/search_kanban_modal.dart';
import '../models/kanban_model.dart';
import '../controllers/kanban_master_controller.dart';

class KanbanMasterPage extends StatefulWidget {
  const KanbanMasterPage({super.key});

  @override
  State<KanbanMasterPage> createState() => _KanbanMasterPageState();
}

class _KanbanMasterPageState extends State<KanbanMasterPage> {
  final KanbanMasterController _controller = KanbanMasterController();
  List<Kanban> _kanbans = [];
  bool _isLoading = true;
  String _error = '';
  int _currentPage = 1;
  int _entriesPerPage = 10;
  int _totalCount = 0;

  // Filters
  String? _filterPartNo;
  String? _filterLocator;
  String? _filterRemarks;

  Future<void> _loadKanbans({
    String? kanbanPartNo,
    String? kanbanDefaultLocator,
    String? kanbanRemarks,
    String? kanbanDescription,
    String? kanbanCapacity,
  }) async {
    setState(() {
      _isLoading = true;
      _error = '';
    });

    try {
      final response = (kanbanPartNo != null ||
              kanbanDefaultLocator != null ||
              kanbanRemarks != null ||
              kanbanDescription != null ||
              kanbanCapacity != null)
          ? await _controller.searchKanbans(
              page: _currentPage,
              limit: _entriesPerPage,
              kanbanPartNo: kanbanPartNo,
              kanbanDefaultLocator: kanbanDefaultLocator,
              kanbanRemarks: kanbanRemarks,
              kanbanDescription: kanbanDescription,
              kanbanCapacity: kanbanCapacity,
            )
          : await _controller.getKanbans(
              page: _currentPage,
              limit: _entriesPerPage,
            );

      setState(() {
        _kanbans = response.kanbans;
        _totalCount = response.totalCount;
        _isLoading = false;
        _filterPartNo = kanbanPartNo;
        _filterLocator = kanbanDefaultLocator;
        _filterRemarks = kanbanRemarks;
      });
    } catch (e) {
      setState(() {
        _error = 'Failed to load kanbans: $e';
        _isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _loadKanbans();
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
            GoRouter.of(context).routerDelegate.currentConfiguration.uri.toString(),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          const HeaderBanner(subtitle: 'KANBAN MASTER'),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Text("Show "),
                    DropdownButton<int>(
                      value: _entriesPerPage,
                      items: [5, 10, 25, 50, 100]
                          .map((count) => DropdownMenuItem<int>(
                                value: count,
                                child: Text('$count'),
                              ))
                          .toList(),
                      onChanged: (value) {
                        if (value != null) {
                          setState(() {
                            _entriesPerPage = value;
                            _currentPage = 1;
                          });
                          _loadKanbans(
                            kanbanPartNo: _filterPartNo,
                            kanbanDefaultLocator: _filterLocator,
                            kanbanRemarks: _filterRemarks,
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
                        showSearchKanbanModal(context, ({
                          String? kanbanPartNo,
                          String? kanbanDescription,
                          String? kanbanCapacity,
                          String? kanbanDefaultLocator,
                          String? kanbanRemarks,
                        }) {
                          _loadKanbans(
                            kanbanPartNo: kanbanPartNo,
                            kanbanDescription: kanbanDescription,
                            kanbanCapacity: kanbanCapacity,
                            kanbanDefaultLocator: kanbanDefaultLocator,
                            kanbanRemarks: kanbanRemarks,
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
                      onPressed: () {
                        showAddKanbanModal(context, () {
                          _currentPage = 1;
                          _loadKanbans();
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
                          Icon(Icons.add),
                          SizedBox(width: 8),
                          Text('Add Kanban'),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : _error.isNotEmpty
                      ? Center(child: Text(_error))
                      : KanbanTable(
                          kanbans: _kanbans,
                        ),
            ),
          ),
          if (!_isLoading && _error.isEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    _kanbans.isEmpty
                        ? 'Showing 0 entries'
                        : 'Showing ${((_currentPage - 1) * _entriesPerPage) + 1} '
                            'to ${((_currentPage - 1) * _entriesPerPage) + _kanbans.length} '
                            'of $_totalCount entries',
                  ),
                  Row(
                    children: [
                      TextButton(
                        onPressed: _currentPage > 1
                            ? () {
                                setState(() {
                                  _currentPage--;
                                });
                                _loadKanbans(
                                  kanbanPartNo: _filterPartNo,
                                  kanbanDefaultLocator: _filterLocator,
                                  kanbanRemarks: _filterRemarks,
                                );
                              }
                            : null,
                        child: const Text("Previous"),
                      ),
                      Text('Page $_currentPage of $totalPages'),
                      TextButton(
                        onPressed: (_currentPage * _entriesPerPage < _totalCount)
                            ? () {
                                setState(() {
                                  _currentPage++;
                                });
                                _loadKanbans(
                                  kanbanPartNo: _filterPartNo,
                                  kanbanDefaultLocator: _filterLocator,
                                  kanbanRemarks: _filterRemarks,
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
