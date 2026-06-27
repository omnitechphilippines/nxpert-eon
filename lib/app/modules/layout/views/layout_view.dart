import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:get/get.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/tabler.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../../../core/constants/asset_constants.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/texts/eon_text.dart';
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
              child: Material(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    // Logo Section
                    SizedBox(
                      height: 70,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: controller.isCondensed.value ? 4 : 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            InkWell(
                              onTap: () => controller.changePage(Routes.DASHBOARD),
                              borderRadius: BorderRadius.circular(4),
                              child: Padding(
                                padding: EdgeInsets.all(controller.isCondensed.value ? 16.0 : 8.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    ClipRRect(child: Image.asset(AssetConstants.nxpertEon, height: controller.isCondensed.value ? 19 : 24)),
                                    const Row(
                                      children: <Widget>[
                                        SizedBox(width: 10),
                                        EonText.titleLarge('NXPERT EON', fontWeight: FontWeight.w800, color: AppColors.onBackground, fontSize: 16, maxLines: 1, overflow: TextOverflow.clip),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            if (!controller.isCondensed.value) const Spacer(),
                            if (!controller.isCondensed.value)
                              IconButton(
                                icon: Iconify(Tabler.menu_2, color: AppColors.light.withValues(alpha: 0.6)),
                                onPressed: () => controller.toggleLeftBar,
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
                  // Bottom Bar
                  Container(
                    height: 30,
                    color: context.isDarkMode ? const Color(0xFF282E36) : const Color(0xFFFEFEFE),
                    child: Row(
                      children: <Widget>[
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: EonText.labelMedium('V${Get.find<PackageInfo>().version}+${Get.find<PackageInfo>().buildNumber}', color: Get.isDarkMode ? const Color(0xffdcdcdc) : const Color(0xff747786)),
                        ),
                      ],
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
      final bool isHovered = controller.hoveredRoute.value == route;

      return MouseRegion(
        onEnter: (_) => controller.hoveredRoute.value = route,
        onExit: (_) => controller.hoveredRoute.value = '',
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2),
          child: ListTile(
            dense: true,
            tileColor: isSelected || isHovered
                ? context.isDarkMode
                      ? const Color(0xff363c44)
                      : const Color(0xff283643)
                : Colors.transparent,
            contentPadding: EdgeInsetsGeometry.symmetric(horizontal: isCondensed ? 17 : 8),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
            minTileHeight: 32,
            leading: Icon(
              iconData,
              color: isSelected || isHovered
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
                    color: isSelected || isHovered
                        ? const Color(0xffffffff)
                        : context.isDarkMode
                        ? const Color(0xffdcdcdc)
                        : const Color(0xffa5b3c6),
                    fontWeight: isSelected || isHovered ? FontWeight.w500 : FontWeight.w400,
                  )
                : null,
            trailing: !isCondensed && label != null
                ? Container(
                    padding: const EdgeInsetsGeometry.symmetric(horizontal: 4, vertical: 2),
                    decoration: BoxDecoration(color: labelColor, borderRadius: const BorderRadius.all(Radius.circular(4))),
                    child: EonText.labelSmall(label!, color: const Color(0xffeef2f7)),
                  )
                : null,
            onTap: () => controller.changePage(route),
          ),
        ),
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
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 6),
          child: Theme(
            data: Theme.of(context).copyWith(hoverColor: Colors.transparent, highlightColor: Colors.transparent, splashColor: Colors.transparent),
            child: PopupMenuButton<String>(
              offset: const Offset(64, 0),
              tooltip: containsActiveChild ? children.firstWhere((LeftBarSubItem child) => controller.currentRoute.value == child.route).title : title,
              color: context.isDarkMode ? const Color(0xFF282F37) : const Color(0xFF2D3D4D),
              borderRadius: BorderRadius.circular(4),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: containsActiveChild
                      ? context.isDarkMode
                            ? const Color(0xff363c44)
                            : const Color(0xff283643)
                      : Colors.transparent,
                ),
                alignment: AlignmentGeometry.center,
                child: Icon(
                  iconData,
                  color: containsActiveChild
                      ? const Color(0xffffffff)
                      : context.isDarkMode
                      ? const Color(0xffdcdcdc)
                      : const Color(0xffa5b3c6),
                  size: 18,
                ),
              ),
              itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                PopupMenuItem<String>(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  enabled: false,
                  height: 24,
                  child: EonText.labelLarge(
                    title,
                    overflow: TextOverflow.clip,
                    maxLines: 1,
                    color: containsActiveChild
                        ? const Color(0xffffffff)
                        : context.isDarkMode
                        ? const Color(0xffdcdcdc)
                        : const Color(0xffa5b3c6),
                  ),
                ),
                const PopupMenuDivider(),
                ...children.map(
                  (LeftBarSubItem child) => PopupMenuItem<String>(
                    padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                    height: 32,
                    value: child.route,
                    onTap: () => controller.changePage(child.route),
                    child: MouseRegion(
                      onEnter: (_) => controller.hoveredRoute.value = child.route,
                      onExit: (_) => controller.hoveredRoute.value = '',
                      child: Obx(() {
                        final bool isHovered = controller.hoveredRoute.value == child.route;
                        final bool isSelected = controller.currentRoute.value == child.route;

                        return Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          height: 32,
                          alignment: Alignment.centerLeft,
                          decoration: BoxDecoration(color: isSelected || isHovered ? (context.isDarkMode ? const Color(0xff363c44) : const Color(0xff283643)) : Colors.transparent, borderRadius: BorderRadius.circular(4)),
                          child: EonText.bodySmall(
                            child.title,
                            color: isSelected || isHovered
                                ? const Color(0xffffffff)
                                : context.isDarkMode
                                ? const Color(0xffdcdcdc)
                                : const Color(0xffa5b3c6),
                            fontWeight: isSelected || isHovered ? FontWeight.w500 : FontWeight.w400,
                            fontSize: 12.5,
                          ),
                        );
                      }),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }

      // 2. EXPANDED MODE: Beautiful clean ExpansionTile with custom theme overrides
      return Theme(
        data: Theme.of(context).copyWith(
          dividerColor: Colors.transparent,
          expansionTileTheme: ExpansionTileThemeData(
            iconColor: containsActiveChild
                ? const Color(0xffffffff)
                : context.isDarkMode
                ? const Color(0xffdcdcdc)
                : const Color(0xffa5b3c6),
            collapsedIconColor: containsActiveChild
                ? const Color(0xffffffff)
                : context.isDarkMode
                ? const Color(0xffdcdcdc)
                : const Color(0xffa5b3c6),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: ExpansionTile(
            collapsedBackgroundColor: containsActiveChild
                ? context.isDarkMode
                      ? const Color(0xff363c44)
                      : const Color(0xff283643)
                : Colors.transparent,
            collapsedShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
            initiallyExpanded: containsActiveChild ? true : false,
            dense: true,
            tilePadding: const EdgeInsets.symmetric(horizontal: 8),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
            minTileHeight: 32,
            leading: Icon(
              iconData,
              color: containsActiveChild
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
              color: containsActiveChild
                  ? const Color(0xffffffff)
                  : context.isDarkMode
                  ? const Color(0xffdcdcdc)
                  : const Color(0xffa5b3c6),
            ),
            children: children,
          ),
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
      final bool isHovered = controller.hoveredRoute.value == route;

      return MouseRegion(
        onEnter: (_) => controller.hoveredRoute.value = route,
        onExit: (_) => controller.hoveredRoute.value = '',
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 2),
          child: ListTile(
            dense: true,
            tileColor: isSelected || isHovered
                ? context.isDarkMode
                      ? const Color(0xff363c44)
                      : const Color(0xff283643)
                : Colors.transparent,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
            contentPadding: const EdgeInsets.only(left: 24),
            minTileHeight: 32,
            title: EonText.bodySmall(
              '- $title',
              color: isSelected || isHovered
                  ? const Color(0xffffffff)
                  : context.isDarkMode
                  ? const Color(0xffdcdcdc)
                  : const Color(0xffa5b3c6),
              fontWeight: isSelected || isHovered ? FontWeight.w500 : FontWeight.w400,
              fontSize: 12.5,
            ),
            onTap: () => controller.changePage(route),
          ),
        ),
      );
    });
  }
}
