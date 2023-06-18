import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'message_model.freezed.dart';

@freezed
abstract class MessageModel implements _$MessageModel {
  const MessageModel._();
  factory MessageModel({
    String? id,
    required String senderId,
    required DateTime sendedAt,
    required String chatId,
    String? message,
    String? attachedFile,
  }) = _MessageModel;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'senderId': senderId,
      'message': message,
      'chatId': chatId,
      'attachedFile': attachedFile,
      'sendedAt': Timestamp.fromDate(sendedAt),
    };
  }

  factory MessageModel.fromMap(DocumentSnapshot doc) {
    final map = doc.data() as Map<String, dynamic>;
    return MessageModel(
      id: doc.id,
      senderId: map['senderId'] as String,
      message: map['message'] != null ? map['message'] as String : null,
      attachedFile:
          map['attachedFile'] != null ? map['attachedFile'] as String : null,
      sendedAt: (map['sendedAt'] as Timestamp).toDate(),
      chatId: map['chatId'],
    );
  }
}
