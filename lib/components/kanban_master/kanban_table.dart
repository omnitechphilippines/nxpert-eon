import 'package:flutter/material.dart';
import '../../pages/settings/kanban_master/models/kanban_model.dart';
import './update_kanban_modal.dart';

class KanbanTable extends StatelessWidget {
  final List<Kanban> kanbans;
  final void Function(int index, Kanban updatedKanban)? onUpdate;

  const KanbanTable({super.key, required this.kanbans, this.onUpdate});

  @override
  Widget build(BuildContext context) {
    if (kanbans.isEmpty) {
      return const Center(
        child: Text(
          'No kanbans found',
          style: TextStyle(fontSize: 16, color: Colors.grey),
        ),
      );
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: ConstrainedBox(
            constraints: BoxConstraints(minWidth: constraints.maxWidth),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: DataTable(
                headingRowColor: MaterialStateProperty.all(
                  const Color.fromARGB(255, 22, 63, 97),
                ),
                columnSpacing: 20,
                border: TableBorder.all(color: Colors.grey.shade300),
                columns: const [
                  DataColumn(
                    label: Expanded(
                      child: Text(
                        'Kanban ID',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  DataColumn(
                    label: Expanded(
                      child: Text(
                        'Part No.',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  DataColumn(
                    label: Expanded(
                      child: Text(
                        'Description',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  DataColumn(
                    label: Expanded(
                      child: Text(
                        'Capacity',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  DataColumn(
                    label: Expanded(
                      child: Text(
                        'Locator',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  DataColumn(
                    label: Expanded(
                      child: Text(
                        'Remarks',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  DataColumn(
                    label: Expanded(
                      child: Text(
                        'Action',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
                rows: List.generate(kanbans.length, (index) {
                  final kanban = kanbans[index];
                  return DataRow(
                    cells: [
                      DataCell(Text(kanban.kanbanId ?? 'empty')),
                      DataCell(Text(kanban.kanbanPartNo ?? 'empty')),
                      DataCell(Text(kanban.kanbanDescription ?? 'empty')),
                      DataCell(
                        Text(kanban.kanbanCapacity?.toString() ?? 'empty'),
                      ),
                      DataCell(Text(kanban.kanbanDefaultLocator ?? 'empty')),
                      DataCell(Text(kanban.kanbanRemarks ?? 'empty')),

                      DataCell(
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton.icon(
                              onPressed:
                                  onUpdate != null
                                      ? () {
                                        showUpdateKanbanModal(
                                          context,
                                          kanban,
                                          (updated) =>
                                              onUpdate!(index, updated),
                                        );
                                      }
                                      : null,
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
