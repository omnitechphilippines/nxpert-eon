// class AuthRedirectMiddleware extends GetMiddleware {
//   @override
//   RouteSettings? redirect(String? route) => route == Routes.AUTH ? const RouteSettings(name: Routes.LOGIN) : null;
// }

// class CalendarRedirectMiddleware extends GetMiddleware {
//   @override
//   RouteSettings? redirect(String? route) => route == Routes.CALENDAR ? const RouteSettings(name: Routes.SCHEDULE) : null;
// }

// class InvoiceRedirectMiddleware extends GetMiddleware {
//   @override
//   RouteSettings? redirect(String? route) => route == Routes.INVOICE ? const RouteSettings(name: Routes.LIST) : null;
// }

// class PagesRedirectMiddleware extends GetMiddleware {
//   @override
//   RouteSettings? redirect(String? route) => route == Routes.PAGES ? const RouteSettings(name: Routes.FAQS) : null;
// }

// class BaseUiRedirectMiddleware extends GetMiddleware {
//   @override
//   RouteSettings? redirect(String? route) => route == Routes.BASE_UI ? const RouteSettings(name: Routes.ACCORDION) : null;
// }

// class AdvanceUiRedirectMiddleware extends GetMiddleware {
//   @override
//   RouteSettings? redirect(String? route) => route == Routes.ADVANCE_UI ? const RouteSettings(name: Routes.RATING) : null;
// }

// class FormsRedirectMiddleware extends GetMiddleware {
//   @override
//   RouteSettings? redirect(String? route) => route == Routes.FORMS ? const RouteSettings(name: Routes.BASIC_ELEMENT) : null;
// }

// class TablesRedirectMiddleware extends GetMiddleware {
//   @override
//   RouteSettings? redirect(String? route) => route == Routes.TABLES ? const RouteSettings(name: Routes.BASIC) : null;
// }

// class AuthMiddleware extends GetMiddleware {
//   @override
//   RouteSettings? redirect(String? route) => Get.find<AuthService>().isLoggedIn ? null : const RouteSettings(name: Routes.LOGIN);
// }

// class GuestMiddleware extends GetMiddleware {
//   @override
//   RouteSettings? redirect(String? route) => Get.find<AuthService>().isLoggedIn ? const RouteSettings(name: Routes.DASHBOARD) : null;
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../data/services/auth_service.dart';
import 'app_pages.dart';

class AuthMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) => !Get.find<AuthService>().isLoggedIn.value ? const RouteSettings(name: Routes.LOGIN) : null;
}

class GuestMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) => Get.find<AuthService>().isLoggedIn.value ? const RouteSettings(name: Routes.DASHBOARD) : null;
}

class DefectRedirectMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) => route == Routes.DEFECT ? const RouteSettings(name: Routes.MATERIAL_DEFECT_ENTRY) : null;
}

class BarcodeRedirectMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) => route == Routes.BARCODE ? const RouteSettings(name: Routes.BARCODE_MANAGEMENT) : null;
}
