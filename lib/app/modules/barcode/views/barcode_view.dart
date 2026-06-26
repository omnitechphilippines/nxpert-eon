import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../routes/app_pages.dart';
import '../controllers/barcode_controller.dart';

class BarcodeView extends GetView<BarcodeController> {
  const BarcodeView({super.key});
  @override
  Widget build(_) => GetRouterOutlet(initialRoute: Routes.BARCODE_MANAGEMENT);
}
