import 'package:get/get.dart';

import '../modules/barcode/bindings/barcode_binding.dart';
import '../modules/barcode/views/barcode_view.dart';
import '../modules/barcode_management/bindings/barcode_management_binding.dart';
import '../modules/barcode_management/views/barcode_management_view.dart';
import '../modules/barcode_test/bindings/barcode_test_binding.dart';
import '../modules/barcode_test/views/barcode_test_view.dart';
import '../modules/dashboard/bindings/dashboard_binding.dart';
import '../modules/dashboard/views/dashboard_view.dart';
import '../modules/defect/bindings/defect_binding.dart';
import '../modules/defect/views/defect_view.dart';
import '../modules/handy/bindings/handy_binding.dart';
import '../modules/handy/views/handy_view.dart';
import '../modules/inventory_generation/bindings/inventory_generation_binding.dart';
import '../modules/inventory_generation/views/inventory_generation_view.dart';
import '../modules/inventory_processing/bindings/inventory_processing_binding.dart';
import '../modules/inventory_processing/views/inventory_processing_view.dart';
import '../modules/layout/bindings/layout_binding.dart';
import '../modules/layout/views/layout_view.dart';
import '../modules/locator_tagging/bindings/locator_tagging_binding.dart';
import '../modules/locator_tagging/views/locator_tagging_view.dart';
import '../modules/lock/bindings/lock_binding.dart';
import '../modules/lock/views/lock_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/machine_entry/bindings/machine_entry_binding.dart';
import '../modules/machine_entry/views/machine_entry_view.dart';
import '../modules/maintenance/bindings/maintenance_binding.dart';
import '../modules/maintenance/views/maintenance_view.dart';
import '../modules/manpower_entry/bindings/manpower_entry_binding.dart';
import '../modules/manpower_entry/views/manpower_entry_view.dart';
import '../modules/material_defect_entry/bindings/material_defect_entry_binding.dart';
import '../modules/material_defect_entry/views/material_defect_entry_view.dart';
import '../modules/material_entry/bindings/material_entry_binding.dart';
import '../modules/material_entry/views/material_entry_view.dart';
import '../modules/material_issuance/bindings/material_issuance_binding.dart';
import '../modules/material_issuance/views/material_issuance_view.dart';
import '../modules/not_found/bindings/not_found_binding.dart';
import '../modules/not_found/views/not_found_view.dart';
import '../modules/product_defect_entry/bindings/product_defect_entry_binding.dart';
import '../modules/product_defect_entry/views/product_defect_entry_view.dart';
import '../modules/production_entry/bindings/production_entry_binding.dart';
import '../modules/production_entry/views/production_entry_view.dart';
import '../modules/reset_password/bindings/reset_password_binding.dart';
import '../modules/reset_password/views/reset_password_view.dart';
import '../modules/sign_up/bindings/sign_up_binding.dart';
import '../modules/sign_up/views/sign_up_view.dart';
import '../modules/stock_movement/bindings/stock_movement_binding.dart';
import '../modules/stock_movement/views/stock_movement_view.dart';
import 'app_middlewares.dart';

// ignore_for_file: constant_identifier_names

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const String INITIAL = Routes.LOGIN;

  static final List<GetPage<dynamic>> routes = <GetPage<dynamic>>[
    GetPage<Object>(name: _Paths.LOGIN, page: () => const LoginView(), binding: LoginBinding()),
    GetPage<Object>(name: _Paths.RESET_PASSWORD, page: () => const ResetPasswordView(), binding: ResetPasswordBinding()),
    GetPage<Object>(name: _Paths.NOT_FOUND, page: () => const NotFoundView(), binding: NotFoundBinding()),
    GetPage<Object>(name: _Paths.SIGN_UP, page: () => const SignUpView(), binding: SignUpBinding()),
    GetPage<Object>(name: _Paths.LOCK, page: () => const LockView(), binding: LockBinding()),
    GetPage<Object>(name: _Paths.DASHBOARD, page: () => const DashboardView(), binding: DashboardBinding(), middlewares: <GetMiddleware>[AuthMiddleware()]),
    GetPage<Object>(name: _Paths.LAYOUT, page: () => const LayoutView(), binding: LayoutBinding(), middlewares: <GetMiddleware>[AuthMiddleware()]),
    GetPage<Object>(name: _Paths.PRODUCTION_ENTRY, page: () => const ProductionEntryView(), binding: ProductionEntryBinding(), middlewares: <GetMiddleware>[AuthMiddleware()]),
    GetPage<Object>(name: _Paths.MATERIAL_ENTRY, page: () => const MaterialEntryView(), binding: MaterialEntryBinding(), middlewares: <GetMiddleware>[AuthMiddleware()]),
    GetPage<Object>(name: _Paths.MACHINE_ENTRY, page: () => const MachineEntryView(), binding: MachineEntryBinding(), middlewares: <GetMiddleware>[AuthMiddleware()]),
    GetPage<Object>(name: _Paths.MANPOWER_ENTRY, page: () => const ManpowerEntryView(), binding: ManpowerEntryBinding(), middlewares: <GetMiddleware>[AuthMiddleware()]),
    GetPage<Object>(name: _Paths.MATERIAL_DEFECT_ENTRY, page: () => const MaterialDefectEntryView(), binding: MaterialDefectEntryBinding(), middlewares: <GetMiddleware>[AuthMiddleware()]),
    GetPage<Object>(name: _Paths.PRODUCT_DEFECT_ENTRY, page: () => const ProductDefectEntryView(), binding: ProductDefectEntryBinding(), middlewares: <GetMiddleware>[AuthMiddleware()]),
    GetPage<Object>(name: _Paths.DEFECT, page: () => const DefectView(), binding: DefectBinding()),
    GetPage<Object>(name: _Paths.HANDY, page: () => const HandyView(), binding: HandyBinding()),
    GetPage<Object>(name: _Paths.LOCATOR_TAGGING, page: () => const LocatorTaggingView(), binding: LocatorTaggingBinding(), middlewares: <GetMiddleware>[AuthMiddleware()]),
    GetPage<Object>(name: _Paths.STOCK_MOVEMENT, page: () => const StockMovementView(), binding: StockMovementBinding(), middlewares: <GetMiddleware>[AuthMiddleware()]),
    GetPage<Object>(name: _Paths.MATERIAL_ISSUANCE, page: () => const MaterialIssuanceView(), binding: MaterialIssuanceBinding(), middlewares: <GetMiddleware>[AuthMiddleware()]),
    GetPage<Object>(name: _Paths.INVENTORY_GENERATION, page: () => const InventoryGenerationView(), binding: InventoryGenerationBinding(), middlewares: <GetMiddleware>[AuthMiddleware()]),
    GetPage<Object>(name: _Paths.INVENTORY_PROCESSING, page: () => const InventoryProcessingView(), binding: InventoryProcessingBinding(), middlewares: <GetMiddleware>[AuthMiddleware()]),
    GetPage<Object>(name: _Paths.BARCODE_MANAGEMENT, page: () => const BarcodeManagementView(), binding: BarcodeManagementBinding(), middlewares: <GetMiddleware>[AuthMiddleware()]),
    GetPage<Object>(name: _Paths.BARCODE_TEST, page: () => const BarcodeTestView(), binding: BarcodeTestBinding(), middlewares: <GetMiddleware>[AuthMiddleware()]),
    GetPage<Object>(name: _Paths.MAINTENANCE, page: () => const MaintenanceView(), binding: MaintenanceBinding(), middlewares: <GetMiddleware>[AuthMiddleware()]),
    GetPage<Object>(name: _Paths.BARCODE, page: () => const BarcodeView(), binding: BarcodeBinding()),
  ];
}
