import 'package:flutter/material.dart';
import '../../pages/settings/locator_master/models/locator_model.dart';
import './update_locator_modal.dart';
// import '../locator_master/update_locator_modal.dart';

class LocatorTable extends StatelessWidget {
  final List<Locator> locators;
  final void Function(int index, Locator updatedLocator)? onUpdate;

  const LocatorTable({super.key, required this.locators, this.onUpdate});

  @override
  Widget build(BuildContext context) {
    if (locators.isEmpty) {
      return const Center(
        child: Text(
          'No locators found',
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
                        'Locator Code',
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
                        'Type',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  DataColumn(
                    label: Expanded(
                      child: Text(
                        'Area',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  DataColumn(
                    label: Expanded(
                      child: Text(
                        'Occupancy',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  DataColumn(
                    label: Expanded(
                      child: Text(
                        'Status',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  DataColumn(
                    label: Expanded(
                      child: Text(
                        'Warehouse',
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
                rows: List.generate(locators.length, (index) {
                  final locator = locators[index];
                  print(
                    'Warehouse value for row $index: ${locator.locatorCode}',
                  );

                  return DataRow(
                    cells: [
                      DataCell(
                        Text(locator.locatorCode?.toString() ?? 'empty'),
                      ),
                      DataCell(
                        Text(locator.locatorDesc?.toString() ?? 'empty'),
                      ),
                      DataCell(
                        Text(locator.locatorType?.toString() ?? 'empty'),
                      ),
                      DataCell(
                        Text(locator.locatorArea?.toString() ?? 'empty'),
                      ),
                      DataCell(
                        Text(
                          locator.locatorOccupancyStatus?.toString() ?? 'empty',
                        ),
                      ),
                      DataCell(
                        Text(locator.locatorStatus?.toString() ?? 'empty'),
                      ),
                      DataCell(
                        Text(
                          locator.locatorWarehouseCode?.toString() ?? 'empty',
                        ),
                      ),

                      DataCell(
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton.icon(
                              onPressed:
                                  onUpdate != null
                                      ? () {
                                        showUpdateLocatorModal(
                                          context,
                                          locator,
                                          (updatedLocator) =>
                                              onUpdate!(index, updatedLocator),
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
