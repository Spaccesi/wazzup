import 'package:flutter/material.dart';
import 'package:wazzup/l10n/helpers/localizations_extension.dart';

class CustomAlertDialog extends StatelessWidget {
  const CustomAlertDialog({
    super.key,
    this.title,
    this.description,
  });
  final String? title;
  final String? description;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title ?? ''),
      content: Text(description ?? ''),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.pop(context, null);
            },
            child: Text(context.loc.ok)),
      ],
    );
  }
}
