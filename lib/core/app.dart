import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wazzup/core/router/routes.dart';
import 'package:wazzup/core/theme/theme.dart';

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final routers = ref.watch(routerProvider);
    return MaterialApp.router(
      routerConfig: routers,
      title: 'Flutter Demo',
      theme: theme,
    );
  }
}
