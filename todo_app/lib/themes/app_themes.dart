import 'package:flutter/material.dart';
import 'package:todo_app/styles/app_border_styles.dart';
import 'package:todo_app/themes/app_colors.dart';

class AppThemes {
  static ThemeData  appThemes(BuildContext context)  {
    return ThemeData(
        primarySwatch: MaterialColor(0xff4C0033, colorMap),
        inputDecorationTheme: InputDecorationTheme( 
          border: AppBorderStyles.inputBorder,
                  enabledBorder: AppBorderStyles.inputBorder,)
      );
  }
}

Map<int, Color> colorMap = {
  50: AppColors.primaryColor,
  100: AppColors.primaryColor,
  200: AppColors.primaryColor,
  300: AppColors.primaryColor,
  400: AppColors.primaryColor,
  500: AppColors.primaryColor,
  600: AppColors.primaryColor,
  700: AppColors.primaryColor,
  800: AppColors.primaryColor,
  900: AppColors.primaryColor,
};

//MaterialColor customColor = MaterialColor(0xFF93cd48, colorMap);
