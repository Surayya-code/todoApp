import 'package:flutter/material.dart';
import 'package:todo_app/themes/app_colors.dart';

class AppTextStyles {
  static TextStyle get appBarTitleStyle => const TextStyle(
        fontSize: 22,
        color: AppColors.textColor,
        fontWeight: FontWeight.bold,
      );
   static TextStyle  listTileTitleStyle(bool isChecked) => 
    TextStyle(
        fontSize: 18,
        color: AppColors.textColor,
        fontWeight: FontWeight.bold,
        decoration:isChecked ? TextDecoration.lineThrough: TextDecoration.none,
      );
   static TextStyle  listTileSubtitleStyle(bool isChecked) => 
    TextStyle(
        fontSize: 16,
        color: AppColors.textColor,
        fontWeight: FontWeight.bold,
        decoration:isChecked ? TextDecoration.lineThrough: TextDecoration.none,
      );
}
