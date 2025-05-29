import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:month_year_picker/month_year_picker.dart';
import '../model/mpr_adc_model.dart';

class MprAdcController {
  final WidgetRef ref;
  final BuildContext context;

  MprAdcController(this.ref, this.context);

  void onMachineChanged(String? value) {
    if (value != null) {
      ref.read(mprAdcStateProvider.notifier).setSelectedMachine(value);
    }
  }

  void onModelChanged(String? value) {
    if (value != null) {
      ref.read(mprAdcStateProvider.notifier).setSelectedModel(value);
    }
  }

  Future<void> onSelectMonth() async {
    print('Select Month clicked');
    try {
      final DateTime? picked = await showMonthYearPicker(
        context: context,
        initialDate: ref.read(mprAdcStateProvider).selectedMonth ?? DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime.now(),
      );
      if (picked != null) {
        ref.read(mprAdcStateProvider.notifier).setSelectedMonth(picked);
      }
    } catch (e) {
      print('Error showing month picker: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  void onLoadData() {
    print('Load Data');
    // Add data fetching logic using ref.read(mprAdcStateProvider).selectedMachine, etc.
  }

  void onDownloadPdf() {
    print('Download Pdf');
    // Add PDF generation logic
  }

  void onDownloadExcel() {
    print('Download Excel');
    // Add Excel export logic
  }
}