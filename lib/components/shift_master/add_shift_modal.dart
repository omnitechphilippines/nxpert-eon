import 'package:flutter/material.dart';
import 'package:quickalert/quickalert.dart';

void showAddShiftModal(
  BuildContext context,
  void Function(Map<String, dynamic>) onShiftAdded,
) {
  final TextEditingController codeController = TextEditingController();
  final TextEditingController timeInController = TextEditingController();
  final TextEditingController breakStartController = TextEditingController();
  final TextEditingController breakEndController = TextEditingController();
  final TextEditingController timeOutController = TextEditingController();
  final TextEditingController descController = TextEditingController();

  String? shiftType;
  String? shiftStatus;
  const String userLogin = 'test';

  TimeOfDay? timeIn;
  TimeOfDay? breakStart;
  TimeOfDay? breakEnd;
  TimeOfDay? timeOut;

  Future<void> pickTime(
    BuildContext context,
    TextEditingController controller,
    Function(TimeOfDay) onPicked,
  ) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      controller.text = picked.format(context);
      onPicked(picked);
    }
  }

  bool areFieldsValid() {
    if (codeController.text.trim().isEmpty ||
        descController.text.trim().isEmpty ||
        shiftType == null ||
        timeIn == null ||
        timeOut == null ||
        shiftStatus == null) {
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
    barrierLabel: "Add Shift",
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

                await Future.delayed(
                  const Duration(milliseconds: 500),
                ); // Simulated delay

                if (!context.mounted) return;
                setState(() => isLoading = false);
                Navigator.pop(context);

                onShiftAdded({
                  'shiftCode': codeController.text.trim(),
                  'shiftDescription': descController.text.trim(),
                  'shiftType': shiftType,
                  'timeIn': timeIn,
                  'breakStart': breakStart,
                  'breakEnd': breakEnd,
                  'timeOut': timeOut,
                  'status': shiftStatus,
                  'user': userLogin,
                });

                await QuickAlert.show(
                  context: context,
                  type: QuickAlertType.success,
                  title: 'Success',
                  text: 'Shift successfully added!',
                );
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
                    'Add Shift',
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
                                controller: codeController,
                                decoration: const InputDecoration(
                                  labelText: 'Shift Code',
                                  border: OutlineInputBorder(),
                                ),
                              ),
                              const SizedBox(height: 10),
                              TextField(
                                controller: descController,
                                decoration: const InputDecoration(
                                  labelText: 'Shift Description',
                                  border: OutlineInputBorder(),
                                ),
                              ),
                              const SizedBox(height: 10),

                              DropdownButtonFormField<String>(
                                value: shiftType,
                                decoration: const InputDecoration(
                                  labelText: 'Shift Type',
                                  border: OutlineInputBorder(),
                                ),
                                items: const [
                                  DropdownMenuItem(
                                    value: 'D',
                                    child: Text('D'),
                                  ),
                                  DropdownMenuItem(
                                    value: 'S',
                                    child: Text('S'),
                                  ),
                                  DropdownMenuItem(
                                    value: 'G',
                                    child: Text('G'),
                                  ),
                                ],
                                onChanged: (value) {
                                  setState(() => shiftType = value);
                                },
                              ),
                              const SizedBox(height: 10),
                              TextField(
                                controller: timeInController,
                                readOnly: true,
                                decoration: const InputDecoration(
                                  labelText: 'Time In',
                                  border: OutlineInputBorder(),
                                ),
                                onTap:
                                    () => pickTime(
                                      context,
                                      timeInController,
                                      (picked) => timeIn = picked,
                                    ),
                              ),
                              const SizedBox(height: 10),
                              TextField(
                                controller: breakStartController,
                                readOnly: true,
                                decoration: const InputDecoration(
                                  labelText: 'Break Start',
                                  border: OutlineInputBorder(),
                                ),
                                onTap:
                                    () => pickTime(
                                      context,
                                      breakStartController,
                                      (picked) => breakStart = picked,
                                    ),
                              ),
                              const SizedBox(height: 10),
                              TextField(
                                controller: breakEndController,
                                readOnly: true,
                                decoration: const InputDecoration(
                                  labelText: 'Break End',
                                  border: OutlineInputBorder(),
                                ),
                                onTap:
                                    () => pickTime(
                                      context,
                                      breakEndController,
                                      (picked) => breakEnd = picked,
                                    ),
                              ),
                              const SizedBox(height: 10),
                              TextField(
                                controller: timeOutController,
                                readOnly: true,
                                decoration: const InputDecoration(
                                  labelText: 'Time Out',
                                  border: OutlineInputBorder(),
                                ),
                                onTap:
                                    () => pickTime(
                                      context,
                                      timeOutController,
                                      (picked) => timeOut = picked,
                                    ),
                              ),
                              const SizedBox(height: 10),
                              DropdownButtonFormField<String>(
                                value: shiftStatus,
                                decoration: const InputDecoration(
                                  labelText: 'Shift Status',
                                  border: OutlineInputBorder(),
                                ),
                                items: const [
                                  DropdownMenuItem(
                                    value: 'A',
                                    child: Text('Active'),
                                  ),
                                  DropdownMenuItem(
                                    value: 'I',
                                    child: Text('Inactive'),
                                  ),
                                ],
                                onChanged: (value) {
                                  setState(() => shiftStatus = value);
                                },
                              ),
                              const SizedBox(height: 10),
                              TextField(
                                readOnly: true,
                                controller: TextEditingController(
                                  text: userLogin,
                                ),
                                decoration: const InputDecoration(
                                  labelText: 'User Login',
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
                              'Submit',
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
