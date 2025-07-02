import 'package:flutter/material.dart';
import '../../pages/settings/product_master/models/product_model.dart';
import '../../pages/settings/product_master/controllers/product_master_controller.dart';

void showSearchProductModal(
  BuildContext context, {
  required ProductMasterController controller,
  required void Function(List<Product> products, int totalCount) onSearchResult,
  required int currentPage,
  required int limit,
}) {
  final TextEditingController productCodeController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController specificationController = TextEditingController();
  final TextEditingController internalCodeController = TextEditingController();

  void clearFields() {
    productCodeController.clear();
    nameController.clear();
    specificationController.clear();
    internalCodeController.clear();
  }

  Future<void> submitForm() async {
    final String code = productCodeController.text.trim();
    final String name = nameController.text.trim();
    final String specification = specificationController.text.trim();
    final String internalCode = internalCodeController.text.trim();

    try {
      final response = await controller.searchProducts(
        page: currentPage,
        limit: limit,
        productCode: code.isEmpty ? null : code,
        productName: name.isEmpty ? null : name,
        productSpecification: specification.isEmpty ? null : specification,
        internalProdCode: internalCode.isEmpty ? null : internalCode,
      );

      clearFields();
      Navigator.pop(context);
      onSearchResult(response.products, response.totalCount);
    } catch (e) {
      Navigator.pop(context);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Search failed: $e')));
    }
  }

  showGeneralDialog(
    context: context,
    barrierDismissible: true,
    barrierLabel: "Search Product",
    barrierColor: Colors.black.withOpacity(0.3),
    transitionDuration: const Duration(milliseconds: 300),
    pageBuilder: (_, __, ___) {
      return Center(
        child: Material(
          color: Colors.transparent,
          child: AlertDialog(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.zero,
            ),
            titlePadding: EdgeInsets.zero,
            title: Container(
              padding: const EdgeInsets.all(16),
              color: Colors.blue,
              child: const Text(
                'Search Product',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            content: SizedBox(
              width: 500,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  TextField(
                    controller: productCodeController,
                    decoration: const InputDecoration(
                      labelText: 'Product Code',
                      labelStyle: TextStyle(color: Colors.blueGrey),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.zero,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.zero,
                        borderSide: BorderSide(color: Colors.blue),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: nameController,
                    decoration: const InputDecoration(
                      labelText: 'Product Name',
                      labelStyle: TextStyle(color: Colors.blueGrey),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.zero,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.zero,
                        borderSide: BorderSide(color: Colors.blue),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: specificationController,
                    decoration: const InputDecoration(
                      labelText: 'Product Specification',
                      labelStyle: TextStyle(color: Colors.blueGrey),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.zero,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.zero,
                        borderSide: BorderSide(color: Colors.blue),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: internalCodeController,
                    decoration: const InputDecoration(
                      labelText: 'Internal Product Code',
                      labelStyle: TextStyle(color: Colors.blueGrey),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.zero,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.zero,
                        borderSide: BorderSide(color: Colors.blue),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero,
                  ),
                ),
                child: const Text(
                  'Cancel',
                  style: TextStyle(fontSize: 14, color: Colors.white),
                ),
              ),
              ElevatedButton(
                onPressed: submitForm,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero,
                  ),
                ),
                child: const Text(
                  'Search',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
    transitionBuilder: (context, animation, secondaryAnimation, child) {
      return ScaleTransition(
        scale: CurvedAnimation(parent: animation, curve: Curves.easeOutBack),
        child: child,
      );
    },
  );
}
