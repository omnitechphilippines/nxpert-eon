import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import '../../../../components/footer.dart';
import '../../../../components/header_banner.dart';
import '../../../../components/side_nav.dart';
import '../../../../components/custom_app_bar.dart';
import '../model/mpr_adc_model.dart';
import '../controller/mpr_adc_controller.dart';

class MprAdcPage extends ConsumerWidget {
  const MprAdcPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = MprAdcController(ref, context);
    return MprAdcView(controller: controller);
  }
}

class MprAdcView extends ConsumerWidget {
  final MprAdcController controller;
  const MprAdcView({super.key, required this.controller});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const double dropdownWidth = 200;
    final state = ref.watch(mprAdcStateProvider);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBar(title: 'NXPERT EON'),
      drawer: SideNav(
          currentRoute:
          GoRouter.of(context).routerDelegate.currentConfiguration.uri.toString()),
      body: Column(
        children: <Widget>[
          const HeaderBanner(subtitle: 'MONTHLY PRODUCTION REPORT (ADC)'),
          Expanded(
            child: Align(
              alignment: Alignment.topCenter,
              child: SingleChildScrollView(
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Company Logo
                      Expanded(
                        child: Container(
                          alignment: Alignment.centerLeft,
                          child: const Text(
                            'Company Logo',
                            style: TextStyle(
                              color: Color(0xFF005B96),
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.5,
                            ),
                          ),
                        ),
                      ),
                      // Dropdowns and Buttons
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          // Dropdown Row
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              DropdownWidget(
                                label: 'Machine',
                                value: state.selectedMachine,
                                items: state.machineList,
                                onChanged: controller.onMachineChanged,
                                width: dropdownWidth,
                              ),
                              const SizedBox(width: 20),
                              DropdownWidget(
                                label: 'Model/Ratio',
                                value: state.selectedModel,
                                items: state.modelList,
                                onChanged: controller.onModelChanged,
                                width: dropdownWidth,
                              ),
                              const SizedBox(width: 20),
                              MonthPickerWidget(
                                label: 'Select Month',
                                selectedMonth: state.selectedMonth,
                                onTap: controller.onSelectMonth,
                                width: dropdownWidth,
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          // Button Row
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              ButtonWidget(
                                label: 'Load Data',
                                onPressed: controller.onLoadData,
                                width: dropdownWidth,
                              ),
                              const SizedBox(width: 20),
                              ButtonWidget(
                                label: 'Download Pdf',
                                onPressed: controller.onDownloadPdf,
                                width: dropdownWidth,
                              ),
                              const SizedBox(width: 20),
                              ButtonWidget(
                                label: 'Download Excel',
                                onPressed: controller.onDownloadExcel,
                                width: dropdownWidth,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const Footer(),
        ],
      ),
    );
  }
}

// Reusable Dropdown Widget
class DropdownWidget extends StatelessWidget {
  final String label;
  final String value;
  final List<String> items;
  final void Function(String?) onChanged;
  final double width;

  const DropdownWidget({
    super.key,
    required this.label,
    required this.value,
    required this.items,
    required this.onChanged,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        ConstrainedBox(
          constraints: BoxConstraints(maxWidth: width),
          child: SizedBox(
            width: double.infinity,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8),
              ),
              child: DropdownButton2<String>(
                value: value,
                onChanged: onChanged,
                items: items.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                buttonStyleData: const ButtonStyleData(
                  height: 40,
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                  ),
                ),
                iconStyleData: const IconStyleData(
                  icon: Icon(Icons.arrow_drop_down),
                  iconSize: 24,
                ),
                dropdownStyleData: const DropdownStyleData(
                  maxHeight: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                  ),
                  offset: Offset(0, -5),
                ),
                isExpanded: true,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// Reusable Month Picker Widget
class MonthPickerWidget extends StatelessWidget {
  final String label;
  final DateTime? selectedMonth;
  final VoidCallback onTap;
  final double width;

  const MonthPickerWidget({
    super.key,
    required this.label,
    required this.selectedMonth,
    required this.onTap,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        ConstrainedBox(
          constraints: BoxConstraints(maxWidth: width),
          child: SizedBox(
            width: double.infinity,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8),
              ),
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: onTap,
                child: Material(
                  color: Colors.transparent,
                  child: Container(
                    height: 40,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          selectedMonth != null
                              ? '${selectedMonth!.month}/${selectedMonth!.year}'
                              : 'Select Month',
                          style: const TextStyle(fontSize: 14),
                        ),
                        const Icon(Icons.arrow_drop_down, size: 24),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// Reusable Button Widget
class ButtonWidget extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final double width;

  const ButtonWidget({
    super.key,
    required this.label,
    required this.onPressed,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: width),
        child: SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 25),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
            ),
            child: Text(label),
          ),
        ),
      ),
    );
  }
}