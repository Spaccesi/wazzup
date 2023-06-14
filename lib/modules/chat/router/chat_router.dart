import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:wazzup/core/constants/app_routes.dart';
import 'package:wazzup/modules/home_page.dart';

import '../../../core/guards/auth_guard.dart';

List<GoRoute> chatRouter(WidgetRef ref, bool authState) => <GoRoute>[
      GoRoute(
        path: AppRoute.home.path,
        name: AppRoute.home.name,
        builder: (context, state) => const MyHomePage(title: 'Chat List'),
        redirect: (context, state) => authGuard(authState),
      ),
      GoRoute(
        path: AppRoute.chat.path,
        name: AppRoute.chat.name,
        redirect: (context, state) => authGuard(authState),
        builder: (context, state) => const MyHomePage(title: 'Chat id'),
        // ref
        //     .watch(
        //       teamDataProvider(
        //         state.pathParameters.entries.first.value,
        //       ),
        //     )
        //     .when(
        //       data: (data) => TeamPage(team: data),
        //       error: (error, track) => ErrorMessage(error.toString()),
        //       loading: () => const Loading(),
        //     ),
      ),
    ];
