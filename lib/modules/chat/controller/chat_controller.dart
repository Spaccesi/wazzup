import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wazzup/core/constants/app_routes.dart';
import 'package:wazzup/core/router/helper/go_route_helper.dart';

import '../../../models/chat_model.dart';
import '../../auth/controller/auth_controller_provider.dart';
import '../services/chat_service.dart';

final chatControllerProvider = StateNotifierProvider<ChatController, bool>(
  (ref) => ChatController(
    chatRepository: ref.watch(chatServiceProvider),
    ref: ref,
  ),
);

class ChatController extends StateNotifier<bool> {
  final ChatService _chatRepository;
  final Ref _ref;

  ChatController({
    required ChatService chatRepository,
    required Ref ref,
  })  : _chatRepository = chatRepository,
        _ref = ref,
        super(false);

  Stream<List<ChatModel>> getAllCurrentUser() {
    // state = true;
    final currentUser = _ref.watch(userProvider)!;
    final chats = _chatRepository.getAllByUser(currentUser.uid);
    // state = false;
    return chats;
  }

  void create(BuildContext context, ChatModel chat) async {
    final res = await _chatRepository.create(chat);
    res.fold(
      (l) {},
      (r) {
        context.goRoute(AppRoute.chat, id: r, replace: true);
        return r;
      },
    );
  }

  Stream<List<ChatModel>> exists(String user) {
    final currentUser = _ref.watch(userProvider)!;
    return _chatRepository.exist(currentUser.uid, user);
  }

  Stream<ChatModel> get(String chatId) => _chatRepository.get(chatId);

  // TODO: Leave chat
}
