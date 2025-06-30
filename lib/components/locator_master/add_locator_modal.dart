import 'package:flutter/material.dart';
import 'package:quickalert/quickalert.dart';
import '../../../pages/settings/locator_master/models/locator_model.dart';
import '../../../pages/settings/locator_master/controllers/locator_master_controller.dart';

void showAddLocatorModal(BuildContext context, VoidCallback onLocatorAdded) {
  final TextEditingController codeController = TextEditingController();
  final TextEditingController descController = TextEditingController();
  final LocatorMasterController _controller = LocatorMasterController();

  String? selectedOccupancyStatus;
  String? selectedStatus;
  String? selectedWarehouseCode;
  String? selectedArea;
  String? selectedLocatorType;

  bool areFieldsValid() {
    if (codeController.text.trim().isEmpty ||
        descController.text.trim().isEmpty ||
        selectedLocatorType == null ||
        selectedArea == null ||
        selectedOccupancyStatus == null ||
        selectedStatus == null ||
        selectedWarehouseCode == null) {
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
    barrierLabel: "Add Locator",
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

                final newLocator = Locator(
                  locatorCode: codeController.text.trim(),
                  locatorDesc: descController.text.trim(),
                  locatorType: selectedLocatorType,
                  locatorArea: selectedArea,
                  locatorOccupancyStatus: selectedOccupancyStatus,
                  locatorStatus: selectedStatus,
                  locatorWarehouseCode: selectedWarehouseCode,
                  userLogin: 'test',
                  ludatetime: DateTime.now().toString(),
                );
                print(newLocator.locatorWarehouseCode);

                final success = await _controller.insertLocator(newLocator);

                if (!context.mounted) return;
                setState(() => isLoading = false);

                if (success) {
                  Navigator.pop(context);
                  onLocatorAdded();
                  await QuickAlert.show(
                    context: context,
                    type: QuickAlertType.success,
                    title: 'Success',
                    text: 'Locator successfully added!',
                  );
                } else {
                  await QuickAlert.show(
                    context: context,
                    type: QuickAlertType.error,
                    title: 'Error',
                    text: 'Failed to add locator. Please try again.',
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
                    'Add Locator',
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
                                  labelText: 'Locator Code',
                                  border: OutlineInputBorder(),
                                ),
                              ),
                              const SizedBox(height: 10),
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
                                decoration: const InputDecoration(
                                  labelText: 'Locator Type',
                                  border: OutlineInputBorder(),
                                ),
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
                                onChanged: (value) {
                                  setState(() {
                                    selectedLocatorType = value;
                                  });
                                },
                              ),
                              const SizedBox(height: 10),
                              DropdownButtonFormField<String>(
                                value: selectedArea,
                                decoration: const InputDecoration(
                                  labelText: 'Area',
                                  border: OutlineInputBorder(),
                                ),
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
                                onChanged: (value) {
                                  setState(() {
                                    selectedArea = value;
                                  });
                                },
                              ),
                              const SizedBox(height: 10),
                              DropdownButtonFormField<String>(
                                value: selectedOccupancyStatus,
                                decoration: const InputDecoration(
                                  labelText: 'Occupancy',
                                  border: OutlineInputBorder(),
                                ),
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
                                onChanged: (value) {
                                  setState(() {
                                    selectedOccupancyStatus = value;
                                  });
                                },
                              ),
                              const SizedBox(height: 10),
                              DropdownButtonFormField<String>(
                                value: selectedStatus,
                                decoration: const InputDecoration(
                                  labelText: 'Status',
                                  border: OutlineInputBorder(),
                                ),
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
                                onChanged: (value) {
                                  setState(() {
                                    selectedStatus = value;
                                  });
                                },
                              ),
                              const SizedBox(height: 10),
                              DropdownButtonFormField<String>(
                                value: selectedWarehouseCode,
                                decoration: const InputDecoration(
                                  labelText: 'Warehouse',
                                  border: OutlineInputBorder(),
                                ),
                                items: const [
                                  DropdownMenuItem(
                                    value: '000',
                                    child: Text('000'),
                                  ),
                                  DropdownMenuItem(
                                    value: 'PRD',
                                    child: Text('PRD'),
                                  ),
                                ],
                                onChanged: (value) {
                                  setState(() {
                                    selectedWarehouseCode = value;
                                  });
                                },
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
