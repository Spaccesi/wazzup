import 'package:flutter/material.dart';

ThemeData theme = ThemeData(
  colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
  useMaterial3: true,
  listTileTheme: const ListTileThemeData(
    iconColor: Colors.white, dense: true,
    // contentPadding: EdgeInsets.all(12),
  ),
  buttonTheme: const ButtonThemeData(minWidth: double.infinity),
);
