import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppTheme {
  AppTheme._();

  /// -------------------------- Light Theme  -------------------------------------------- ///
  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    fontFamily: 'PublicSans',

    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: AppColors.background,
    canvasColor: Colors.transparent,

    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xffffffff),
      iconTheme: IconThemeData(color: Color(0xff495057)),
      actionsIconTheme: IconThemeData(color: Color(0xff495057)),
    ),

    cardTheme: const CardThemeData(color: AppColors.cardBackground),
    cardColor: AppColors.cardBackground,

    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: AppColors.primary,
      splashColor: AppColors.onPrimary.withAlpha(100),
      highlightElevation: 8,
      elevation: 4,
      focusColor: AppColors.primary,
      hoverColor: AppColors.primary,
      foregroundColor: AppColors.onPrimary,
    ),

    dividerTheme: const DividerThemeData(
      color: Color(0xffe8e8e8),
      thickness: 1,
    ),
    dividerColor: const Color(0xffe8e8e8),

    bottomAppBarTheme: const BottomAppBarThemeData(
      color: Color(0xffeeeeee),
      elevation: 2,
    ),

    tabBarTheme: const TabBarThemeData(
      unselectedLabelColor: Color(0xff495057),
      labelColor: AppColors.primary,
      indicatorSize: TabBarIndicatorSize.label,
      indicator: UnderlineTabIndicator(
        borderSide: BorderSide(color: AppColors.primary, width: 2.0),
      ),
    ),

    checkboxTheme: CheckboxThemeData(
      checkColor: WidgetStateProperty.all(AppColors.onPrimary),
      fillColor: WidgetStateProperty.all(AppColors.primary),
    ),

    radioTheme: RadioThemeData(
      fillColor: WidgetStateProperty.all(AppColors.primary),
    ),

    switchTheme: SwitchThemeData(
      trackColor: WidgetStateProperty.resolveWith<Color?>((
        Set<WidgetState> state,
      ) {
        const Set<WidgetState> interactiveStates = <WidgetState>{
          .pressed,
          .hovered,
          .focused,
          .selected,
        };
        return state.any(interactiveStates.contains)
            ? const Color(0xffabb3ea)
            : null;
      }),
      thumbColor: WidgetStateProperty.resolveWith((Set<WidgetState> state) {
        const Set<WidgetState> interactiveStates = <WidgetState>{
          .pressed,
          .hovered,
          .focused,
          .selected,
        };
        return state.any(interactiveStates.contains) ? AppColors.primary : null;
      }),
    ),

    sliderTheme: SliderThemeData(
      activeTrackColor: AppColors.primary,
      inactiveTrackColor: AppColors.primary.withAlpha(140),
      trackShape: const RoundedRectSliderTrackShape(),
      trackHeight: 4.0,
      thumbColor: AppColors.primary,
      thumbShape: const RoundSliderThumbShape(),
      overlayShape: const RoundSliderOverlayShape(),
      tickMarkShape: const RoundSliderTickMarkShape(),
      inactiveTickMarkColor: Colors.red[100],
      valueIndicatorShape: const PaddleSliderValueIndicatorShape(),
      valueIndicatorTextStyle: const TextStyle(color: AppColors.onPrimary),
    ),

    // splashColor: Colors.white.withAlpha(100),
    // highlightColor: const Color(0xffeeeeee),
    // colorScheme: ColorScheme.fromSeed(seedColor: primary).copyWith(surface: const Color(0xffffffff)).copyWith(error: const Color(0xfff0323c)),
    colorScheme: const ColorScheme(
      brightness: Brightness.light,
      primary: AppColors.primary,
      onPrimary: AppColors.onPrimary,
      secondary: AppColors.secondary,
      onSecondary: AppColors.onSecondary,
      error: AppColors.error,
      onError: AppColors.onError,
      surface: AppColors.cardBackground,
      onSurface: AppColors.onSurfaceLight, // Your primary onSurface color
      onSurfaceVariant: AppColors
          .onSurfaceVariantLight, // A lighter variant for less emphasis
      surfaceContainerHighest: Color(
        0xfff0f0f0,
      ), // A slightly different surface color if needed, or can be same as scaffoldBackground
      // background: background,
      // onBackground: onBackground,
      shadow: AppColors
          .onSurfaceMutedLight, // Reusing shadow for muted onSurface if appropriate, or create a new one.
    ).copyWith(),
  );

  /// -------------------------- Dark Theme  -------------------------------------------- ///
  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    fontFamily: 'PublicSans',

    primaryColor: AppColors.primary,

    scaffoldBackgroundColor: AppColors.dark,
    canvasColor: Colors.transparent,

    appBarTheme: const AppBarTheme(backgroundColor: Color(0xff161616)),

    cardTheme: const CardThemeData(color: AppColors.cardTheme),
    cardColor: AppColors.cardColor,

    inputDecorationTheme: const InputDecorationTheme(
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.primary),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.white70),
      ),
      border: OutlineInputBorder(borderSide: BorderSide(color: Colors.white70)),
    ),

    dividerTheme: const DividerThemeData(
      color: Color(0xff363636),
      thickness: 1,
    ),
    dividerColor: const Color(0xff363636),

    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: AppColors.primary,
      splashColor: AppColors.onPrimary.withAlpha(100),
      highlightElevation: 8,
      elevation: 4,
      focusColor: AppColors.primary,
      hoverColor: AppColors.primary,
      foregroundColor: AppColors.onPrimary,
    ),

    bottomAppBarTheme: const BottomAppBarThemeData(
      color: Color(0xff464c52),
      elevation: 2,
    ),

    tabBarTheme: const TabBarThemeData(
      unselectedLabelColor: Color(0xff495057),
      labelColor: AppColors.primary,
      indicatorSize: TabBarIndicatorSize.label,
      indicator: UnderlineTabIndicator(
        borderSide: BorderSide(color: AppColors.primary, width: 2.0),
      ),
    ),

    switchTheme: SwitchThemeData(
      trackColor: .resolveWith((Set<WidgetState> state) {
        const Set<WidgetState> interactiveStates = <WidgetState>{
          .pressed,
          .hovered,
          .focused,
          .selected,
        };
        return state.any(interactiveStates.contains)
            ? const Color(0xffabb3ea)
            : null;
      }),
      thumbColor: WidgetStateProperty.resolveWith((Set<WidgetState> state) {
        const Set<WidgetState> interactiveStates = <WidgetState>{
          .pressed,
          .hovered,
          .focused,
          .selected,
        };
        return state.any(interactiveStates.contains) ? AppColors.primary : null;
      }),
    ),

    sliderTheme: SliderThemeData(
      activeTrackColor: AppColors.primary,
      inactiveTrackColor: AppColors.primary.withAlpha(100),
      trackShape: const RoundedRectSliderTrackShape(),
      trackHeight: 4.0,
      thumbColor: AppColors.primary,
      thumbShape: const RoundSliderThumbShape(),
      overlayShape: const RoundSliderOverlayShape(),
      tickMarkShape: const RoundSliderTickMarkShape(),
      inactiveTickMarkColor: Colors.red[100],
      valueIndicatorShape: const PaddleSliderValueIndicatorShape(),
      valueIndicatorTextStyle: const TextStyle(color: AppColors.onPrimary),
    ),
    disabledColor: const Color(0xffa3a3a3),
    highlightColor: Colors.white.withAlpha(28),
    splashColor: Colors.white.withAlpha(56),
    // colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xff1e84c4), brightness: Brightness.dark).copyWith(surface: const Color(0xff161616)).copyWith(error: Colors.orange),
    colorScheme: const ColorScheme(
      brightness: Brightness.dark,
      primary: AppColors.primary,
      onPrimary: AppColors.onPrimary,
      secondary: AppColors.secondary,
      onSecondary: AppColors.onSecondary,
      error: Colors.orange,
      onError: AppColors.onDanger,
      surface: Color(0xff161616),
      onSurface: AppColors.onSurfaceDark, // Your primary onSurface dark color
      onSurfaceVariant:
          AppColors.onSurfaceVariantDark, // A variant for less emphasis
      surfaceContainerHighest: Color(
        0xff282f37,
      ), // A slightly different surface color for dark theme
      // background: dark,
      // onBackground: onBackground,
      shadow: AppColors.onSurfaceMutedDark,
    ).copyWith(),
  );
}
