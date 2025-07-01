import 'package:flutter/material.dart';
import 'package:quickalert/quickalert.dart';
import '../../pages/settings/kanban_master/controllers/kanban_master_controller.dart';
import '../../pages/settings/kanban_master/models/kanban_model.dart';

void showAddKanbanModal(BuildContext context, VoidCallback onKanbanAdded) {
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController capacityController = TextEditingController();
  final TextEditingController remarksController = TextEditingController();

  String? selectedPartNo;
  String? selectedDefaultLocator;

  final controller = KanbanMasterController();

  bool areFieldsValid() {
    if (selectedPartNo == null ||
        descriptionController.text.trim().isEmpty ||
        capacityController.text.trim().isEmpty ||
        selectedDefaultLocator == null ||
        remarksController.text.trim().isEmpty) {
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
    barrierLabel: "Add Kanban",
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

                final success = await controller.insertKanban(
                  Kanban(
                    kanbanPartNo: selectedPartNo!,
                    kanbanDescription: descriptionController.text.trim(),
                    kanbanCapacity: capacityController.text.trim(),
                    kanbanDefaultLocator: selectedDefaultLocator!,
                    kanbanRemarks: remarksController.text.trim(),
                  ),
                );

                if (!context.mounted) return;
                setState(() => isLoading = false);
                Navigator.pop(context);

                if (success) {
                  onKanbanAdded();
                  await QuickAlert.show(
                    context: context,
                    type: QuickAlertType.success,
                    title: 'Success',
                    text: 'Kanban successfully added!',
                  );
                } else {
                  await QuickAlert.show(
                    context: context,
                    type: QuickAlertType.error,
                    title: 'Error',
                    text: 'Failed to add Kanban. Please try again.',
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
                    'Add Kanban',
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
                              DropdownButtonFormField<String>(
                                value: selectedPartNo,
                                decoration: const InputDecoration(
                                  labelText: 'Part No',
                                  border: OutlineInputBorder(),
                                ),
                                items: const [
                                  DropdownMenuItem(
                                    value: '8972787453',
                                    child: Text('CH3'),
                                  ),
                                  DropdownMenuItem(
                                    value: 'CL3',
                                    child: Text('8972787463'),
                                  ),
                                ],
                                onChanged:
                                    (value) =>
                                        setState(() => selectedPartNo = value),
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
                              TextField(
                                controller: capacityController,
                                keyboardType: TextInputType.number,
                                decoration: const InputDecoration(
                                  labelText: 'Capacity',
                                  border: OutlineInputBorder(),
                                ),
                              ),
                              const SizedBox(height: 10),
                              DropdownButtonFormField<String>(
                                value: selectedDefaultLocator,
                                decoration: const InputDecoration(
                                  labelText: 'Default Locator',
                                  border: OutlineInputBorder(),
                                ),
                                items: const [
                                  DropdownMenuItem(
                                    value: 'm-0001',
                                    child: Text('m-0001'),
                                  ),
                                  DropdownMenuItem(
                                    value: 'a-0001',
                                    child: Text('a-0001'),
                                  ),
                                ],
                                onChanged:
                                    (value) => setState(
                                      () => selectedDefaultLocator = value,
                                    ),
                              ),
                              const SizedBox(height: 10),
                              TextField(
                                controller: remarksController,
                                decoration: const InputDecoration(
                                  labelText: 'Remarks',
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
