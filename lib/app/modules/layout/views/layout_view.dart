import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:get/get.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/tabler.dart';

import '../../../../core/constants/asset_constants.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/eon_text.dart';
import '../../../routes/app_pages.dart';
import '../../dashboard/views/dashboard_view.dart';
import '../../machine_entry/views/machine_entry_view.dart';
import '../../manpower_entry/views/manpower_entry_view.dart';
import '../../material_defect_entry/views/material_defect_entry_view.dart';
import '../../material_entry/views/material_entry_view.dart';
import '../../product_defect_entry/views/product_defect_entry_view.dart';
import '../../production_entry/views/production_entry_view.dart';
import '../controllers/layout_controller.dart';

class LayoutView extends GetView<LayoutController> {
  final Widget? child;

  const LayoutView({super.key, this.child});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final LayoutController controller = Get.put(LayoutController(), permanent: true);

    return Scaffold(
      body: Row(
        children: <Widget>[
          // Persistent Left Bar
          Obx(
            () => AnimatedContainer(
              padding: const EdgeInsets.all(0),
              color: context.isDarkMode ? const Color(0xFF282F37) : const Color(0xFF2D3D4D),
              width: controller.isCondensed.value ? 70 : 240,
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeInOut,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  // Logo Section
                  SizedBox(
                    height: 70,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          InkWell(
                            onTap: () => controller.changePage(Routes.DASHBOARD),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                if (controller.isCondensed.value) Image.asset(AssetConstants.nxpertEon, height: 19),
                                if (!controller.isCondensed.value)
                                  Row(
                                    children: <Widget>[
                                      Image.asset(AssetConstants.nxpertEon, height: 24),
                                      const SizedBox(width: 10),
                                      const EonText.titleLarge('NXPERT EON', fontWeight: FontWeight.w800, color: AppColors.light, fontSize: 16),
                                    ],
                                  ),
                              ],
                            ),
                          ),
                          if (!controller.isCondensed.value) const Spacer(),
                          if (!controller.isCondensed.value)
                            InkWell(
                              splashColor: theme.colorScheme.onSurface,
                              highlightColor: theme.colorScheme.onSurface,
                              onTap: () => controller.toggleLeftBar,
                              child: Iconify(Tabler.menu_2, color: AppColors.light.withValues(alpha: 0.6)),
                            ),
                        ],
                      ),
                    ),
                  ),
                  if (!controller.isCondensed.value) const MenuLabel('MENU'),
                  LeftBarItem(iconData: LucideIcons.house, title: 'Dashboard', isCondensed: controller.isCondensed.value, route: Routes.DASHBOARD, label: '9+', labelColor: AppColors.success),
                  if (!controller.isCondensed.value) const MenuLabel('ENTRY'),
                  LeftBarItem(iconData: LucideIcons.factory, title: 'Production Entry', isCondensed: controller.isCondensed.value, route: Routes.PRODUCTION_ENTRY),
                  LeftBarItem(iconData: LucideIcons.tool_case, title: 'Material Entry', isCondensed: controller.isCondensed.value, route: Routes.MATERIAL_ENTRY),
                  LeftBarItem(iconData: LucideIcons.toolbox, title: 'Machine Entry', isCondensed: controller.isCondensed.value, route: Routes.MACHINE_ENTRY),
                  LeftBarItem(iconData: LucideIcons.person_standing, title: 'Manpower Entry', isCondensed: controller.isCondensed.value, route: Routes.MANPOWER_ENTRY),
                  LeftBarDropdownItem(
                    iconData: LucideIcons.milk_off,
                    title: 'Defect',
                    isCondensed: controller.isCondensed.value,
                    children: const <LeftBarSubItem>[
                      LeftBarSubItem(title: 'Material Defect Entry', route: Routes.MATERIAL_DEFECT_ENTRY),
                      LeftBarSubItem(title: 'Product Defect Entry', route: Routes.PRODUCT_DEFECT_ENTRY),
                    ],
                  ),
                  if (!controller.isCondensed.value) const MenuLabel('HANDY'),
                  LeftBarItem(iconData: LucideIcons.locate_fixed, title: 'Locator Tagging', isCondensed: controller.isCondensed.value, route: Routes.LOCATOR_TAGGING),
                  LeftBarItem(iconData: TablerIcons.home_move, title: 'Stock Movement', isCondensed: controller.isCondensed.value, route: Routes.STOCK_MOVEMENT),
                  LeftBarItem(iconData: TablerIcons.brand_thingiverse, title: 'Material Issuance', isCondensed: controller.isCondensed.value, route: Routes.MATERIAL_ISSUANCE),
                  LeftBarItem(iconData: Icons.cyclone, title: 'Inventory Generation', isCondensed: controller.isCondensed.value, route: Routes.INVENTORY_GENERATION),
                  LeftBarItem(iconData: LucideIcons.zodiac_cancer, title: 'Inventory Processing', isCondensed: controller.isCondensed.value, route: Routes.INVENTORY_PROCESSING),
                  LeftBarDropdownItem(
                    iconData: LucideIcons.barcode,
                    title: 'Barcode',
                    isCondensed: controller.isCondensed.value,
                    children: const <LeftBarSubItem>[
                      LeftBarSubItem(title: 'Barcode Management', route: Routes.BARCODE_MANAGEMENT),
                      LeftBarSubItem(title: 'Barcode Test', route: Routes.BARCODE_TEST),
                    ],
                  ),
                  LeftBarItem(iconData: Icons.cleaning_services, title: 'Maintenance', isCondensed: controller.isCondensed.value, route: Routes.MAINTENANCE),
                ],
              ),
            ),
          ),

          // Main Functional Section
          Obx(
            () => Expanded(
              child: Column(
                children: <Widget>[
                  // Top Nav Bar
                  Container(
                    height: 70,
                    color: context.isDarkMode ? const Color(0xFF282E36) : const Color(0xFFFEFEFE),
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      children: <Widget>[
                        if (controller.isCondensed.value)
                          IconButton(
                            icon: Iconify(Tabler.menu_2, color: context.isDarkMode ? const Color(0xffdcdcdc) : const Color(0xff747786)),
                            onPressed: () => controller.toggleLeftBar,
                          ),
                        const Spacer(),
                        IconButton(
                          onPressed: () => Get.changeThemeMode(context.isDarkMode ? ThemeMode.light : ThemeMode.dark),
                          icon: Icon(context.isDarkMode ? TablerIcons.sun : TablerIcons.moon, color: context.isDarkMode ? const Color(0xffdcdcdc) : const Color(0xff747786)),
                        ),
                        IconButton(icon: const Icon(TablerIcons.logout), color: context.isDarkMode ? const Color(0xffdcdcdc) : const Color(0xff747786), onPressed: controller.logout),
                      ],
                    ),
                  ),

                  // Inject the current page view body for web else for other platforms
                  child != null && kIsWeb
                      ? Expanded(child: child!)
                      : Expanded(
                          child: Navigator(
                            key: Get.nestedKey(1),
                            initialRoute: Routes.DASHBOARD,
                            onGenerateRoute: (RouteSettings settings) {
                              if (settings.name == Routes.DASHBOARD) {
                                return GetPageRoute<Object>(page: () => const DashboardView());
                              } else if (settings.name == Routes.PRODUCTION_ENTRY) {
                                return GetPageRoute<Object>(page: () => const ProductionEntryView());
                              } else if (settings.name == Routes.MATERIAL_ENTRY) {
                                return GetPageRoute<Object>(page: () => const MaterialEntryView());
                              } else if (settings.name == Routes.MACHINE_ENTRY) {
                                return GetPageRoute<Object>(page: () => const MachineEntryView());
                              } else if (settings.name == Routes.MANPOWER_ENTRY) {
                                return GetPageRoute<Object>(page: () => const ManpowerEntryView());
                              } else if (settings.name == Routes.MATERIAL_DEFECT_ENTRY) {
                                return GetPageRoute<Object>(page: () => const MaterialDefectEntryView());
                              } else if (settings.name == Routes.PRODUCT_DEFECT_ENTRY) {
                                return GetPageRoute<Object>(page: () => const ProductDefectEntryView());
                              }
                              return null;
                            },
                          ),
                        ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MenuLabel extends StatelessWidget {
  final String label;
  const MenuLabel(this.label, {super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: EonText.labelSmall(label, fontWeight: FontWeight.w600, color: const Color(0xff879baf).withAlpha(200), maxLines: 1, overflow: TextOverflow.clip),
    );
  }
}

class LeftBarItem extends StatelessWidget {
  final IconData iconData;
  final String title;
  final bool isCondensed;
  final String route;
  final String? label;
  final Color? labelColor;
  const LeftBarItem({super.key, required this.iconData, required this.title, required this.isCondensed, required this.route, this.label, this.labelColor});

  @override
  Widget build(BuildContext context) {
    final LayoutController controller = Get.find<LayoutController>();
    return Obx(() {
      final bool isSelected = controller.currentRoute.value == route;
      return ListTile(
        dense: true,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        hoverColor: Colors.white.withAlpha(25),
        contentPadding: EdgeInsetsGeometry.symmetric(horizontal: isCondensed ? 25 : 16),
        leading: Icon(
          iconData,
          color: isSelected
              ? const Color(0xffffffff)
              : context.isDarkMode
              ? const Color(0xffdcdcdc)
              : const Color(0xffa5b3c6),
          size: 18,
        ),
        title: !isCondensed
            ? EonText.labelLarge(
                title,
                overflow: TextOverflow.clip,
                maxLines: 1,
                color: isSelected
                    ? const Color(0xffffffff)
                    : context.isDarkMode
                    ? const Color(0xffdcdcdc)
                    : const Color(0xffa5b3c6),
                fontWeight: isSelected ? FontWeight.w500 : FontWeight.w400,
              )
            : null,
        trailing: !isCondensed && label != null
            ? Container(
                padding: const EdgeInsetsGeometry.symmetric(horizontal: 4, vertical: 2),
                decoration: BoxDecoration(color: labelColor, borderRadius: const BorderRadius.all(Radius.circular(4))),
                child: EonText.labelSmall(label!, color: const Color(0xffeef2f7)),
              )
            : null,
        selected: isSelected,
        onTap: () => controller.changePage(route),
      );
    });
  }
}

class LeftBarDropdownItem extends StatelessWidget {
  final IconData iconData;
  final String title;
  final bool isCondensed;
  final List<LeftBarSubItem> children;

  const LeftBarDropdownItem({super.key, required this.iconData, required this.title, required this.isCondensed, required this.children});

  @override
  Widget build(BuildContext context) {
    // 1. CONDENSED MODE: Fallback to a clean PopupMenuButton to avoid layout breaking
    return Obx(() {
      final LayoutController controller = Get.find<LayoutController>();
      final bool containsActiveChild = children.any((LeftBarSubItem child) => controller.currentRoute.value == child.route);
      if (isCondensed) {
        return PopupMenuButton<String>(
          offset: const Offset(70, 0),
          color: context.isDarkMode ? const Color(0xFF282F37) : const Color(0xFF2D3D4D),
          tooltip: title,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 12),
            decoration: BoxDecoration(color: containsActiveChild ? Colors.white.withAlpha(40) : Colors.transparent, borderRadius: BorderRadius.circular(8)),
            child: Center(
              child: Icon(
                iconData,
                color: Get.currentRoute == Routes.MATERIAL_DEFECT_ENTRY || Get.currentRoute == Routes.PRODUCT_DEFECT_ENTRY
                    ? const Color(0xffffffff)
                    : context.isDarkMode
                    ? const Color(0xffdcdcdc)
                    : const Color(0xffa5b3c6),
                size: 18,
              ),
            ),
          ),
          itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
            PopupMenuItem<String>(enabled: false, child: EonText.labelSmall(title, color: const Color(0xff879baf))),
            const PopupMenuDivider(),
            ...children.map(
              (LeftBarSubItem child) => PopupMenuItem<String>(
                value: child.route,
                child: Text(
                  child.title,
                  style: TextStyle(color: controller.currentRoute.value == child.route ? Colors.cyan : Colors.white70, fontWeight: controller.currentRoute.value == child.route ? FontWeight.bold : FontWeight.normal),
                ),
              ),
            ),
          ],
        );
      }

      // 2. EXPANDED MODE: Beautiful clean ExpansionTile with custom theme overrides
      return Theme(
        data: Theme.of(context).copyWith(
          dividerColor: Colors.transparent,
          expansionTileTheme: ExpansionTileThemeData(
            iconColor: Get.currentRoute == Routes.MATERIAL_DEFECT_ENTRY || Get.currentRoute == Routes.PRODUCT_DEFECT_ENTRY
                ? const Color(0xffffffff)
                : context.isDarkMode
                ? const Color(0xffdcdcdc)
                : const Color(0xffa5b3c6),
            collapsedIconColor: Get.currentRoute == Routes.MATERIAL_DEFECT_ENTRY || Get.currentRoute == Routes.PRODUCT_DEFECT_ENTRY
                ? const Color(0xffffffff)
                : context.isDarkMode
                ? const Color(0xffdcdcdc)
                : const Color(0xffa5b3c6),
          ),
        ),
        child: ExpansionTile(
          initiallyExpanded: Get.currentRoute == Routes.MATERIAL_DEFECT_ENTRY || Get.currentRoute == Routes.PRODUCT_DEFECT_ENTRY ? true : false,
          dense: true,
          tilePadding: const EdgeInsets.symmetric(horizontal: 16),
          leading: Icon(
            iconData,
            color: Get.currentRoute == Routes.MATERIAL_DEFECT_ENTRY || Get.currentRoute == Routes.PRODUCT_DEFECT_ENTRY
                ? const Color(0xffffffff)
                : context.isDarkMode
                ? const Color(0xffdcdcdc)
                : const Color(0xffa5b3c6),
            size: 18,
          ),
          title: EonText.labelLarge(
            title,
            overflow: TextOverflow.clip,
            maxLines: 1,
            color: Get.currentRoute == Routes.MATERIAL_DEFECT_ENTRY || Get.currentRoute == Routes.PRODUCT_DEFECT_ENTRY
                ? const Color(0xffffffff)
                : context.isDarkMode
                ? const Color(0xffdcdcdc)
                : const Color(0xffa5b3c6),
          ),
          children: children,
        ),
      );
    });
  }
}

class LeftBarSubItem extends StatelessWidget {
  final String title;
  final String route;

  const LeftBarSubItem({super.key, required this.title, required this.route});

  @override
  Widget build(BuildContext context) {
    final LayoutController controller = Get.find<LayoutController>();
    return Obx(() {
      final bool isSelected = controller.currentRoute.value == route;

      return ListTile(
        dense: true,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        hoverColor: Colors.white.withAlpha(20),
        tileColor: isSelected ? Colors.white.withAlpha(25) : Colors.transparent,
        contentPadding: const EdgeInsets.only(left: 50),
        title: EonText.bodySmall(
          '- $title',
          color: isSelected
              ? const Color(0xffffffff)
              : context.isDarkMode
              ? const Color(0xffdcdcdc)
              : const Color(0xffa5b3c6),
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          fontSize: 12.5,
        ),
        onTap: () => controller.changePage(route),
      );
    });
  }
}
