import 'package:flutter/material.dart';

void showSearchKanbanModal(
  BuildContext context,
  Function({
    String? kanbanPartNo,
    String? kanbanDescription,
    String? kanbanCapacity,
    String? kanbanDefaultLocator,
    String? kanbanRemarks,
  })
  onSearch,
) {
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController capacityController = TextEditingController();
  final TextEditingController remarksController = TextEditingController();

  String? selectedPartNo;
  String? selectedLocator;

  showGeneralDialog(
    context: context,
    barrierDismissible: true,
    barrierLabel: "Search Kanban",
    barrierColor: Colors.black.withOpacity(0.3),
    transitionDuration: const Duration(milliseconds: 300),
    pageBuilder: (_, __, ___) {
      return Center(
        child: Material(
          color: Colors.transparent,
          child: StatefulBuilder(
            builder: (context, setState) {
              return AlertDialog(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.zero,
                ),
                titlePadding: EdgeInsets.zero,
                title: Container(
                  padding: const EdgeInsets.all(16),
                  color: Colors.blue,
                  child: const Text(
                    'Search Kanban',
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
                            value: '8972787463',
                            child: Text('CL3'),
                          ),
                        ],
                        onChanged: (value) {
                          setState(() {
                            selectedPartNo = value;
                          });
                        },
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
                        onChanged: (value) {
                          setState(() {
                            selectedLocator = value;
                          });
                        },
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
                actions: <Widget>[
                  ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey[700],
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero,
                      ),
                    ),
                    child: const Text(
                      'Close',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      onSearch();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero,
                      ),
                    ),
                    child: const Text(
                      'Reset',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      onSearch(
                        kanbanPartNo: selectedPartNo,
                        kanbanDescription:
                            descriptionController.text.trim().isEmpty
                                ? null
                                : descriptionController.text.trim(),
                        kanbanCapacity:
                            capacityController.text.trim().isEmpty
                                ? null
                                : capacityController.text.trim(),
                        kanbanDefaultLocator: selectedLocator,
                        kanbanRemarks:
                            remarksController.text.trim().isEmpty
                                ? null
                                : remarksController.text.trim(),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero,
                      ),
                    ),
                    child: const Text(
                      'Search',
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
