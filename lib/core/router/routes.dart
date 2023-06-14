import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:wazzup/modules/auth/controller/auth_controller_provider.dart';
import 'package:wazzup/modules/chat/router/chat_router.dart';

import '../../modules/auth/presentation/router/auth_router.dart';
import '../constants/app_routes.dart';

final routerProvider = Provider.family<GoRouter, WidgetRef>(
  (ref, WidgetRef widgetRef) {
    final key = GlobalKey<NavigatorState>();
    final authState = ref.watch(userProvider) != null;

    return GoRouter(
      navigatorKey: key,
      debugLogDiagnostics: kDebugMode,
      initialLocation: authState ? AppRoute.home.path : AppRoute.signIn.path,
      routes: <GoRoute>[
        ...chatRouter(widgetRef, authState),
        ...authRouter(authState),
      ],
    );
  },
);
