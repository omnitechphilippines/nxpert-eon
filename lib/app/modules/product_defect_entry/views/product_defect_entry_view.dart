import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../core/widgets/platform_layout_wrapper.dart';
import '../controllers/product_defect_entry_controller.dart';

class ProductDefectEntryView extends GetView<ProductDefectEntryController> {
  const ProductDefectEntryView({super.key});
  @override
  Widget build(BuildContext context) {
    return PlatformLayoutWrapper(
      child: Scaffold(
        backgroundColor: context.isDarkMode ? const Color(0xFF23282E) : const Color(0xFFF0F0F0),
        appBar: AppBar(title: const Text('ProductDefectEntryView'), centerTitle: true),
        body: const Center(child: Text('ProductDefectEntryView is working', style: TextStyle(fontSize: 20))),
      ),
    );
  }
}
