import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/chat_model.dart';
import 'chat_controller.dart';

final chatsProvider = StreamProvider<List<ChatModel>>((ref) {
  final chatController = ref.watch(chatControllerProvider.notifier);
  return chatController.getAllCurrentUser();
});
