import 'package:flutter/material.dart';
import '../../pages/settings/product_master/models/product_model.dart'; 

void showAddProductModal(BuildContext context, Function(Product) onAddProduct) {
  final TextEditingController productCodeController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController specificationController = TextEditingController();
  final TextEditingController internalCodeController = TextEditingController();

  bool areFieldsValid() {
    if (productCodeController.text.trim().isEmpty ||
        nameController.text.trim().isEmpty ||
        specificationController.text.trim().isEmpty ||
        internalCodeController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all fields')),
      );
      return false;
    }
    return true;
  }

  void clearFields() {
    productCodeController.clear();
    nameController.clear();
    specificationController.clear();
    internalCodeController.clear();
  }

  void submitForm() {
    if (!areFieldsValid()) return;

    final product = Product(
      productCode: productCodeController.text.trim(),
      productName: nameController.text.trim(),
      productSpecification: specificationController.text.trim(),
      productInternalCode: internalCodeController.text.trim(),
    );

    onAddProduct(product); // pass to parent
    clearFields();
    Navigator.pop(context);
  }

  showGeneralDialog(
    context: context,
    barrierDismissible: true,
    barrierLabel: "Add Product",
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
                'Add Product',
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
                      labelStyle: TextStyle(color: Colors.blueGrey),
                      border: OutlineInputBorder(borderRadius: BorderRadius.zero),
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
                      border: OutlineInputBorder(borderRadius: BorderRadius.zero),
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
                      border: OutlineInputBorder(borderRadius: BorderRadius.zero),
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
                      border: OutlineInputBorder(borderRadius: BorderRadius.zero),
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
                  shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                ),
                child: const Text('Cancel', style: TextStyle(fontSize: 14, color: Colors.white)),
              ),
              ElevatedButton(
                onPressed: submitForm,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                ),
                child: const Text(
                  'Submit',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.white),
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
