import 'package:flutter/material.dart';

void showSearchLocatorModal(
  BuildContext context,
  Function({
    String? locatorCode,
    String? locatorType,
    String? locatorArea,
    String? locatorOccupancyStatus,
    String? locatorStatus,
    String? userLogin,
  }) onSearch,
) {
  final TextEditingController codeController = TextEditingController();
  String? selectedType;
  String? selectedArea;
  String? selectedOccupancy;
  String? selectedStatus;
  String? selectedWarehouse;

  showGeneralDialog(
    context: context,
    barrierDismissible: true,
    barrierLabel: "Search Locator",
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
                    'Search Locator',
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
                        controller: codeController,
                        decoration: const InputDecoration(
                          labelText: 'Locator Code',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 10),
                      DropdownButtonFormField<String>(
                        value: selectedType,
                        items: const [
                          DropdownMenuItem(value: 'S', child: Text('S')),
                          DropdownMenuItem(value: 'C', child: Text('C')),
                          DropdownMenuItem(value: 'ADC', child: Text('ADC')),
                        ],
                        onChanged: (value) {
                          setState(() {
                            selectedType = value;
                          });
                        },
                        decoration: const InputDecoration(
                          labelText: 'Type',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 10),
                      DropdownButtonFormField<String>(
                        value: selectedArea,
                        items: const [
                          DropdownMenuItem(value: 'IN', child: Text('IN')),
                          DropdownMenuItem(value: 'OUT', child: Text('OUT')),
                          DropdownMenuItem(value: 'N', child: Text('N')),
                        ],
                        onChanged: (value) {
                          setState(() {
                            selectedArea = value;
                          });
                        },
                        decoration: const InputDecoration(
                          labelText: 'Area',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 10),
                      DropdownButtonFormField<String>(
                        value: selectedOccupancy,
                        items: const [
                          DropdownMenuItem(value: 'E', child: Text('E')),
                          DropdownMenuItem(value: 'O', child: Text('O')),
                          DropdownMenuItem(value: 'N', child: Text('N')),
                        ],
                        onChanged: (value) {
                          setState(() {
                            selectedOccupancy = value;
                          });
                        },
                        decoration: const InputDecoration(
                          labelText: 'Occupancy',
                          border: OutlineInputBorder(),
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
                          setState(() {
                            selectedStatus = value;
                          });
                        },
                        decoration: const InputDecoration(
                          labelText: 'Status',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 10),
                      DropdownButtonFormField<String>(
                        value: selectedWarehouse,
                        items: const [
                          DropdownMenuItem(value: '000', child: Text('000')),
                          DropdownMenuItem(value: 'PRD', child: Text('PRD')),
                        ],
                        onChanged: (value) {
                          setState(() {
                            selectedWarehouse = value;
                          });
                        },
                        decoration: const InputDecoration(
                          labelText: 'Warehouse',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ],
                  ),
                ),
                actions: <Widget>[
                  // Close button
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

                  // Reset Search button
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      onSearch(); // Call with no filters (same as getLocators)
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

                  // Actual Search button
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      onSearch(
                        locatorCode: codeController.text.trim().isEmpty
                            ? null
                            : codeController.text.trim(),
                        locatorType: selectedType,
                        locatorArea: selectedArea,
                        locatorOccupancyStatus: selectedOccupancy,
                        locatorStatus: selectedStatus,
                        userLogin: selectedWarehouse,
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