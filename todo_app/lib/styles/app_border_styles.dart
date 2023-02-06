import 'package:flutter/material.dart';
import 'package:todo_app/themes/app_colors.dart';

class AppBorderStyles {
 static OutlineInputBorder get inputBorder =>
      OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: AppColors.inputBorderColor));

}
