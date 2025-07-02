import 'package:flutter/material.dart';
import '../../pages/settings/product_master/models/product_model.dart';

void showAddProductModal(BuildContext context, Function(Product) onAddProduct) {
  final productCodeController = TextEditingController();
  final nameController = TextEditingController();
  final specificationController = TextEditingController();
  final internalCodeController = TextEditingController();
  final regDateController = TextEditingController();
  final minLotSizeController = TextEditingController();
  final maxLotSizeController = TextEditingController();
  final prodLeadTimeController = TextEditingController();
  final userLoginController = TextEditingController();

  String? selectedCostCenter = 'CC001';
  String? selectedCategory = 'G';
  String? selectedSource = 'M';
  bool requireCPO = false;
  String? selectedUnit = 'PCS';
  String? selectedBMStatus = 'A';
  bool hasCurMthSched = false;
  bool hasNxtMthSched = false;
  String? selectedPSGroupCode = '0';
  String? selectedLeadTimeUnit = 'H';

  bool areFieldsValid() {
    return productCodeController.text.trim().isNotEmpty &&
        nameController.text.trim().isNotEmpty &&
        specificationController.text.trim().isNotEmpty &&
        internalCodeController.text.trim().isNotEmpty &&
        regDateController.text.trim().isNotEmpty &&
        userLoginController.text.trim().isNotEmpty;
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
          child: StatefulBuilder(
            builder: (context, setState) {
              bool isLoading = false;

              Future<void> submitForm() async {
                if (!areFieldsValid()) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Please fill in all required fields'),
                    ),
                  );
                  return;
                }

                setState(() => isLoading = true);

                final product = Product(
                  productCode: productCodeController.text.trim(),
                  productName: nameController.text.trim(),
                  productSpecification: specificationController.text.trim(),
                  productInternalCode: internalCodeController.text.trim(),
                  costCenterCode: selectedCostCenter,
                  prodRegDate: DateTime.tryParse(regDateController.text.trim()),
                  prodCategory: selectedCategory!,
                  prodSource: selectedSource!,
                  requireCPO: requireCPO,
                  productUnit: selectedUnit!,
                  bmStatus: selectedBMStatus,
                  hasCurMthSched: hasCurMthSched,
                  hasNxtMthSched: hasNxtMthSched,
                  psGroupCode: selectedPSGroupCode!,
                  minLotSize: int.tryParse(minLotSizeController.text),
                  maxLotSize: int.tryParse(maxLotSizeController.text),
                  prodLeadTime: double.tryParse(prodLeadTimeController.text),
                  leadTimeUnit: selectedLeadTimeUnit!,
                  status: 'A',
                  userLogin: 'test',
                  ludatetime: DateTime.now(),
                );

                await Future.delayed(const Duration(milliseconds: 500));
                if (!context.mounted) return;

                setState(() => isLoading = false);
                Navigator.pop(context);
                onAddProduct(product);
              }

              return AlertDialog(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.zero,
                ),
                titlePadding: EdgeInsets.zero,
                title: Container(
                  padding: const EdgeInsets.all(16),
                  color: Colors.blue,
                  child: const Text(
                    'Add Product',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                content:
                    isLoading
                        ? const SizedBox(
                          height: 150,
                          child: Center(child: CircularProgressIndicator()),
                        )
                        : SizedBox(
                          width: 500,
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                TextField(
                                  controller: productCodeController,
                                  decoration: const InputDecoration(
                                    labelText: 'Product Code',
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                TextField(
                                  controller: nameController,
                                  decoration: const InputDecoration(
                                    labelText: 'Product Name',
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                TextField(
                                  controller: specificationController,
                                  decoration: const InputDecoration(
                                    labelText: 'Product Specification',
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                TextField(
                                  controller: internalCodeController,
                                  decoration: const InputDecoration(
                                    labelText: 'Internal Product Code',
                                    border: OutlineInputBorder(),
                                  ),
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
                                              primary:
                                                  Colors
                                                      .blue, // header background
                                              onPrimary:
                                                  Colors.white, // header text
                                              onSurface:
                                                  Colors
                                                      .black, // default text color
                                            ),
                                            textButtonTheme: TextButtonThemeData(
                                              style: TextButton.styleFrom(
                                                foregroundColor:
                                                    Colors
                                                        .blue, // button text color
                                              ),
                                            ),
                                          ),
                                          child: child!,
                                        );
                                      },
                                    );

                                    if (pickedDate != null) {
                                      regDateController.text =
                                          pickedDate
                                              .toIso8601String()
                                              .split('T')
                                              .first;
                                    }
                                  },
                                ),

                                const SizedBox(height: 10),
                                DropdownButtonFormField<String>(
                                  value: selectedCategory,
                                  decoration: const InputDecoration(
                                    labelText: 'Product Category',
                                    border: OutlineInputBorder(),
                                  ),
                                  items: const [
                                    DropdownMenuItem(
                                      value: 'G',
                                      child: Text('G - Goods'),
                                    ),
                                    DropdownMenuItem(
                                      value: 'S',
                                      child: Text('S - Services'),
                                    ),
                                  ],
                                  onChanged:
                                      (val) => setState(
                                        () => selectedCategory = val,
                                      ),
                                ),
                                const SizedBox(height: 10),
                                DropdownButtonFormField<String>(
                                  value: selectedSource,
                                  decoration: const InputDecoration(
                                    labelText: 'Product Source',
                                    border: OutlineInputBorder(),
                                  ),
                                  items: const [
                                    DropdownMenuItem(
                                      value: 'M',
                                      child: Text('M - Manufacturing'),
                                    ),
                                  ],
                                  onChanged:
                                      (val) =>
                                          setState(() => selectedSource = val),
                                ),
                                const SizedBox(height: 10),
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.grey,
                                    ), // border similar to OutlineInputBorder
                                    borderRadius: BorderRadius.circular(
                                      4,
                                    ), // match TextField border radius
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 4,
                                  ),
                                  child: SwitchListTile(
                                    contentPadding: EdgeInsets.zero,
                                    title: const Text('Require CPO'),
                                    value: requireCPO,
                                    onChanged:
                                        (val) =>
                                            setState(() => requireCPO = val),
                                  ),
                                ),
                                const SizedBox(height: 10),

                                DropdownButtonFormField<String>(
                                  value: selectedUnit,
                                  decoration: const InputDecoration(
                                    labelText: 'Product Unit',
                                    border: OutlineInputBorder(),
                                  ),
                                  items: const [
                                    DropdownMenuItem(
                                      value: 'PCS',
                                      child: Text('PCS - Pieces'),
                                    ),
                                  ],
                                  onChanged:
                                      (val) =>
                                          setState(() => selectedUnit = val),
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
                                    title: const Text(
                                      'Has Current Month Schedule',
                                    ),
                                    value: hasCurMthSched,
                                    onChanged:
                                        (val) => setState(
                                          () => hasCurMthSched = val,
                                        ),
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
                                    title: const Text(
                                      'Has Next Month Schedule',
                                    ),
                                    value: hasNxtMthSched,
                                    onChanged:
                                        (val) => setState(
                                          () => hasNxtMthSched = val,
                                        ),
                                  ),
                                ),
                                const SizedBox(height: 10),

                                DropdownButtonFormField<String>(
                                  value: selectedPSGroupCode,
                                  decoration: const InputDecoration(
                                    labelText: 'PS Group Code',
                                    border: OutlineInputBorder(),
                                  ),
                                  items: const [
                                    DropdownMenuItem(
                                      value: '0',
                                      child: Text('0'),
                                    ),
                                  ],
                                  onChanged:
                                      (val) => setState(
                                        () => selectedPSGroupCode = val,
                                      ),
                                ),
                                const SizedBox(height: 10),
                                TextField(
                                  controller: minLotSizeController,
                                  keyboardType: TextInputType.number,
                                  decoration: const InputDecoration(
                                    labelText: 'Min Lot Size',
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                TextField(
                                  controller: maxLotSizeController,
                                  keyboardType: TextInputType.number,
                                  decoration: const InputDecoration(
                                    labelText: 'Max Lot Size',
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                TextField(
                                  controller: prodLeadTimeController,
                                  keyboardType:
                                      const TextInputType.numberWithOptions(
                                        decimal: true,
                                      ),
                                  decoration: const InputDecoration(
                                    labelText: 'Product Lead Time',
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                DropdownButtonFormField<String>(
                                  value: selectedLeadTimeUnit,
                                  decoration: const InputDecoration(
                                    labelText: 'Lead Time Unit',
                                    border: OutlineInputBorder(),
                                  ),
                                  items: const [
                                    DropdownMenuItem(
                                      value: 'H',
                                      child: Text('H - Hours'),
                                    ),
                                    DropdownMenuItem(
                                      value: 'M',
                                      child: Text('M - Minutes'),
                                    ),
                                    DropdownMenuItem(
                                      value: 'S',
                                      child: Text('S - Seconds'),
                                    ),
                                  ],
                                  onChanged:
                                      (val) => setState(
                                        () => selectedLeadTimeUnit = val,
                                      ),
                                ),
                                const SizedBox(height: 10),

                                TextField(
                                  controller: userLoginController,
                                  decoration: const InputDecoration(
                                    labelText: 'User Login',
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                actions:
                    isLoading
                        ? []
                        : [
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
                              'Submit',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
              );
            },
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
