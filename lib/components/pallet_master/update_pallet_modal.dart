import 'package:flutter/material.dart';
import 'package:quickalert/quickalert.dart';
import '../../pages/settings/pallet_master/models/pallet_model.dart';
import '../../pages/settings/pallet_master/controllers/pallet_master_controller.dart';

void showUpdatePalletModal(
  BuildContext context,
  Pallet pallet,
  void Function(Pallet updatedPallet) onUpdate,
) {
  final controller = PalletMasterController();

  final TextEditingController descController = TextEditingController(text: pallet.palletDescription);
  final TextEditingController colorController = TextEditingController(text: pallet.palletColor);

  String? selectedCategory = pallet.palletCategory;
  String? selectedStatus = pallet.palletStatus;

  Future<void> submitForm() async {
    final newDesc = descController.text.trim();
    final newColor = colorController.text.trim();

    QuickAlert.show(
      context: context,
      type: QuickAlertType.loading,
      title: 'Please wait',
      text: 'Updating pallet...',
      barrierDismissible: false,
    );

    final success = await controller.updatePallet(
      palletCode: pallet.palletCode!,
      palletDescription: newDesc != pallet.palletDescription ? newDesc : null,
      palletColor: newColor != pallet.palletColor ? newColor : null,
      palletCategory: selectedCategory != pallet.palletCategory ? selectedCategory : null,
      palletStatus: selectedStatus != pallet.palletStatus ? selectedStatus : null,
    );

    if (!context.mounted) return;
    Navigator.pop(context); // close loading

    if (success) {
      Navigator.pop(context); // close modal
      onUpdate(Pallet(
        palletCode: pallet.palletCode,
        palletDescription: newDesc,
        palletColor: newColor,
        palletCategory: selectedCategory,
        palletStatus: selectedStatus,
      ));
      await QuickAlert.show(
        context: context,
        type: QuickAlertType.success,
        title: 'Success',
        text: 'Pallet successfully updated!',
      );
    } else {
      await QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        title: 'Error',
        text: 'Failed to update pallet. Please try again.',
      );
    }
  }

  showGeneralDialog(
    context: context,
    barrierDismissible: true,
    barrierLabel: "Update Pallet",
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
                'Update Pallet',
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
            content: SizedBox(
              width: 500,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  TextField(
                    controller: descController,
                    decoration: const InputDecoration(
                      labelText: 'Description',
                      border: OutlineInputBorder(borderRadius: BorderRadius.zero),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: colorController,
                    decoration: const InputDecoration(
                      labelText: 'Color',
                      border: OutlineInputBorder(borderRadius: BorderRadius.zero),
                    ),
                  ),
                  const SizedBox(height: 10),
                  DropdownButtonFormField<String>(
                    value: selectedCategory,
                    items: const [
                      DropdownMenuItem(value: 'R', child: Text('R')),
                      DropdownMenuItem(value: 'K', child: Text('K')),
                    ],
                    onChanged: (value) {
                      selectedCategory = value;
                    },
                    decoration: const InputDecoration(
                      labelText: 'Category',
                      border: OutlineInputBorder(borderRadius: BorderRadius.zero),
                    ),
                  ),
                  const SizedBox(height: 10),
                  DropdownButtonFormField<String>(
                    value: selectedStatus,
                    items: const [
                      DropdownMenuItem(value: 'A', child: Text('A')),
                      DropdownMenuItem(value: 'F', child: Text('F')),
                      DropdownMenuItem(value: 'N', child: Text('N')),
                    ],
                    onChanged: (value) {
                      selectedStatus = value;
                    },
                    decoration: const InputDecoration(
                      labelText: 'Status',
                      border: OutlineInputBorder(borderRadius: BorderRadius.zero),
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                ),
                child: const Text('Cancel', style: TextStyle(color: Colors.white)),
              ),
              ElevatedButton(
                onPressed: submitForm,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                ),
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
