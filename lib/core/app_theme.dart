import 'package:flutter/material.dart';

import '../gen/fonts.gen.dart';
import 'app_color.dart';

class AppTheme {
  AppTheme._();

  static ThemeData darkAppTheme = ThemeData(
    useMaterial3: false,
    fontFamily: FontFamily.openSans,
    splashColor: AppColor.secondary,
    highlightColor: AppColor.primary,
    indicatorColor: AppColor.primary,
    scaffoldBackgroundColor: AppColor.home_backround,
    appBarTheme: const AppBarTheme(centerTitle: true, backgroundColor: AppColor.home_backround),
    textSelectionTheme: TextSelectionThemeData(cursorColor: AppColor.main_content),
    dialogTheme: const DialogTheme(
      backgroundColor: AppColor.dialog_background,
      alignment: Alignment.center,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15.0))),
    ),
    sliderTheme: SliderThemeData(
      trackHeight: 3,
      thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 6),
      activeTrackColor: AppColor.on_primary,
      inactiveTrackColor: Colors.white.withOpacity(.3),
    ),
    progressIndicatorTheme: const ProgressIndicatorThemeData(color: AppColor.primary),
    // TODO(nam): add theme for input decoration
    // inputDecorationTheme: const InputDecorationTheme(
    //   enabledBorder: CustomOutlineBorder.enabledBorder,
    //   focusedBorder: CustomOutlineBorder.focusedBorder,
    //   errorBorder: CustomOutlineBorder.errorBorder,
    //   border: CustomOutlineBorder.inputBorder,
    // ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(backgroundColor: AppColor.primary, elevation: 0),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: AppColor.primary,
      highlightElevation: 1,
      focusElevation: 1,
      hoverElevation: 1,
      elevation: 1,
      disabledElevation: 1,
    ),
    radioTheme: const RadioThemeData(fillColor: MaterialStatePropertyAll(AppColor.primary)),
    checkboxTheme: CheckboxThemeData(
      fillColor: MaterialStateProperty.resolveWith((states) {
        if (states.contains(MaterialState.selected)) {
          return AppColor.primary;
        } else {
          return Colors.white;
        }
      }),
      side: const BorderSide(color: AppColor.primary),
      checkColor: MaterialStateProperty.resolveWith((states) {
        if (states.contains(MaterialState.selected)) {
          return Colors.white;
        } else {
          return AppColor.primary;
        }
      }),
    ),
    switchTheme: SwitchThemeData(
      thumbColor: MaterialStateProperty.resolveWith<Color>((states) {
        if (states.contains(MaterialState.selected)) {
          return AppColor.primary;
        } else {
          return AppColor.on_primary;
        }
      }),
      trackColor: MaterialStateProperty.all(AppColor.primary.withOpacity(0.5)),
    ),
    // TODO(nam): add theme for toggleButtonsTheme
    // toggleButtonsTheme: ToggleButtonsThemeData(
    //   color: Colors.grey,
    //   selectedColor: Colors.white,
    //   fillColor: AppColor.primaryYellow,
    //   hoverColor: Colors.grey.withOpacity(0.1),
    //   borderRadius: BorderRadius.circular(8.0),
    // ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(foregroundColor: Colors.black54),
    ),
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
      ),
    ),
  );
}
