import 'package:flutter/material.dart';
import '../../pages/settings/shift_master/models/shift_model.dart';

class ShiftTable extends StatelessWidget {
  final List<ShiftModel> shifts;
  final void Function(int index) onUpdate;
  final void Function(int index) onDelete;

  const ShiftTable({
    Key? key,
    required this.shifts,
    required this.onUpdate,
    required this.onDelete,
  }) : super(key: key);

  String formatTime(DateTime time) {
    return '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (shifts.isEmpty) {
          return const Center(
            child: Text(
              'No Shifts Found',
              style: TextStyle(color: Colors.grey),
            ),
          );
        }

        return SizedBox(
          width: double.infinity,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: ConstrainedBox(
              constraints: BoxConstraints(minWidth: constraints.maxWidth),
              child: DataTable(
                headingRowColor: MaterialStateProperty.all(
                  const Color.fromARGB(255, 22, 63, 97),
                ),
                columnSpacing: 24,
                dataRowMinHeight: 56,
                dataRowMaxHeight: 56,
                border: TableBorder.all(color: Colors.grey.shade300),
                columns: const [
                  DataColumn(
                    label: Text(
                      'Shift Code',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Shift Description',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Schedule Type',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Time In',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Break Start',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Break End',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Time Out',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Total Hours',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Status',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  DataColumn(
                    label: Text('User', style: TextStyle(color: Colors.white)),
                  ),
                  DataColumn(
                    label: Center(
                      child: Text(
                        'Actions',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
                rows: List.generate(shifts.length, (index) {
                  final shift = shifts[index];
                  return DataRow(
                    cells: [
                      DataCell(Text(shift.shiftCode)),
                      DataCell(Text(shift.shiftDescription)),
                      DataCell(Text(shift.scheduleType)),
                      DataCell(Text(formatTime(shift.timeIn))),
                      DataCell(
                        Text(
                          shift.breakStart != null
                              ? formatTime(shift.breakStart!)
                              : '-',
                        ),
                      ),
                      DataCell(
                        Text(
                          shift.breakEnd != null
                              ? formatTime(shift.breakEnd!)
                              : '-',
                        ),
                      ),
                      DataCell(Text(formatTime(shift.timeOut))),
                      DataCell(Text('${shift.totalHours}')),
                      DataCell(Text(shift.status)),
                      DataCell(Text(shift.user.trim())),
                      DataCell(
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton.icon(
                              onPressed: () => onUpdate(index),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 8,
                                ),
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.zero,
                                ),
                              ),
                              icon: const Icon(
                                Icons.edit,
                                size: 18,
                                color: Colors.white,
                              ),
                              label: const Text(
                                'Update',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            const SizedBox(width: 8),
                            ElevatedButton.icon(
                              onPressed: () => onDelete(index),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 8,
                                ),
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.zero,
                                ),
                              ),
                              icon: const Icon(
                                Icons.delete,
                                size: 18,
                                color: Colors.white,
                              ),
                              label: const Text(
                                'Delete',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                }),
              ),
            ),
          ),
        );
      },
    );
  }
}
