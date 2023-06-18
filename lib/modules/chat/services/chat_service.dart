import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';

import '../../../core/typedefs/failure.dart';
import '../../../core/typedefs/typedefs.dart';
import '../../../firebase/firebase_constants.dart';
import '../../../firebase/firebase_provider.dart';
import '../../../models/chat_model.dart';

final chatServiceProvider = Provider<ChatService>(
  (ref) => ChatService(
    firestore: ref.read(firestoreProvider),
  ),
);

class ChatService {
  final FirebaseFirestore _firestore;

  ChatService({
    required FirebaseFirestore firestore,
  }) : _firestore = firestore;

  CollectionReference get _chats => _firestore.collection(
        FirebaseConstants.chatsCollection,
      );

  // Create chat
  FutureEither<String> create(ChatModel chat) async {
    try {
      final doc = _chats.doc();
      await doc.set(chat.toMap());
      return right(doc.id);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  // Get user chats
  Stream<List<ChatModel>> getAllByUser(String userId) {
    final chats =
        _chats.where("memberIds", arrayContains: userId).snapshots().map(
              (snapshot) =>
                  snapshot.docs.map((chat) => ChatModel.fromMap(chat)).toList(),
            );
    // TODO: Pagination
    // .limit(10)
    // .orderBy("updatedAt", descending: true)

    return chats;
  }

  // Get chat by id
  Stream<ChatModel> get(String chatId) {
    return _chats.doc(chatId).snapshots().map(
          (chat) => ChatModel.fromMap(chat),
        );
  }

  Future update(ChatModel chat) async {
    return _chats.doc(chat.id).update(chat.toMap());
  }

  Future delete(ChatModel chat) async {
    return _chats.doc(chat.id).delete();
  }

  Stream<List<ChatModel>> exist(String user1, String user2) {
    final chat = _chats
        .where('memberIds', whereIn: [
          [user1, user2],
          [user2, user1]
        ])
        .where('isGroup', isEqualTo: false)
        .snapshots()
        .map((c) => c.docs.map((e) => ChatModel.fromMap(e)).toList());

    return chat;
  }
}
