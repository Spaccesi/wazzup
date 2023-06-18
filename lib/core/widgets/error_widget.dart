import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:wazzup/l10n/helpers/localizations_extension.dart';

class ErrorCustomWidget extends StatelessWidget {
  const ErrorCustomWidget({super.key, this.error});
  final String? error;

  @override
  Widget build(BuildContext context) {
    debugPrint(error);
    return Center(
      child: Column(
        children: [
          Text(context.loc.somethingWentWrong),
          kDebugMode ? Text(error ?? '') : const SizedBox.shrink(),
        ],
      ),
    );
  }
}
