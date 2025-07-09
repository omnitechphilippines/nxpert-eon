import 'package:flutter/material.dart';
import 'package:quickalert/quickalert.dart';
import '../../../pages/settings/shift_master/models/shift_model.dart';
import '../../../pages/settings/shift_master/controllers/shift_master_controller.dart';

void showUpdateShiftModal(
  BuildContext context,
  int index,
  List<ShiftModel> shifts,
  void Function(int index, ShiftModel updatedShift) onUpdate,
) {
  final shift = shifts[index];
  final controller = ShiftMasterController();

  final descController = TextEditingController(text: shift.shiftDescription);
  final totalHoursController = TextEditingController(text: shift.totalHours.toString());
  final userController = TextEditingController(text: shift.user);

  final scheduleOptions = {'D': 'D', 'S': 'S', 'G': 'G'};

  String status = ['A', 'I'].contains(shift.status) ? shift.status : 'A';
  String scheduleType = shift.scheduleType;

  TimeOfDay timeIn = TimeOfDay.fromDateTime(shift.timeIn);
  TimeOfDay timeOut = TimeOfDay.fromDateTime(shift.timeOut);
  TimeOfDay? breakStart = shift.breakStart != null ? TimeOfDay.fromDateTime(shift.breakStart!) : null;
  TimeOfDay? breakEnd = shift.breakEnd != null ? TimeOfDay.fromDateTime(shift.breakEnd!) : null;

  final timeInController = TextEditingController(text: timeIn.format(context));
  final timeOutController = TextEditingController(text: timeOut.format(context));
  final breakStartController = TextEditingController(text: breakStart?.format(context) ?? '');
  final breakEndController = TextEditingController(text: breakEnd?.format(context) ?? '');

  Future<void> pickTime(
    BuildContext context,
    TimeOfDay? initialTime,
    ValueChanged<TimeOfDay> onPicked,
    TextEditingController controller,
  ) async {
    final picked = await showTimePicker(
      context: context,
      initialTime: initialTime ?? TimeOfDay.now(),
    );
    if (picked != null) {
      onPicked(picked);
      controller.text = picked.format(context);
    }
  }

  Future<void> submitForm() async {
    final newDesc = descController.text.trim();
    final Map<String, dynamic> changes = {};

    if (newDesc != shift.shiftDescription) changes['shiftDescription'] = newDesc;
    if (scheduleType != shift.scheduleType) changes['scheduleType'] = scheduleType;
    if (status != shift.status) changes['status'] = status;

    final newTimeIn = DateTime(
      shift.timeIn.year, shift.timeIn.month, shift.timeIn.day, timeIn.hour, timeIn.minute);
    if (newTimeIn != shift.timeIn) changes['timeIn'] = newTimeIn.toIso8601String();

    final newTimeOut = DateTime(
      shift.timeOut.year, shift.timeOut.month, shift.timeOut.day, timeOut.hour, timeOut.minute);
    if (newTimeOut != shift.timeOut) changes['timeOut'] = newTimeOut.toIso8601String();

    if (breakStart != null) {
      final newBreakStart = DateTime(
        shift.timeIn.year, shift.timeIn.month, shift.timeIn.day, breakStart!.hour, breakStart!.minute);
      if (shift.breakStart == null || newBreakStart != shift.breakStart) {
        changes['breakStart'] = newBreakStart.toIso8601String();
      }
    }

    if (breakEnd != null) {
      final newBreakEnd = DateTime(
        shift.timeIn.year, shift.timeIn.month, shift.timeIn.day, breakEnd!.hour, breakEnd!.minute);
      if (shift.breakEnd == null || newBreakEnd != shift.breakEnd) {
        changes['breakEnd'] = newBreakEnd.toIso8601String();
      }
    }

    final double? newTotalHours = double.tryParse(totalHoursController.text);
    if (newTotalHours != null && newTotalHours != shift.totalHours) {
      changes['totalHours'] = newTotalHours;
    }

    if (changes.isEmpty) {
      Navigator.pop(context);
      return;
    }

    QuickAlert.show(
      context: context,
      type: QuickAlertType.loading,
      title: 'Please wait',
      text: 'Updating shift...',
      barrierDismissible: false,
    );

    final success = await controller.updateShift(
      shiftCode: shift.shiftCode,
      shiftDescription: changes['shiftDescription'],
      scheduleType: changes['scheduleType'],
      timeIn: changes['timeIn'],
      breakStart: changes['breakStart'],
      breakEnd: changes['breakEnd'],
      timeOut: changes['timeOut'],
      totalHours: changes['totalHours'],
      status: changes['status'],
    );

    if (!context.mounted) return;
    Navigator.pop(context); // Close loading

    if (success) {
      Navigator.pop(context); // Close modal

      final updatedShift = ShiftModel(
        shiftCode: shift.shiftCode,
        shiftDescription: changes['shiftDescription'] ?? shift.shiftDescription,
        scheduleType: changes['scheduleType'] ?? shift.scheduleType,
        timeIn: changes['timeIn'] != null ? DateTime.parse(changes['timeIn']) : shift.timeIn,
        breakStart: changes['breakStart'] != null ? DateTime.parse(changes['breakStart']) : shift.breakStart,
        breakEnd: changes['breakEnd'] != null ? DateTime.parse(changes['breakEnd']) : shift.breakEnd,
        timeOut: changes['timeOut'] != null ? DateTime.parse(changes['timeOut']) : shift.timeOut,
        totalHours: changes['totalHours'] ?? shift.totalHours,
        status: changes['status'] ?? shift.status,
        user: shift.user,
      );

      onUpdate(index, updatedShift);

      await QuickAlert.show(
        context: context,
        type: QuickAlertType.success,
        title: 'Success',
        text: 'Shift successfully updated!',
      );
    } else {
      await QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        title: 'Error',
        text: 'Failed to update shift. Please try again.',
      );
    }
  }

  showGeneralDialog(
    context: context,
    barrierDismissible: true,
    barrierLabel: "Update Shift",
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
              color: Colors.blue,
              child: const Text(
                'Update Shift',
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
            content: SizedBox(
              width: 400,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: descController,
                      decoration: const InputDecoration(
                        labelText: 'Description',
                        border: OutlineInputBorder(borderRadius: BorderRadius.zero),
                      ),
                    ),
                    const SizedBox(height: 10),
                    DropdownButtonFormField<String>(
                      value: scheduleType,
                      items: scheduleOptions.entries.map((entry) {
                        return DropdownMenuItem(value: entry.key, child: Text(entry.value));
                      }).toList(),
                      onChanged: (value) {
                        if (value != null) scheduleType = value;
                      },
                      decoration: const InputDecoration(
                        labelText: 'Schedule Type',
                        border: OutlineInputBorder(borderRadius: BorderRadius.zero),
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      readOnly: true,
                      controller: timeInController,
                      decoration: const InputDecoration(
                        labelText: 'Time In',
                        border: OutlineInputBorder(borderRadius: BorderRadius.zero),
                        suffixIcon: Icon(Icons.access_time),
                      ),
                      onTap: () => pickTime(context, timeIn, (picked) => timeIn = picked, timeInController),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      readOnly: true,
                      controller: breakStartController,
                      decoration: const InputDecoration(
                        labelText: 'Break Start',
                        border: OutlineInputBorder(borderRadius: BorderRadius.zero),
                        suffixIcon: Icon(Icons.access_time),
                      ),
                      onTap: () => pickTime(context, breakStart, (picked) => breakStart = picked, breakStartController),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      readOnly: true,
                      controller: breakEndController,
                      decoration: const InputDecoration(
                        labelText: 'Break End',
                        border: OutlineInputBorder(borderRadius: BorderRadius.zero),
                        suffixIcon: Icon(Icons.access_time),
                      ),
                      onTap: () => pickTime(context, breakEnd, (picked) => breakEnd = picked, breakEndController),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      readOnly: true,
                      controller: timeOutController,
                      decoration: const InputDecoration(
                        labelText: 'Time Out',
                        border: OutlineInputBorder(borderRadius: BorderRadius.zero),
                        suffixIcon: Icon(Icons.access_time),
                      ),
                      onTap: () => pickTime(context, timeOut, (picked) => timeOut = picked, timeOutController),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: totalHoursController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Total Hours',
                        border: OutlineInputBorder(borderRadius: BorderRadius.zero),
                      ),
                    ),
                    const SizedBox(height: 10),
                    DropdownButtonFormField<String>(
                      value: status,
                      items: ['A', 'I'].map((s) {
                        return DropdownMenuItem(value: s, child: Text(s));
                      }).toList(),
                      onChanged: (value) {
                        if (value != null) status = value;
                      },
                      decoration: const InputDecoration(
                        labelText: 'Status',
                        border: OutlineInputBorder(borderRadius: BorderRadius.zero),
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      readOnly: true,
                      controller: userController,
                      decoration: const InputDecoration(
                        labelText: 'User',
                        border: OutlineInputBorder(borderRadius: BorderRadius.zero),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            actions: [
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                ),
                child: const Text('Cancel', style: TextStyle(color: Colors.white)),
              ),
              ElevatedButton(
                onPressed: submitForm,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                ),
                child: const Text('Update', style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ),
      );
    },
    transitionBuilder: (context, anim, _, child) {
      return ScaleTransition(
        scale: CurvedAnimation(parent: anim, curve: Curves.easeOutBack),
        child: child,
      );
    },
  );
}
