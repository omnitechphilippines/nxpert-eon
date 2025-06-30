import 'package:flutter/material.dart';
import 'package:quickalert/quickalert.dart';
import '../../pages/settings/locator_master/models/locator_model.dart';
import '../../pages/settings/locator_master/controllers/locator_master_controller.dart';

void showUpdateLocatorModal(
  BuildContext context,
  Locator locator,
  void Function(Locator updatedLocator) onUpdate,
) {
  final controller = LocatorMasterController();

  final TextEditingController descController = TextEditingController(
    text: locator.locatorDesc,
  );
  final TextEditingController typeController = TextEditingController(
    text: locator.locatorType,
  );
  final TextEditingController areaController = TextEditingController(
    text: locator.locatorArea,
  );
  final TextEditingController userLoginController = TextEditingController(
    text: locator.userLogin,
  );
  final TextEditingController luDatetimeController = TextEditingController(
    text: locator.ludatetime,
  );

  String? selectedOccupancyStatus = locator.locatorOccupancyStatus;
  String? selectedStatus = locator.locatorStatus;

  Future<void> submitForm() async {
    final newDesc = descController.text.trim();
    final newType = typeController.text.trim();
    final newArea = areaController.text.trim();
    final newUserLogin = userLoginController.text.trim();
    final newLuDatetime = luDatetimeController.text.trim();

    QuickAlert.show(
      context: context,
      type: QuickAlertType.loading,
      title: 'Please wait',
      text: 'Updating locator...',
      barrierDismissible: false,
    );

    final success = await controller.updateLocator(
      locatorCode: locator.locatorCode ?? '', 
      locatorDesc: newDesc != locator.locatorDesc ? newDesc : null,
      locatorType: newType != locator.locatorType ? newType : null,
      locatorArea: newArea != locator.locatorArea ? newArea : null,
      locatorOccupancyStatus:
          selectedOccupancyStatus != locator.locatorOccupancyStatus
              ? selectedOccupancyStatus
              : null,
      locatorStatus:
          selectedStatus != locator.locatorStatus ? selectedStatus : null,
      userLogin: newUserLogin != locator.userLogin ? newUserLogin : null,
      luDatetime: newLuDatetime != locator.ludatetime ? newLuDatetime : null,
    );

    if (!context.mounted) return;
    Navigator.pop(context); // close loading

    if (success) {
      Navigator.pop(context); // close modal
      onUpdate(
        Locator(
          locatorCode: locator.locatorCode,
          locatorDesc: newDesc,
          locatorType: newType,
          locatorArea: newArea,
          locatorOccupancyStatus: selectedOccupancyStatus,
          locatorStatus: selectedStatus,
          userLogin: newUserLogin,
          ludatetime: newLuDatetime,
        ),
      );
      await QuickAlert.show(
        context: context,
        type: QuickAlertType.success,
        title: 'Success',
        text: 'Locator successfully updated!',
      );
    } else {
      await QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        title: 'Error',
        text: 'Failed to update locator. Please try again.',
      );
    }
  }

  showGeneralDialog(
    context: context,
    barrierDismissible: true,
    barrierLabel: "Update Locator",
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
                'Update Locator',
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
                    controller: descController,
                    decoration: const InputDecoration(
                      labelText: 'Description',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.zero,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: typeController,
                    decoration: const InputDecoration(
                      labelText: 'Locator Type',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.zero,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: areaController,
                    decoration: const InputDecoration(
                      labelText: 'Locator Area',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.zero,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  DropdownButtonFormField<String>(
                    value: selectedOccupancyStatus,
                    items: const [
                      DropdownMenuItem(
                        value: 'Occupied',
                        child: Text('Occupied'),
                      ),
                      DropdownMenuItem(value: 'Vacant', child: Text('Vacant')),
                    ],
                    onChanged: (value) {
                      selectedOccupancyStatus = value;
                    },
                    decoration: const InputDecoration(
                      labelText: 'Occupancy Status',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.zero,
                      ),
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
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.zero,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: userLoginController,
                    decoration: const InputDecoration(
                      labelText: 'User Login',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.zero,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: luDatetimeController,
                    decoration: const InputDecoration(
                      labelText: 'Last Updated',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.zero,
                      ),
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
