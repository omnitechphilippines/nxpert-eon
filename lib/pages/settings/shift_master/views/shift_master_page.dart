// No changes in your imports or class declaration
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:quickalert/quickalert.dart';

import '../../../../components/footer.dart';
import '../../../../components/header_banner.dart';
import '../../../../components/side_nav.dart';
import '../../../../components/custom_app_bar.dart';
import '../../../../components/shift_master/add_shift_modal.dart';
import '../../../../components/shift_master/search_shift_modal.dart';
import '../../../../components/shift_master/shift_table.dart';
import '../models/shift_model.dart';
import '../controllers/shift_master_controller.dart';
import '../../../../components/shift_master/delete_shift_modal.dart';
import '../../../../components/shift_master/update_shift_modal.dart';

class ShiftMasterPage extends StatefulWidget {
  const ShiftMasterPage({super.key});

  @override
  State<ShiftMasterPage> createState() => _ShiftMasterPageState();
}

class _ShiftMasterPageState extends State<ShiftMasterPage> {
  final ShiftMasterController _controller = ShiftMasterController();
  List<ShiftModel> _shifts = [];
  bool _isLoading = true;
  String _error = '';

  int _entriesPerPage = 10;
  int _currentPage = 1;
  int _totalCount = 0;

  DateTime _toDateTime(TimeOfDay tod) {
    final now = DateTime.now();
    return DateTime(now.year, now.month, now.day, tod.hour, tod.minute);
  }

  int _calculateTotalHours(
    TimeOfDay timeIn,
    TimeOfDay? breakStart,
    TimeOfDay? breakEnd,
    TimeOfDay timeOut,
  ) {
    final inDt = _toDateTime(timeIn);
    final outDt = _toDateTime(timeOut);
    int total = outDt.difference(inDt).inMinutes;

    if (breakStart != null && breakEnd != null) {
      final breakDuration =
          _toDateTime(breakEnd).difference(_toDateTime(breakStart)).inMinutes;
      total -= breakDuration;
    }

    return (total / 60).round();
  }

  Future<void> _loadShifts() async {
    setState(() {
      _isLoading = true;
      _error = '';
    });

    try {
      final result = await _controller.getShifts(
        page: _currentPage,
        limit: _entriesPerPage,
      );
      setState(() {
        _shifts = result.shifts;
        _totalCount = result.total;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = 'Error loading shifts: $e';
        _isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _loadShifts();
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
        children: [
          const HeaderBanner(subtitle: 'SHIFT MASTER'),

          // Top Controls
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 8.0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Entries dropdown
                Row(
                  children: [
                    const Text("Show "),
                    DropdownButton<int>(
                      value: _entriesPerPage,
                      items:
                          [5, 10, 25, 50, 100]
                              .map(
                                (count) => DropdownMenuItem(
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
                          _loadShifts();
                        }
                      },
                    ),
                    const Text(" entries"),
                  ],
                ),

                // Buttons
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        showSearchShiftModal(
                          context,
                          (params) async {
                            setState(() => _isLoading = true);
                            try {
                              final result = await _controller.searchShifts(
                                page: 1,
                                limit: _entriesPerPage,
                                shiftCode: params['shiftCode'],
                                shiftDescription: params['shiftDescription'],
                                scheduleType: params['shiftType'],
                                status: params['shiftStatus'],
                              );
                              setState(() {
                                _shifts = result.shifts;
                                _totalCount = result.total;
                                _currentPage = 1;
                                _isLoading = false;
                              });
                            } catch (e) {
                              setState(() {
                                _error = 'Search failed: $e';
                                _isLoading = false;
                              });
                            }
                          },
                          onReset: () async {
                            setState(() => _isLoading = true);
                            try {
                              final result = await _controller.getShifts(
                                page: 1,
                                limit: _entriesPerPage,
                              );
                              setState(() {
                                _shifts = result.shifts;
                                _totalCount = result.total;
                                _currentPage = 1;
                                _isLoading = false;
                              });
                            } catch (e) {
                              setState(() {
                                _error = 'Reset failed: $e';
                                _isLoading = false;
                              });
                            }
                          },
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero,
                        ),
                        minimumSize: const Size(150, 50),
                      ),
                      child: const Row(
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
                        showAddShiftModal(context, (newShift) async {
                          final shift = ShiftModel(
                            shiftCode: newShift['shiftCode'],
                            shiftDescription:
                                newShift['shiftDescription'] ?? '',
                            scheduleType: newShift['shiftType'],
                            timeIn: _toDateTime(newShift['timeIn']),
                            breakStart:
                                newShift['breakStart'] != null
                                    ? _toDateTime(newShift['breakStart'])
                                    : null,
                            breakEnd:
                                newShift['breakEnd'] != null
                                    ? _toDateTime(newShift['breakEnd'])
                                    : null,
                            timeOut: _toDateTime(newShift['timeOut']),
                            totalHours: _calculateTotalHours(
                              newShift['timeIn'],
                              newShift['breakStart'],
                              newShift['breakEnd'],
                              newShift['timeOut'],
                            ),
                            status: newShift['status'],
                            user: newShift['user'],
                          );

                          final success = await _controller.insertShift(shift);
                          if (success) {
                            _loadShifts();
                          } else {
                            if (context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Failed to add shift.'),
                                ),
                              );
                            }
                          }
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero,
                        ),
                        minimumSize: const Size(150, 50),
                      ),
                      child: const Row(
                        children: [
                          Icon(Icons.add),
                          SizedBox(width: 8),
                          Text('Add Shift'),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Table section
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child:
                  _isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : _error.isNotEmpty
                      ? Center(child: Text(_error))
                      : ShiftTable(
                        shifts: _shifts,
                        onUpdate: (index) {
                          showUpdateShiftModal(context, index, _shifts, (
                            i,
                            updatedShift,
                          ) {
                            setState(() {
                              _shifts[i] = updatedShift;
                            });
                          });
                        },

                        onDelete: (index) {
                          final shift = _shifts[index];
                          showConfirmDeleteShiftModal(context, shift.shiftCode, (
                            code,
                          ) async {
                            final success = await _controller.deleteShift(code);

                            if (!context.mounted) return;

                            if (success) {
                              await QuickAlert.show(
                                context: context,
                                type: QuickAlertType.success,
                                title: 'Deleted',
                                text: 'Shift "$code" deleted successfully.',
                              );
                              _loadShifts();
                            } else {
                              await QuickAlert.show(
                                context: context,
                                type: QuickAlertType.error,
                                title: 'Failed',
                                text:
                                    'Failed to delete shift "$code". Please try again.',
                              );
                            }
                          });
                        },
                      ),
            ),
          ),

          // Pagination
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
                    _shifts.isEmpty
                        ? 'Showing 0 entries'
                        : 'Showing ${((_currentPage - 1) * _entriesPerPage) + 1} '
                            'to ${((_currentPage - 1) * _entriesPerPage) + _shifts.length} '
                            'of $_totalCount entries',
                  ),
                  Row(
                    children: [
                      TextButton(
                        onPressed:
                            _currentPage > 1
                                ? () {
                                  setState(() => _currentPage--);
                                  _loadShifts();
                                }
                                : null,
                        child: const Text("Previous"),
                      ),
                      Text('Page $_currentPage of $totalPages'),
                      TextButton(
                        onPressed:
                            (_currentPage * _entriesPerPage < _totalCount)
                                ? () {
                                  setState(() => _currentPage++);
                                  _loadShifts();
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
