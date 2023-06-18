import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wazzup/core/constants/app_routes.dart';
import 'package:wazzup/core/router/helper/go_route_helper.dart';
import 'package:wazzup/models/message_model.dart';
import 'package:wazzup/modules/auth/controller/auth_controller_provider.dart';
import 'package:wazzup/modules/chat/services/chat_service.dart';
import 'package:wazzup/modules/chat/services/message_service.dart';

import '../../../models/chat_model.dart';
import '../../../models/profile_model.dart';

final messageControllerProvider =
    StateNotifierProvider<MessageController, bool>(
  (ref) => MessageController(
    messageService: ref.watch(messageServiceProvider),
    chatService: ref.watch(chatServiceProvider),
    ref: ref,
  ),
);

class MessageController extends StateNotifier<bool> {
  final MessageService _messageService;
  final ChatService _chatService;
  final Ref _ref;

  MessageController({
    required MessageService messageService,
    required ChatService chatService,
    required Ref ref,
  })  : _messageService = messageService,
        _chatService = chatService,
        _ref = ref,
        super(false);

  Stream<List<MessageModel>> getByChat(String chatId) =>
      _messageService.getByChat(chatId);

  void send({
    required BuildContext context,
    String? chatId,
    required String message,
    ProfileModel? otherProfile,
  }) async {
    final currenUser = _ref.watch(userProvider)!;
    if (chatId == null) {
      final newChat = ChatModel(
        caches: [currenUser, otherProfile!],
        createdAt: DateTime.now(),
        isGroup: false,
        memberIds: [currenUser.uid, otherProfile.uid],
      );
      final chat = await _chatService.create(newChat);
      chat.fold((l) => null, (r1) async {
        final newMessage = MessageModel(
            senderId: currenUser.uid,
            sendedAt: DateTime.now(),
            chatId: r1,
            message: message);
        final resMess = await _messageService.create(newMessage);
        resMess.fold(
          (l) => null,
          (r) => context.goRoute(
            AppRoute.chat,
            extra: newChat.copyWith(id: r1),
            id: r1,
            replace: true,
          ),
        );
      });
    } else {
      final newMessage = MessageModel(
          senderId: currenUser.uid,
          sendedAt: DateTime.now(),
          chatId: chatId,
          message: message);

      await _messageService.create(newMessage);
    }
  }
}
