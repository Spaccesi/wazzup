import 'package:flutter/material.dart' show Theme, TextTheme;
import 'package:flutter/widgets.dart' show BuildContext;

extension TextThemeExtension on BuildContext {
  TextTheme get texts => Theme.of(this).textTheme;
}
