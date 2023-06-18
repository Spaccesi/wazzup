import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:wazzup/core/typedefs/failure.dart';
import 'package:wazzup/core/typedefs/typedefs.dart';
import 'package:wazzup/models/message_model.dart';

import '../../../firebase/firebase_constants.dart';
import '../../../firebase/firebase_provider.dart';

final messageServiceProvider = Provider<MessageService>(
  (ref) => MessageService(
    firestore: ref.read(firestoreProvider),
  ),
);

class MessageService {
  final FirebaseFirestore _firestore;

  MessageService({
    required FirebaseFirestore firestore,
  }) : _firestore = firestore;

  CollectionReference get _messages => _firestore.collection(
        FirebaseConstants.messagesCollection,
      );

  FutureEither<bool> create(MessageModel message) async {
    try {
      _messages.doc().set(message.toMap());
      return right(true);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  Stream<List<MessageModel>> getByChat(String chatId) {
    return _messages.where('chatId', isEqualTo: chatId).snapshots().map(
          (snapshot) => snapshot.docs
              .map(
                (message) => MessageModel.fromMap(message),
              )
              .toList(),
        );
    // TODO: Pagination
    // .limit(10)
    // .orderBy("updatedAt", descending: true)
  }
}
