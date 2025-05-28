import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:month_year_picker/month_year_picker.dart';

import '../../../../components/footer.dart';
import '../../../../components/header_banner.dart';
import '../../../../components/side_nav.dart';
import '../../../../components/custom_app_bar.dart';

class MprAdcPage extends StatefulWidget {
  const MprAdcPage({super.key});

  @override
  State<MprAdcPage> createState() => _MprAdcPageState();
}

class _MprAdcPageState extends State<MprAdcPage> {
  final List<String> machine = ['ADC 1', 'ADC 2', 'ADC 3'];
  final List<String> model = ['ES01', 'ES05', 'ES30H\R', 'ES30L\R'];
  String selectedMachine = 'ADC 1';
  String selectedModel = 'ES01';
  DateTime? selectedMonth;

  @override
  Widget build(BuildContext context) {
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
              child: Container(
                width: double.infinity,
                height: 100,
                padding: const EdgeInsets.symmetric(horizontal: 30),
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
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    const Text(
                      'Company Logo',
                      style: TextStyle(
                        color: Color(0xFF005B96),
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.5,
                      ),
                    ),
                    const Spacer(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          'Machine',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: DropdownButton2<String>(
                            value: selectedMachine,
                            onChanged: (String? newValue) {
                              setState(() {
                                selectedMachine = newValue!;
                              });
                            },
                            items: machine.map((String value) {
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
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          'Model/Ratio',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: DropdownButton2<String>(
                            value: selectedModel,
                            onChanged: (String? newValue) {
                              setState(() {
                                selectedModel = newValue!;
                              });
                            },
                            items: model.map((String value) {
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
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          'Select Month',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onTap: () async {
                              print('Select Month clicked');
                              try {
                                final DateTime? picked = await showMonthYearPicker(
                                  context: context,
                                  initialDate: selectedMonth ?? DateTime.now(),
                                  firstDate: DateTime(2000),
                                  lastDate: DateTime.now(),
                                );
                                if (picked != null) {
                                  setState(() {
                                    selectedMonth = picked;
                                  });
                                }
                              } catch (e) {
                                print('Error showing month picker: $e');
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('Error: $e')),
                                );
                              }
                            },
                            child: Material(
                              color: Colors.transparent,
                              child: Container(
                                height: 40,
                                padding: const EdgeInsets.symmetric(horizontal: 10),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      selectedMonth != null
                                          ? '${selectedMonth!.month}/${selectedMonth!.year}'
                                          : 'Select Month',
                                      style: const TextStyle(fontSize: 14),
                                    ),
                                    const SizedBox(width: 10),
                                    const Icon(Icons.arrow_drop_down, size: 24),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
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