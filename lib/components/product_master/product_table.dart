import 'package:flutter/material.dart';
import './update_product_modal.dart';
import './confirm_delete_modal.dart';

class ProductTable extends StatelessWidget {
  final List<Map<String, String>> products;
  final void Function(int index) onDelete;

  const ProductTable({
    super.key,
    required this.products,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: ConstrainedBox(
          constraints: const BoxConstraints(minWidth: 1500),
          child: DataTable(
            headingRowColor: MaterialStateProperty.all(
              const Color.fromARGB(255, 22, 63, 97),
            ),
            columnSpacing: 20,
            border: TableBorder.all(color: Colors.grey.shade300),
            columns: const [
              DataColumn(label: Center(child: Text('Product Code', style: TextStyle(color: Colors.white)))),
              DataColumn(label: Center(child: Text('Product Name', style: TextStyle(color: Colors.white)))),
              DataColumn(label: Center(child: Text('Specification', style: TextStyle(color: Colors.white)))),
              DataColumn(label: Center(child: Text('Internal Code', style: TextStyle(color: Colors.white)))),
              DataColumn(label: Center(child: Text('Actions', style: TextStyle(color: Colors.white)))),
            ],
            rows: List.generate(products.length, (index) {
              final product = products[index];
              return DataRow(cells: [
                DataCell(Text(product['code'] ?? '')),
                DataCell(Text(product['name'] ?? '')),
                DataCell(Text(product['specification'] ?? '')),
                DataCell(Text(product['internalCode'] ?? '')),
                DataCell(
                  Align(
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ElevatedButton.icon(
                          onPressed: () => showUpdateProductModal(context, index),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                            shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                          ),
                          icon: const Icon(Icons.edit, size: 18, color: Colors.white),
                          label: const Text('Update', style: TextStyle(color: Colors.white)),
                        ),
                        const SizedBox(width: 8),
                        ElevatedButton.icon(
                          onPressed: () => showConfirmDeleteModal(context, index, onDelete),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                            shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                          ),
                          icon: const Icon(Icons.delete, size: 18, color: Colors.white),
                          label: const Text('Delete', style: TextStyle(color: Colors.white)),
                        ),
                      ],
                    ),
                  ),
                ),
              ]);
            }),
          ),
        ),
      ),
    );
  }
}
