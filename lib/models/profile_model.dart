import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'profile_model.freezed.dart';

@freezed
abstract class ProfileModel implements _$ProfileModel {
  const ProfileModel._();
  factory ProfileModel({
    required String uid,
    required String name,
    required String email,
    String? photo,
  }) = _ProfileModel;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      // 'uid': uid,
      'name': name,
      'email': email,
      'photo': photo,
    };
  }

  Map<String, dynamic> toCache() {
    return <String, dynamic>{
      'uid': uid,
      'name': name,
      'email': email,
      'photo': photo,
    };
  }

  factory ProfileModel.fromMap(DocumentSnapshot doc) {
    final map = doc.data() as Map<String, dynamic>;
    return ProfileModel(
      uid: doc.id,
      email: map['email'] as String,
      name: map['name'] as String,
      photo: map['photo'] != null ? map['photo'] as String : null,
    );
  }

  factory ProfileModel.fromCache(Map<String, dynamic> map) {
    return ProfileModel(
      uid: map['uid'] as String,
      email: map['email'] as String,
      name: map['name'] as String,
      photo: map['photo'] != null ? map['photo'] as String : null,
    );
  }
}
