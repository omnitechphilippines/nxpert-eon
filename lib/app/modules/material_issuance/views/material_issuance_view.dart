import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../core/widgets/platform_layout_wrapper.dart';
import '../controllers/material_issuance_controller.dart';

class MaterialIssuanceView extends GetView<MaterialIssuanceController> {
  const MaterialIssuanceView({super.key});
  @override
  Widget build(BuildContext context) {
    return PlatformLayoutWrapper(
      child: Scaffold(
        backgroundColor: context.isDarkMode ? const Color(0xFF23282E) : const Color(0xFFF0F0F0),
        appBar: AppBar(title: const Text('MaterialIssuanceView'), centerTitle: true),
        body: const Center(child: Text('MaterialIssuanceView is working', style: TextStyle(fontSize: 20))),
      ),
    );
  }
}
