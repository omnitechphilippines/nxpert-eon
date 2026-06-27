import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';

import 'package:get/get.dart';

import '../../../../core/constants/asset_constants.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/texts/eon_text.dart';
import '../../../routes/app_pages.dart';
import '../controllers/reset_password_controller.dart';

class ResetPasswordView extends GetView<ResetPasswordController> {
  const ResetPasswordView({super.key});
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
        automaticallyImplyLeading: kIsWeb ? false : true,
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
                          const EonText.titleMedium('Reset Password', fontWeight: FontWeight.w600),
                          const SizedBox(height: 20),
                          const EonText.bodyMedium('Enter your email address and we\'ll send you an email with instructions to reset your password.', withAlpha: 200),
                          const SizedBox(height: 20),
                          // Email field
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              const EonText.bodyMedium('Email', withAlpha: 200),
                              const SizedBox(height: 12),
                              TextFormField(
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
                                  hintText: 'Enter your email',
                                  hintStyle: EonText.textStyle(context, withAlpha: 120),
                                  isCollapsed: true,
                                  isDense: true,
                                  contentPadding: const EdgeInsets.all(15),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          // Reset password button
                          InkWell(
                            onTap: () {},
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              width: double.infinity,
                              decoration: BoxDecoration(color: AppColors.primary, borderRadius: BorderRadius.circular(4)),
                              child: const Center(child: EonText.bodyMedium('Reset Password', color: AppColors.onPrimary)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // Sign in button
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const EonText.bodyMedium('Back to', fontWeight: FontWeight.w400),
                  const SizedBox(width: 8),
                  InkWell(
                    onTap: () => Get.toNamed(Routes.LOGIN),
                    child: const EonText.bodyMedium('Sign In', fontWeight: FontWeight.w700, withAlpha: 200),
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
