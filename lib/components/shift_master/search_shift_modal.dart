import 'package:flutter/material.dart';

void showSearchShiftModal(
  BuildContext context,
  void Function(Map<String, dynamic>) onSearch, {
  VoidCallback? onReset,
}) {
  final TextEditingController codeController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  String? shiftType;
  String? shiftStatus;

  showGeneralDialog(
    context: context,
    barrierDismissible: true,
    barrierLabel: "Search Shift",
    barrierColor: Colors.black.withOpacity(0.3),
    transitionDuration: const Duration(milliseconds: 300),
    pageBuilder: (_, __, ___) {
      return Center(
        child: Material(
          color: Colors.transparent,
          child: StatefulBuilder(
            builder: (context, setState) {
              void submitForm() {
                final searchParams = {
                  'shiftCode': codeController.text.trim(),
                  'shiftDescription': descriptionController.text.trim(),
                  'shiftType': shiftType,
                  'shiftStatus': shiftStatus,
                };
                Navigator.pop(context);
                onSearch(searchParams);
              }

              void resetForm() {
                Navigator.pop(context);
                if (onReset != null) {
                  onReset();
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
                    'Search Shift',
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
                        controller: descriptionController,
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
                          DropdownMenuItem(value: 'D', child: Text('D')),
                          DropdownMenuItem(value: 'S', child: Text('S')),
                          DropdownMenuItem(value: 'G', child: Text('G')),
                        ],
                        onChanged: (value) => setState(() => shiftType = value),
                      ),
                      const SizedBox(height: 10),
                      DropdownButtonFormField<String>(
                        value: shiftStatus,
                        decoration: const InputDecoration(
                          labelText: 'Shift Status',
                          border: OutlineInputBorder(),
                        ),
                        items: const [
                          DropdownMenuItem(value: 'A', child: Text('Active')),
                          DropdownMenuItem(value: 'I', child: Text('Inactive')),
                        ],
                        onChanged:
                            (value) => setState(() => shiftStatus = value),
                      ),
                    ],
                  ),
                ),
                actionsPadding: const EdgeInsets.all(16),
                actions: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Cancel on the left
                      ElevatedButton(
                        onPressed: () => Navigator.pop(context),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey.shade600,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.zero,
                          ),
                        ),
                        child: const Text(
                          'Cancel',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),

                      // Reset + Search on the right
                      Row(
                        children: [
                          ElevatedButton(
                            onPressed: resetForm,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.zero,
                              ),
                            ),
                            child: const Text(
                              'Reset',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          const SizedBox(width: 8),
                          ElevatedButton(
                            onPressed: submitForm,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.zero,
                              ),
                            ),
                            child: const Text(
                              'Search',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ],
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
