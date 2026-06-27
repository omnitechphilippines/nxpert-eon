import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../core/widgets/wrappers/platform_layout_wrapper.dart';
import '../controllers/material_defect_entry_controller.dart';

class MaterialDefectEntryView extends GetView<MaterialDefectEntryController> {
  const MaterialDefectEntryView({super.key});
  @override
  Widget build(BuildContext context) {
    return PlatformLayoutWrapper(
      child: Scaffold(
        backgroundColor: context.isDarkMode ? const Color(0xFF23282E) : const Color(0xFFF0F0F0),
        appBar: AppBar(title: const Text('MaterialDefectEntryView'), centerTitle: true, automaticallyImplyLeading: false),
        body: const Center(child: Text('MaterialDefectEntryView is working', style: TextStyle(fontSize: 20))),
      ),
    );
  }
}
