import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wazzup/core/constants/app_routes.dart';
import 'package:wazzup/core/router/helper/go_route_helper.dart';
import 'package:wazzup/models/chat_model.dart';
import 'package:wazzup/modules/auth/controller/auth_controller_provider.dart';

class ChatListTitle extends ConsumerWidget {
  const ChatListTitle(this.chat, {super.key});
  final ChatModel chat;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUser = ref.watch(userProvider)!;
    final chatPhoto = chat.isGroup
        ? chat.photo!
        : chat.caches
            .firstWhere((element) => element.uid != currentUser.uid)
            .photo;
    final chatName = chat.isGroup
        ? chat.name!
        : chat.caches
            .firstWhere((element) => element.uid != currentUser.uid)
            .name;
    return ListTile(
      onTap: () => context.goRoute(AppRoute.chat, extra: chat, id: chat.id),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(chatPhoto!),
        // radius: 36,
      ),
      title: Text(
        chatName,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Text(
        currentUser.uid,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
