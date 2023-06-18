import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:wazzup/core/constants/app_routes.dart';
import 'package:wazzup/models/chat_model.dart';
import 'package:wazzup/models/profile_model.dart';
import 'package:wazzup/modules/chat/pages/chat_home_page.dart';
import 'package:wazzup/modules/chat/pages/chat_page.dart';
import 'package:wazzup/modules/chat/pages/create_group_chat.dart';

import '../../../core/guards/auth_guard.dart';

List<GoRoute> chatRouter(WidgetRef ref, bool authState) => <GoRoute>[
      GoRoute(
        path: AppRoute.home.path,
        name: AppRoute.home.name,
        builder: (context, state) => const ChatHomePage(),
        redirect: (context, state) => authGuard(authState),
      ),
      GoRoute(
        path: AppRoute.createChat.path,
        name: AppRoute.createChat.name,
        builder: (context, state) => const CreateChatPage(),
        redirect: (context, state) => authGuard(authState),
      ),
      GoRoute(
        path: AppRoute.createGroupChat.path,
        name: AppRoute.createGroupChat.name,
        builder: (context, state) => const ChatHomePage(),
        redirect: (context, state) => authGuard(authState),
      ),
      GoRoute(
        path: AppRoute.creatingChat.path,
        name: AppRoute.creatingChat.name,
        redirect: (context, state) => authGuard(authState),
        builder: (context, state) =>
            ChatPage(profile: state.extra as ProfileModel),
      ),
      GoRoute(
        path: AppRoute.chat.path,
        name: AppRoute.chat.name,
        redirect: (context, state) => authGuard(authState),
        builder: (context, state) => ChatPage(
          chat: state.extra as ChatModel,
        ),
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
