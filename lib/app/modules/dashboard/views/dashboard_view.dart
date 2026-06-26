import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../core/widgets/platform_layout_wrapper.dart';
import '../controllers/dashboard_controller.dart';

class DashboardView extends GetView<DashboardController> {
  const DashboardView({super.key});
  @override
  Widget build(BuildContext context) {
    return PlatformLayoutWrapper(
      child: Scaffold(
        backgroundColor: context.isDarkMode ? const Color(0xFF23282E) : const Color(0xFFF0F0F0),
        body: const Center(child: Text('Dashboard Content Area', style: TextStyle(fontSize: 24))),
      ),
    );
  }
}
