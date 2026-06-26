import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';

import 'package:get/get.dart';

import '../../../../core/constants/asset_constants.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/eon_text.dart';
import '../../../routes/app_pages.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Scaffold(
      backgroundColor: context.isMobile && !context.isDarkMode
          ? const Color(0xfff0f0f0)
          : !context.isMobile && !context.isDarkMode
          ? const Color(0xfff3f3f5)
          : null,
      appBar: AppBar(
        backgroundColor: context.isMobile && !context.isDarkMode
            ? const Color(0xfff0f0f0)
            : !context.isMobile && !context.isDarkMode
            ? const Color(0xfff3f3f5)
            : Colors.transparent,
        actions: <Widget>[
          Padding(
            padding: const EdgeInsetsGeometry.symmetric(horizontal: 16),
            child: IconButton(
              onPressed: () => Get.changeThemeMode(context.isDarkMode ? ThemeMode.light : ThemeMode.dark),
              icon: Icon(context.isDarkMode ? TablerIcons.sun : TablerIcons.moon, color: context.isDarkMode ? const Color(0xffdcdcdc) : const Color(0xff747786)),
            ),
          ),
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: .min,
            children: <Widget>[
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 520),
                child: Card(
                  elevation: 0.2,
                  margin: EdgeInsets.zero,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                  child: Container(
                    padding: const EdgeInsets.all(44),
                    child: Form(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Image.asset(AssetConstants.nxpertEon, height: 32),
                          const SizedBox(height: 20),
                          const EonText.titleMedium('Sign In', fontWeight: FontWeight.w600),
                          const SizedBox(height: 20),
                          const EonText.bodyMedium('Enter your username and password to access.', withAlpha: 200),
                          const SizedBox(height: 20),
                          // Username field
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              const EonText.bodyMedium('Username', withAlpha: 200),
                              const SizedBox(height: 12),
                              TextFormField(
                                controller: controller.userNameController,
                                style: EonText.textStyle(context, withAlpha: 200),
                                cursorWidth: 1,
                                cursorColor: theme.colorScheme.onSurface.withAlpha(120),
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(borderSide: BorderSide(strokeAlign: 0, color: theme.colorScheme.onSurface.withAlpha(80))),
                                  disabledBorder: OutlineInputBorder(borderSide: BorderSide(strokeAlign: 0, color: theme.colorScheme.onSurface.withAlpha(80))),
                                  errorBorder: const OutlineInputBorder(borderSide: BorderSide(strokeAlign: 0, color: AppColors.danger)),
                                  focusedBorder: OutlineInputBorder(borderSide: BorderSide(strokeAlign: 0, color: theme.colorScheme.onSurface.withAlpha(80))),
                                  focusedErrorBorder: const OutlineInputBorder(borderSide: BorderSide(strokeAlign: 0, color: AppColors.danger)),
                                  enabledBorder: OutlineInputBorder(borderSide: BorderSide(strokeAlign: 0, color: theme.colorScheme.onSurface.withAlpha(80))),
                                  hintText: 'Enter your username',
                                  hintStyle: EonText.textStyle(context, withAlpha: 120),
                                  isCollapsed: true,
                                  isDense: true,
                                  contentPadding: const EdgeInsets.all(15),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          // Password field
                          Column(
                            children: <Widget>[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text('Password', style: EonText.textStyle(context, withAlpha: 200)),
                                  InkWell(
                                    onTap: () => Get.toNamed(Routes.RESET_PASSWORD),
                                    splashColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    hoverColor: Colors.transparent,
                                    child: const EonText.labelMedium('Reset Password', decoration: TextDecoration.underline),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 12),
                              TextFormField(
                                controller: controller.passwordController,
                                style: EonText.textStyle(context, withAlpha: 200),
                                cursorWidth: 1,
                                obscureText: true,
                                cursorColor: theme.colorScheme.onSurface.withAlpha(120),
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(borderSide: BorderSide(strokeAlign: 0, color: theme.colorScheme.onSurface.withAlpha(80))),
                                  disabledBorder: OutlineInputBorder(borderSide: BorderSide(strokeAlign: 0, color: theme.colorScheme.onSurface.withAlpha(80))),
                                  errorBorder: const OutlineInputBorder(borderSide: BorderSide(strokeAlign: 0, color: AppColors.danger)),
                                  focusedBorder: OutlineInputBorder(borderSide: BorderSide(strokeAlign: 0, color: theme.colorScheme.onSurface.withAlpha(80))),
                                  focusedErrorBorder: const OutlineInputBorder(borderSide: BorderSide(strokeAlign: 0, color: AppColors.danger)),
                                  enabledBorder: OutlineInputBorder(borderSide: BorderSide(strokeAlign: 0, color: theme.colorScheme.onSurface.withAlpha(80))),
                                  hintText: 'Enter your password',
                                  hintStyle: EonText.textStyle(context, withAlpha: 120),
                                  isCollapsed: true,
                                  isDense: true,
                                  contentPadding: const EdgeInsets.all(15),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          // Remember me
                          Obx(
                            () => Theme(
                              data: ThemeData(splashColor: Colors.transparent, highlightColor: Colors.transparent, hoverColor: Colors.transparent),
                              child: CheckboxListTile(
                                value: controller.rememberMe.value,
                                onChanged: (_) => controller.rememberToggle,
                                visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
                                controlAffinity: ListTileControlAffinity.leading,
                                contentPadding: EdgeInsets.zero,
                                dense: true,
                                side: const BorderSide(color: AppColors.secondary),
                                activeColor: AppColors.primary,
                                checkColor: Colors.white,
                                title: const EonText.bodyMedium('Remember Me', color: AppColors.secondary, textAlign: TextAlign.start),
                              ),
                            ),
                          ),
                          const SizedBox(height: 12),
                          // Sign in button
                          InkWell(
                            onTap: () => controller.login(),
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              width: double.infinity,
                              decoration: BoxDecoration(color: AppColors.primary, borderRadius: BorderRadius.circular(4)),
                              child: const Center(child: EonText.bodyMedium('Sign In', color: AppColors.onPrimary)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // Sign up button
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const EonText.bodyMedium('New here?', fontWeight: FontWeight.w400),
                  const SizedBox(width: 8),
                  InkWell(
                    onTap: () => Get.toNamed(Routes.SIGN_UP),
                    child: const EonText.bodyMedium('Sign Up', fontWeight: FontWeight.w700, withAlpha: 200),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
