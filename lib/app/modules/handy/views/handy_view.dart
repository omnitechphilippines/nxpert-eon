import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../routes/app_pages.dart';
import '../controllers/handy_controller.dart';

class HandyView extends GetView<HandyController> {
  const HandyView({super.key});
  @override
  Widget build(_) => GetRouterOutlet(initialRoute: Routes.LOCATOR_TAGGING);
}
