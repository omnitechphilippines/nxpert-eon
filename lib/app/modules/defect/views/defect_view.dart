import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../routes/app_pages.dart';
import '../controllers/defect_controller.dart';

class DefectView extends GetView<DefectController> {
  const DefectView({super.key});
  @override
  Widget build(_) => GetRouterOutlet(initialRoute: Routes.MATERIAL_DEFECT_ENTRY);
}
