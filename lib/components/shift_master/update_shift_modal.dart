import 'package:flutter/material.dart';

class UpdateShiftModal extends StatefulWidget {
  final Map<String, dynamic> initialData;
  final void Function(Map<String, dynamic>) onUpdate;

  const UpdateShiftModal({
    Key? key,
    required this.initialData,
    required this.onUpdate,
  }) : super(key: key);

  @override
  State<UpdateShiftModal> createState() => _UpdateShiftModalState();
}

class _UpdateShiftModalState extends State<UpdateShiftModal> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _startTimeController;
  late TextEditingController _endTimeController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.initialData['name'] ?? '');
    _startTimeController = TextEditingController(text: widget.initialData['startTime'] ?? '');
    _endTimeController = TextEditingController(text: widget.initialData['endTime'] ?? '');
  }

  @override
  void dispose() {
    _nameController.dispose();
    _startTimeController.dispose();
    _endTimeController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      widget.onUpdate({
        'name': _nameController.text,
        'startTime': _startTimeController.text,
        'endTime': _endTimeController.text,
      });
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Update Shift'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Shift Name'),
              validator: (value) => value == null || value.isEmpty ? 'Enter shift name' : null,
            ),
            TextFormField(
              controller: _startTimeController,
              decoration: const InputDecoration(labelText: 'Start Time'),
              validator: (value) => value == null || value.isEmpty ? 'Enter start time' : null,
            ),
            TextFormField(
              controller: _endTimeController,
              decoration: const InputDecoration(labelText: 'End Time'),
              validator: (value) => value == null || value.isEmpty ? 'Enter end time' : null,
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: _submit,
          child: const Text('Update'),
        ),
      ],
    );
  }
}