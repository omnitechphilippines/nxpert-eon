import 'package:flutter/material.dart';

void showConfirmDeleteShiftModal(
  BuildContext context,
  String shiftCode,
  void Function(String shiftCode) onDelete,
) {
  showGeneralDialog(
    context: context,
    barrierDismissible: true,
    barrierLabel: "Confirm Delete",
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
              color: Colors.red,
              child: const Text(
                'Confirm Delete',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            content: Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                'Are you sure you want to delete shift "$shiftCode"?\nThis action cannot be undone.',
                style: const TextStyle(fontSize: 16),
              ),
            ),
            actions: [
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey,
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
                onPressed: () {
                  Navigator.pop(context);
                  onDelete(shiftCode);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero,
                  ),
                ),
                child: const Text(
                  'Delete',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
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
