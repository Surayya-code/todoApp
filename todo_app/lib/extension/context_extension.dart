import 'package:flutter/material.dart';

extension ContextExtension on BuildContext{
  double get deviceWidth => MediaQuery.of(this).size.width;
  double get deviceHeight  => MediaQuery.of(this).size.height;
  ThemeData get deviceTheme => Theme.of(this);

  EdgeInsets get paddingAll24 => const EdgeInsets.all(24);
  
}