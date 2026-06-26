import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../core/widgets/platform_layout_wrapper.dart';
import '../controllers/machine_entry_controller.dart';

class MachineEntryView extends GetView<MachineEntryController> {
  const MachineEntryView({super.key});
  @override
  Widget build(BuildContext context) {
    return PlatformLayoutWrapper(
      child: Scaffold(
        backgroundColor: context.isDarkMode ? const Color(0xFF23282E) : const Color(0xFFF0F0F0),
        appBar: AppBar(title: const Text('MachineEntryView'), centerTitle: true),
        body: const Center(child: Text('MachineEntryView is working', style: TextStyle(fontSize: 20))),
      ),
    );
  }
}
