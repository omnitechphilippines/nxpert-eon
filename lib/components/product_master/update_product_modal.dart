import 'package:flutter/material.dart';
import '../../pages/settings/product_master/models/product_model.dart';

void showUpdateProductModal(
  BuildContext context,
  Product product,
  void Function(Product updatedProduct) onUpdate,
) {
  final TextEditingController productCodeController = TextEditingController(
    text: product.productCode,
  );
  final TextEditingController nameController = TextEditingController(
    text: product.productName,
  );
  final TextEditingController specificationController = TextEditingController(
    text: product.productSpecification,
  );
  final TextEditingController internalCodeController = TextEditingController(
    text: product.productInternalCode,
  );
  final TextEditingController regDateController = TextEditingController(
    text: product.prodRegDate?.toIso8601String().split('T').first ?? '',
  );
  final TextEditingController minLotSizeController = TextEditingController(
    text: product.minLotSize?.toString() ?? '',
  );
  final TextEditingController maxLotSizeController = TextEditingController(
    text: product.maxLotSize?.toString() ?? '',
  );
  final TextEditingController prodLeadTimeController = TextEditingController(
    text: product.prodLeadTime?.toString() ?? '',
  );
  final TextEditingController userLoginController = TextEditingController(
    text: product.userLogin,
  );

  String? selectedCostCenter = product.costCenterCode;
  String? selectedCategory = product.prodCategory;
  String? selectedSource = product.prodSource;
  bool requireCPO = product.requireCPO;
  String? selectedUnit = product.productUnit;
  String? selectedBMStatus = product.bmStatus;
  bool hasCurMthSched = product.hasCurMthSched;
  bool hasNxtMthSched = product.hasNxtMthSched;
  String? selectedPSGroupCode = product.psGroupCode;
  String? selectedLeadTimeUnit = product.leadTimeUnit;

  void submitForm() {
    final updatedProduct = Product(
      productCode: productCodeController.text.trim(),
      productName: nameController.text.trim(),
      productSpecification: specificationController.text.trim(),
      productInternalCode: internalCodeController.text.trim(),
      costCenterCode: selectedCostCenter,
      prodRegDate: DateTime.tryParse(regDateController.text.trim()),
      prodCategory: selectedCategory ?? 'G',
      prodSource: selectedSource ?? 'M',
      requireCPO: requireCPO,
      productUnit: selectedUnit,
      bmStatus: selectedBMStatus,
      hasCurMthSched: hasCurMthSched,
      hasNxtMthSched: hasNxtMthSched,
      psGroupCode: selectedPSGroupCode ?? '0',
      minLotSize: int.tryParse(minLotSizeController.text),
      maxLotSize: int.tryParse(maxLotSizeController.text),
      prodLeadTime: double.tryParse(prodLeadTimeController.text),
      leadTimeUnit: selectedLeadTimeUnit ?? 'H',
      status: 'A',
      userLogin: userLoginController.text.trim(),
      ludatetime: DateTime.now(),
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
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.zero,
            ),
            titlePadding: EdgeInsets.zero,
            title: Container(
              padding: const EdgeInsets.all(16),
              color: Colors.blue,
              child: const Text(
                'Update Product',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            content: SizedBox(
              width: 500,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: productCodeController,
                      decoration: _inputDecoration('Product Code'),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: nameController,
                      decoration: _inputDecoration('Product Name'),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: specificationController,
                      decoration: _inputDecoration('Specification'),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: internalCodeController,
                      decoration: _inputDecoration('Internal Code'),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: regDateController,
                      readOnly: true,
                      decoration: const InputDecoration(
                        labelText: 'Product Reg. Date (YYYY-MM-DD)',
                        border: OutlineInputBorder(),
                        suffixIcon: Icon(Icons.calendar_today),
                      ),
                      onTap: () async {
                        final pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2100),
                          builder: (context, child) {
                            return Theme(
                              data: Theme.of(context).copyWith(
                                colorScheme: ColorScheme.light(
                                  primary: Colors.blue, // header background
                                  onPrimary: Colors.white, // header text
                                  onSurface: Colors.black, // default text color
                                ),
                                textButtonTheme: TextButtonThemeData(
                                  style: TextButton.styleFrom(
                                    foregroundColor:
                                        Colors.blue, // button text color
                                  ),
                                ),
                              ),
                              child: child!,
                            );
                          },
                        );

                        if (pickedDate != null) {
                          regDateController.text =
                              pickedDate.toIso8601String().split('T').first;
                        }
                      },
                    ),
                    const SizedBox(height: 10),
                    DropdownButtonFormField<String>(
                      value: selectedCategory,
                      decoration: _inputDecoration('Product Category'),
                      items: const [
                        DropdownMenuItem(value: 'G', child: Text('G - Goods')),
                        DropdownMenuItem(
                          value: 'S',
                          child: Text('S - Services'),
                        ),
                      ],
                      onChanged: (val) => selectedCategory = val!,
                    ),
                    const SizedBox(height: 10),
                    DropdownButtonFormField<String>(
                      value: selectedSource,
                      decoration: _inputDecoration('Product Source'),
                      items: const [
                        DropdownMenuItem(
                          value: 'M',
                          child: Text('M - Manufacturing'),
                        ),
                      ],
                      onChanged: (val) => selectedSource = val!,
                    ),
                    const SizedBox(height: 10),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 4,
                      ),
                      child: SwitchListTile(
                        contentPadding: EdgeInsets.zero,
                        value: requireCPO,
                        onChanged: (val) => requireCPO = val,
                        title: const Text('Require CPO'),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 4,
                      ),
                      child: SwitchListTile(
                        contentPadding: EdgeInsets.zero,
                        value: hasCurMthSched,
                        onChanged: (val) => hasCurMthSched = val,
                        title: const Text('Has Current Month Schedule'),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 4,
                      ),
                      child: SwitchListTile(
                        contentPadding: EdgeInsets.zero,
                        value: hasNxtMthSched,
                        onChanged: (val) => hasNxtMthSched = val,
                        title: const Text('Has Next Month Schedule'),
                      ),
                    ),
                    const SizedBox(height: 10),
                    DropdownButtonFormField<String>(
                      value: selectedPSGroupCode,
                      decoration: _inputDecoration('PS Group Code'),
                      items: const [
                        DropdownMenuItem(value: '0', child: Text('0')),
                      ],
                      onChanged: (val) => selectedPSGroupCode = val!,
                    ),
                    const SizedBox(height: 10),

                    TextField(
                      controller: minLotSizeController,
                      keyboardType: TextInputType.number,
                      decoration: _inputDecoration('Min Lot Size'),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: maxLotSizeController,
                      keyboardType: TextInputType.number,
                      decoration: _inputDecoration('Max Lot Size'),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: prodLeadTimeController,
                      keyboardType: const TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                      decoration: _inputDecoration('Product Lead Time'),
                    ),
                    const SizedBox(height: 10),
                    DropdownButtonFormField<String>(
                      value: selectedLeadTimeUnit,
                      decoration: _inputDecoration('Lead Time Unit'),
                      items: const [
                        DropdownMenuItem(value: 'H', child: Text('H - Hours')),
                        DropdownMenuItem(
                          value: 'M',
                          child: Text('M - Minutes'),
                        ),
                        DropdownMenuItem(
                          value: 'S',
                          child: Text('S - Seconds'),
                        ),
                      ],
                      onChanged: (val) => selectedLeadTimeUnit = val!,
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: userLoginController,
                      decoration: _inputDecoration('User Login'),
                    ),
                  ],
                ),
              ),
            ),
            actions: [
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
                  style: TextStyle(color: Colors.white),
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
                  'Update',
                  style: TextStyle(color: Colors.white),
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

InputDecoration _inputDecoration(String label) {
  return InputDecoration(
    labelText: label,
    border: const OutlineInputBorder(borderRadius: BorderRadius.zero),
  );
}