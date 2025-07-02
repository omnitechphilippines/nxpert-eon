import 'package:flutter/material.dart';
import './update_product_modal.dart';
import './confirm_delete_modal.dart';
import '../../pages/settings/product_master/models/product_model.dart';

class ProductTable extends StatelessWidget {
  final List<Product> products;
  final void Function(int index) onDelete;
  final void Function(int index, Product updatedProduct) onUpdate;

  const ProductTable({
    super.key,
    required this.products,
    required this.onDelete,
    required this.onUpdate,
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
              DataColumn(
                label: Text(
                  'Product Code',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              DataColumn(
                label: Text(
                  'Product Name',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              DataColumn(
                label: Text(
                  'Cost Center',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              DataColumn(
                label: Text('Category', style: TextStyle(color: Colors.white)),
              ),
              DataColumn(
                label: Text('Source', style: TextStyle(color: Colors.white)),
              ),
              DataColumn(
                label: Text('BM Status', style: TextStyle(color: Colors.white)),
              ),
              DataColumn(
                label: Text(
                  'Specification',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              DataColumn(
                label: Text(
                  'Internal Code',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              DataColumn(
                label: Text('Actions', style: TextStyle(color: Colors.white)),
              ),
            ],
            rows: List.generate(products.length, (index) {
              final product = products[index];
              return DataRow(
                cells: [
                  DataCell(Text(product.productCode)),
                  DataCell(Text(product.productName)),
                  DataCell(Text(product.costCenterCode)),
                  DataCell(Text(product.prodCategory)),
                  DataCell(Text(product.prodSource)),
                  DataCell(Text(product.bmStatus)),
                  DataCell(Text(product.productSpecification)),
                  DataCell(Text(product.productInternalCode)),
                  DataCell(
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ElevatedButton.icon(
                          onPressed:
                              () => showUpdateProductModal(
                                context,
                                product,
                                (updatedProduct) =>
                                    onUpdate(index, updatedProduct),
                              ),
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
                          onPressed:
                              () => showConfirmDeleteModal(
                                context,
                                index,
                                onDelete,
                              ),
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
  }
}
