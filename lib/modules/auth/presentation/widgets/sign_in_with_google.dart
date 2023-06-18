import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wazzup/l10n/helpers/localizations_extension.dart';

import '../../../../core/constants/asset_constant.dart';
import '../../controller/auth_controller.dart';

class SignInWithGoogleButton extends ConsumerWidget {
  const SignInWithGoogleButton({super.key});

  void signInWithGoogel(BuildContext context, WidgetRef ref) {
    ref.read(authControllerProvider.notifier).signInWithGoogle(context);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ElevatedButton.icon(
      onPressed: () => signInWithGoogel(context, ref),
      icon: Image.asset(
        AssetConstant.googleLogo.path,
        width: 32,
        height: 32,
      ),
      label: Text(
        context.loc.signInWithGoogle,
        style: const TextStyle(fontSize: 18),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.grey.shade500,
        minimumSize: const Size(double.infinity, 50),
        shape: const StadiumBorder(),
      ),
    );
  }
}
