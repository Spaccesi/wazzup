import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:wazzup/modules/home_page.dart';

import 'app_routes.dart';

final routerProvider = Provider<GoRouter>(
  (ref) {
    final key = GlobalKey<NavigatorState>();

    return GoRouter(
      navigatorKey: key,
      debugLogDiagnostics: kDebugMode,
      initialLocation: AppRoute.home.path,
      routes: <GoRoute>[
        GoRoute(
          path: AppRoute.home.path,
          name: AppRoute.home.name,
          builder: (context, state) => const MyHomePage(title: 'Home'),
        ),
      ],
    );
  },
);
