// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wazzup/models/profile_model.dart';

part 'chat_model.freezed.dart';

@freezed
abstract class ChatModel implements _$ChatModel {
  const ChatModel._();
  factory ChatModel({
    String? id,
    String? name,
    String? photo,
    required bool isGroup,
    required List<String> memberIds,
    required List<ProfileModel> caches,
    required DateTime createdAt,
  }) = _ChatModel;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'photo': photo,
      'isGroup': isGroup,
      'memberIds': memberIds,
      'caches': caches.map((x) => x.toMap()).toList(),
      'createdAt': Timestamp.fromDate(createdAt),
    };
  }

  factory ChatModel.fromMap(DocumentSnapshot doc) {
    final map = doc.data() as Map<String, dynamic>;
    return ChatModel(
      id: doc.id,
      name: map['name'] != null ? map['name'] as String : null,
      photo: map['photo'] != null ? map['photo'] as String : null,
      isGroup: map['isGroup'] as bool,
      memberIds: List<String>.from(map['memberIds']),
      caches: List<ProfileModel>.from(
        map['caches'].map<ProfileModel>(
          (x) => ProfileModel.fromMap(x),
        ),
      ),
      createdAt: (map['createdAt'] as Timestamp).toDate(),
    );
  }
}
