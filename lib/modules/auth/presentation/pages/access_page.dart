import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wazzup/l10n/helpers/localizations_extension.dart';

import '../widgets/sign_in_with_google.dart';

class AccessPage extends StatefulWidget {
  const AccessPage({super.key});

  @override
  State<AccessPage> createState() => _AccessPageState();
}

class _AccessPageState extends State<AccessPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              context.loc.wellcomeToWazzUp,
            ),
            Consumer(
              builder: (BuildContext context, WidgetRef ref, Widget? child) {
                return const SignInWithGoogleButton();
              },
            ),
          ],
        ),
      ),
    );
  }
}
