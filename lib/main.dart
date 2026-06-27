import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/url_strategy.dart';

import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'app/data/services/auth_service.dart';
import 'app/modules/not_found/bindings/not_found_binding.dart';
import 'app/modules/not_found/views/not_found_view.dart';
import 'app/routes/app_pages.dart';
import 'core/theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  usePathUrlStrategy();
  await Supabase.initialize(
    url: 'https://ymujwwizqaxdlmpxfrik.supabase.co',
    publishableKey: 'sb_publishable_DMIaoxiEbGGcJDhoud5xnQ_wP-L9mS6',
    postgrestOptions: const PostgrestClientOptions(schema: 'nxpert_eon'),
  );
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  Get.put<SharedPreferences>(prefs, permanent: true);
  Get.put<PackageInfo>(await PackageInfo.fromPlatform(), permanent: true);
  Get.put(AuthService());
  runApp(
    GetMaterialApp(
      title: 'NXPERT EON',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      unknownRoute: GetPage<Object>(name: Routes.NOT_FOUND, page: () => const NotFoundView(), binding: NotFoundBinding()),
      defaultTransition: Transition.noTransition,
      transitionDuration: Duration.zero,
    ),
  );
}
