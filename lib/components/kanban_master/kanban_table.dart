import 'package:flutter/material.dart';
import '../../pages/settings/kanban_master/models/kanban_model.dart';

class KanbanTable extends StatelessWidget {
  final List<Kanban> kanbans;

  const KanbanTable({super.key, required this.kanbans});

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
