import 'package:flutter/material.dart';
import 'package:quickalert/quickalert.dart';
import '../../pages/settings/kanban_master/models/kanban_model.dart';
import '../../pages/settings/kanban_master/controllers/kanban_master_controller.dart';

void showUpdateKanbanModal(
  BuildContext context,
  Kanban kanban,
  void Function(Kanban updatedKanban) onUpdate,
) {
  final descController = TextEditingController(
    text: kanban.kanbanDescription ?? '',
  );
  final capacityController = TextEditingController(
    text: kanban.kanbanCapacity?.toString() ?? '',
  );
  final remarksController = TextEditingController(
    text: kanban.kanbanRemarks ?? '',
  );

  String? selectedPartNo = kanban.kanbanPartNo;
  String? selectedLocator = kanban.kanbanDefaultLocator;

  final controller = KanbanMasterController();
  bool isLoading = false;

  showGeneralDialog(
    context: context,
    barrierDismissible: true,
    barrierLabel: "Update Kanban",
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

                final updated = Kanban(
                  kanbanId: kanban.kanbanId,
                  kanbanPartNo: selectedPartNo,
                  kanbanDescription: descController.text.trim(),
                  kanbanCapacity: capacityController.text.trim(),
                  kanbanDefaultLocator: selectedLocator,
                  kanbanRemarks: remarksController.text.trim(),
                );

                final success = await controller.updateKanban(
                  kanbanId: kanban.kanbanId ?? '',
                  kanbanDescription:
                      updated.kanbanDescription != kanban.kanbanDescription
                          ? updated.kanbanDescription
                          : null,
                  kanbanCapacity:
                      updated.kanbanCapacity != kanban.kanbanCapacity
                          ? updated.kanbanCapacity
                          : null,
                  kanbanDefaultLocator:
                      updated.kanbanDefaultLocator !=
                              kanban.kanbanDefaultLocator
                          ? updated.kanbanDefaultLocator
                          : null,
                  kanbanRemarks:
                      updated.kanbanRemarks != kanban.kanbanRemarks
                          ? updated.kanbanRemarks
                          : null,
                  kanbanPartNo:
                      updated.kanbanPartNo != kanban.kanbanPartNo
                          ? updated.kanbanPartNo
                          : null,
                );

                if (!context.mounted) return;
                Navigator.of(context, rootNavigator: true).pop();

                if (success) {
                  onUpdate(updated);
                  await QuickAlert.show(
                    context: context,
                    type: QuickAlertType.success,
                    title: 'Success',
                    text: 'Kanban successfully updated!',
                  );
                } else {
                  await QuickAlert.show(
                    context: context,
                    type: QuickAlertType.error,
                    title: 'Error',
                    text: 'Failed to update Kanban. Please try again.',
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
                    'Update Kanban',
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
                                    value: 'CH3',
                                    child: Text('CH3'),
                                  ),
                                  DropdownMenuItem(
                                    value: 'CL3',
                                    child: Text('CL3'),
                                  ),
                                ],
                                onChanged:
                                    (value) =>
                                        setState(() => selectedPartNo = value),
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
                                value: selectedLocator,
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
                                    (value) =>
                                        setState(() => selectedLocator = value),
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
