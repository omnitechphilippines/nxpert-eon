import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../core/widgets/wrappers/platform_layout_wrapper.dart';
import '../controllers/locator_tagging_controller.dart';

class LocatorTaggingView extends GetView<LocatorTaggingController> {
  const LocatorTaggingView({super.key});
  @override
  Widget build(BuildContext context) {
    return PlatformLayoutWrapper(
      child: Scaffold(
        backgroundColor: context.isDarkMode ? const Color(0xFF23282E) : const Color(0xFFF0F0F0),
        appBar: AppBar(title: const Text('LocatorTaggingView'), centerTitle: true, automaticallyImplyLeading: false),
        body: const Center(child: Text('LocatorTaggingView is working', style: TextStyle(fontSize: 20))),
      ),
    );
  }
}
