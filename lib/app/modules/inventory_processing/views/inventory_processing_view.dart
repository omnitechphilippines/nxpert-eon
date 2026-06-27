import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../core/widgets/wrappers/platform_layout_wrapper.dart';
import '../controllers/inventory_processing_controller.dart';

class InventoryProcessingView extends GetView<InventoryProcessingController> {
  const InventoryProcessingView({super.key});
  @override
  Widget build(BuildContext context) {
    return PlatformLayoutWrapper(
      child: Scaffold(
        backgroundColor: context.isDarkMode ? const Color(0xFF23282E) : const Color(0xFFF0F0F0),
        appBar: AppBar(title: const Text('InventoryProcessingView'), centerTitle: true, automaticallyImplyLeading: false),
        body: const Center(child: Text('InventoryProcessingView is working', style: TextStyle(fontSize: 20))),
      ),
    );
  }
}
