import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart'
    show AppLocalizations;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wazzup/core/router/routes.dart';
import 'package:wazzup/core/theme/theme.dart';
import 'package:wazzup/l10n/shared/localizations_extension.dart';

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final routers = ref.watch(routerProvider(ref));
    return MaterialApp.router(
      onGenerateTitle: (context) => context.loc.appTitle,
      localizationsDelegates:
          AppLocalizations.localizationsDelegates, // Internationalization
      supportedLocales:
          AppLocalizations.supportedLocales, // Internationalization
      routerConfig: routers,
      theme: theme,
    );
  }
}
