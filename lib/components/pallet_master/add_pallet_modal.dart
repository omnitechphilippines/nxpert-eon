import 'package:flutter/material.dart';
import 'package:quickalert/quickalert.dart';
import '../../../pages/settings/pallet_master/models/pallet_model.dart';
import '../../../pages/settings/pallet_master/controllers/pallet_master_controller.dart';

void showAddPalletModal(BuildContext context, VoidCallback onPalletAdded) {
  final TextEditingController codeController = TextEditingController();
  final TextEditingController colorController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  final PalletMasterController _controller = PalletMasterController();
  String? selectedCategory;

  bool areFieldsValid() {
    if (codeController.text.trim().isEmpty ||
        selectedCategory == null ||
        colorController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all required fields')),
      );
      return false;
    }
    return true;
  }

  showGeneralDialog(
    context: context,
    barrierDismissible: true,
    barrierLabel: "Add Pallet",
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
                if (!areFieldsValid()) return;

                setState(() => isLoading = true);

                final newPallet = Pallet(
                  palletCode: codeController.text.trim(),
                  palletDescription: descriptionController.text.trim(),
                  palletCategory: selectedCategory!,
                  palletColor: colorController.text.trim(),
                  palletStatus: 'A',
                );

                final success = await _controller.insertPallet(newPallet);

                if (!context.mounted) return;
                setState(() => isLoading = false);

                if (success) {
                  Navigator.pop(context);
                  onPalletAdded();
                  await QuickAlert.show(
                    context: context,
                    type: QuickAlertType.success,
                    title: 'Success',
                    text: 'Pallet successfully added!',
                  );
                } else {
                  await QuickAlert.show(
                    context: context,
                    type: QuickAlertType.error,
                    title: 'Error',
                    text: 'Failed to add pallet. Please try again.',
                  );
                }
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
                    'Add Pallet',
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
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              TextField(
                                controller: codeController,
                                decoration: const InputDecoration(
                                  labelText: 'Pallet Code',
                                  border: OutlineInputBorder(),
                                ),
                              ),
                              const SizedBox(height: 10),
                              TextField(
                                controller: descriptionController,
                                decoration: const InputDecoration(
                                  labelText: 'Description',
                                  border: OutlineInputBorder(),
                                ),
                              ),
                              const SizedBox(height: 10),
                              DropdownButtonFormField<String>(
                                value: selectedCategory,
                                decoration: const InputDecoration(
                                  labelText: 'Category',
                                  border: OutlineInputBorder(),
                                ),
                                items: const [
                                  DropdownMenuItem(
                                    value: 'R',
                                    child: Text('R'),
                                  ),
                                  DropdownMenuItem(
                                    value: 'K',
                                    child: Text('K'),
                                  ),
                                ],
                                onChanged: (value) {
                                  setState(() {
                                    selectedCategory = value;
                                  });
                                },
                              ),
                              const SizedBox(height: 10),
                              TextField(
                                controller: colorController,
                                decoration: const InputDecoration(
                                  labelText: 'Color',
                                  border: OutlineInputBorder(),
                                ),
                              ),
                            ],
                          ),
                        ),
                actions:
                    isLoading
                        ? []
                        : <Widget>[
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
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
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
