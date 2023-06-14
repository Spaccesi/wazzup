import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wazzup/models/message_model.dart';
import 'package:wazzup/modules/chat/services/chat_service.dart';
import 'package:wazzup/modules/chat/services/message_service.dart';

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

  void send(String? chatId, String message) async {
    //   final currentUser = _ref.watch(userProvider);

    //   MessageModel messageModel = MessageModel(
    //     senderId: currentUser!.uid,
    //     sendedAt: DateTime.now(),
    //     message: message,
    //   );
    //   _messageService.create(chatId, messageModel);
  }
}
