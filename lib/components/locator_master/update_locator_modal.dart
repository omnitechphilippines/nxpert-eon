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

  final descController = TextEditingController(text: locator.locatorDesc ?? '');

  String? selectedLocatorType = locator.locatorType;
  String? selectedArea = locator.locatorArea;
  String? selectedOccupancyStatus = locator.locatorOccupancyStatus;
  String? selectedStatus = locator.locatorStatus;

  bool isLoading = false;

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
          child: StatefulBuilder(
            builder: (context, setState) {
              Future<void> submitForm() async {
                setState(() => isLoading = true);

                final updated = Locator(
                  locatorCode: locator.locatorCode,
                  locatorDesc: descController.text.trim(),
                  locatorType: selectedLocatorType,
                  locatorArea: selectedArea,
                  locatorOccupancyStatus: selectedOccupancyStatus,
                  locatorStatus: selectedStatus,
                  userLogin: locator.userLogin,
                  ludatetime: locator.ludatetime,
                );

                final success = await controller.updateLocator(
                  locatorCode: locator.locatorCode ?? '',
                  locatorDesc:
                      updated.locatorDesc != locator.locatorDesc
                          ? updated.locatorDesc
                          : null,
                  locatorType:
                      updated.locatorType != locator.locatorType
                          ? updated.locatorType
                          : null,
                  locatorArea:
                      updated.locatorArea != locator.locatorArea
                          ? updated.locatorArea
                          : null,
                  locatorOccupancyStatus:
                      updated.locatorOccupancyStatus !=
                              locator.locatorOccupancyStatus
                          ? updated.locatorOccupancyStatus
                          : null,
                  locatorStatus:
                      updated.locatorStatus != locator.locatorStatus
                          ? updated.locatorStatus
                          : null,
                  userLogin: null,
                  luDatetime: null,
                );

                if (!context.mounted) return;

                // Safely close the dialog
                Navigator.of(context, rootNavigator: true).pop();

                if (success) {
                  onUpdate(updated);
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

              return AlertDialog(
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
                            children: [
                              TextField(
                                controller: descController,
                                decoration: const InputDecoration(
                                  labelText: 'Description',
                                  border: OutlineInputBorder(),
                                ),
                              ),
                              const SizedBox(height: 10),
                              DropdownButtonFormField<String>(
                                value: selectedLocatorType,
                                items: const [
                                  DropdownMenuItem(
                                    value: 'S',
                                    child: Text('S'),
                                  ),
                                  DropdownMenuItem(
                                    value: 'C',
                                    child: Text('C'),
                                  ),
                                  DropdownMenuItem(
                                    value: 'ADC',
                                    child: Text('ADC'),
                                  ),
                                ],
                                onChanged:
                                    (value) => setState(
                                      () => selectedLocatorType = value,
                                    ),
                                decoration: const InputDecoration(
                                  labelText: 'Locator Type',
                                  border: OutlineInputBorder(),
                                ),
                              ),
                              const SizedBox(height: 10),
                              DropdownButtonFormField<String>(
                                value: selectedArea,
                                items: const [
                                  DropdownMenuItem(
                                    value: 'IN',
                                    child: Text('IN'),
                                  ),
                                  DropdownMenuItem(
                                    value: 'OUT',
                                    child: Text('OUT'),
                                  ),
                                  DropdownMenuItem(
                                    value: 'N',
                                    child: Text('N'),
                                  ),
                                ],
                                onChanged:
                                    (value) =>
                                        setState(() => selectedArea = value),
                                decoration: const InputDecoration(
                                  labelText: 'Locator Area',
                                  border: OutlineInputBorder(),
                                ),
                              ),
                              const SizedBox(height: 10),
                              DropdownButtonFormField<String>(
                                value: selectedOccupancyStatus,
                                items: const [
                                  DropdownMenuItem(
                                    value: 'E',
                                    child: Text('E'),
                                  ),
                                  DropdownMenuItem(
                                    value: 'O',
                                    child: Text('O'),
                                  ),
                                  DropdownMenuItem(
                                    value: 'N',
                                    child: Text('N'),
                                  ),
                                ],
                                onChanged:
                                    (value) => setState(
                                      () => selectedOccupancyStatus = value,
                                    ),
                                decoration: const InputDecoration(
                                  labelText: 'Occupancy',
                                  border: OutlineInputBorder(),
                                ),
                              ),
                              const SizedBox(height: 10),
                              DropdownButtonFormField<String>(
                                value: selectedStatus,
                                items: const [
                                  DropdownMenuItem(
                                    value: 'A',
                                    child: Text('A'),
                                  ),
                                  DropdownMenuItem(
                                    value: 'F',
                                    child: Text('F'),
                                  ),
                                  DropdownMenuItem(
                                    value: 'N',
                                    child: Text('N'),
                                  ),
                                ],
                                onChanged:
                                    (value) =>
                                        setState(() => selectedStatus = value),
                                decoration: const InputDecoration(
                                  labelText: 'Status',
                                  border: OutlineInputBorder(),
                                ),
                              ),
                            ],
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
                              'Update',
                              style: TextStyle(color: Colors.white),
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
