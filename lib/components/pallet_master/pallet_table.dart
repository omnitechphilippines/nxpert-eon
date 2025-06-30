import 'package:flutter/material.dart';
import '../../pages/settings/pallet_master/models/pallet_model.dart';
// Import modal if you have update functionality:
import '../pallet_master/update_pallet_modal.dart';

class PalletTable extends StatelessWidget {
  final List<Pallet> pallets;
  final void Function(int index, Pallet updatedPallet)? onUpdate;

  const PalletTable({super.key, required this.pallets, this.onUpdate});

  @override
  Widget build(BuildContext context) {
    if (pallets.isEmpty) {
      return const Center(
        child: Text(
          'No pallet found',
          style: TextStyle(fontSize: 16, color: Colors.grey),
        ),
      );
    }

    return SizedBox(
      width: double.infinity,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: ConstrainedBox(
          constraints: const BoxConstraints(minWidth: 1500),
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
                  label: Text(
                    'Pallet Code',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Description',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                DataColumn(
                  label: Text('Color', style: TextStyle(color: Colors.white)),
                ),
                DataColumn(
                  label: Text(
                    'Category',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                DataColumn(
                  label: Text('Status', style: TextStyle(color: Colors.white)),
                ),
                DataColumn(
                  label: Text('Actions', style: TextStyle(color: Colors.white)),
                ),
              ],
              rows: List.generate(pallets.length, (index) {
                final pallet = pallets[index];
                return DataRow(
                  cells: [
                    DataCell(Text(pallet.palletCode ?? '')),
                    DataCell(Text(pallet.palletDescription ?? '')),
                    DataCell(Text(pallet.palletColor ?? '')),
                    DataCell(Text(pallet.palletCategory ?? '')),
                    DataCell(Text(pallet.palletStatus ?? '')),
                    DataCell(
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton.icon(
                            onPressed:
                                onUpdate != null
                                    ? () {
                                      showUpdatePalletModal(
                                        context,
                                        pallet,
                                        (updatedPallet) =>
                                            onUpdate!(index, updatedPallet),
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
      ),
    );
  }
}
