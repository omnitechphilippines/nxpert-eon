import 'package:flutter/material.dart';
import '../../pages/settings/product_master/models/product_model.dart'; // adjust the path if needed

void showUpdateProductModal(
  BuildContext context,
  Product product,
  void Function(Product updatedProduct) onUpdate,
) {
  final TextEditingController productCodeController =
      TextEditingController(text: product.productCode);
  final TextEditingController nameController =
      TextEditingController(text: product.productName);
  final TextEditingController specificationController =
      TextEditingController(text: product.productSpecification);
  final TextEditingController internalCodeController =
      TextEditingController(text: product.productInternalCode);

  void submitForm() {
    final updatedProduct = Product(
      productCode: productCodeController.text.trim(),
      productName: nameController.text.trim(),
      productSpecification: specificationController.text.trim(),
      productInternalCode: internalCodeController.text.trim(),
    );

    onUpdate(updatedProduct);
    Navigator.pop(context);
  }

  showGeneralDialog(
    context: context,
    barrierDismissible: true,
    barrierLabel: "Update Product",
    barrierColor: Colors.black.withOpacity(0.3),
    transitionDuration: const Duration(milliseconds: 300),
    pageBuilder: (_, __, ___) {
      return Center(
        child: Material(
          color: Colors.transparent,
          child: AlertDialog(
            shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
            titlePadding: EdgeInsets.zero,
            title: Container(
              padding: const EdgeInsets.all(16),
              color: Colors.blue,
              child: const Text(
                'Update Product',
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
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
                      border: OutlineInputBorder(borderRadius: BorderRadius.zero),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: nameController,
                    decoration: const InputDecoration(
                      labelText: 'Product Name',
                      border: OutlineInputBorder(borderRadius: BorderRadius.zero),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: specificationController,
                    decoration: const InputDecoration(
                      labelText: 'Specification',
                      border: OutlineInputBorder(borderRadius: BorderRadius.zero),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: internalCodeController,
                    decoration: const InputDecoration(
                      labelText: 'Internal Code',
                      border: OutlineInputBorder(borderRadius: BorderRadius.zero),
                    ),
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                child: const Text('Cancel', style: TextStyle(color: Colors.white)),
              ),
              ElevatedButton(
                onPressed: submitForm,
                style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                child: const Text('Update', style: TextStyle(color: Colors.white)),
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
