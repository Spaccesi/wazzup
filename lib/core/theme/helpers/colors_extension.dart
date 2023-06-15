import 'package:flutter/material.dart' show Theme, ColorScheme;
import 'package:flutter/widgets.dart' show BuildContext;

extension ColorSchemeExtension on BuildContext {
  ColorScheme get colors => Theme.of(this).colorScheme;
}
