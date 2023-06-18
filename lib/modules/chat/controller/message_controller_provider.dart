import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wazzup/models/message_model.dart';
import 'package:wazzup/modules/chat/controller/message_controller.dart';

final messagesProvider =
    StreamProvider.family<List<MessageModel>, String>((ref, chatId) {
  final messageController = ref.watch(messageControllerProvider.notifier);
  return messageController.getByChat(chatId);
});
