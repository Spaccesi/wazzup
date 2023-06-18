import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wazzup/models/profile_model.dart';

import '../../../firebase/firebase_constants.dart';
import '../../../firebase/firebase_provider.dart';

final profileServiceProvider = Provider<ProfileService>(
  (ref) => ProfileService(
    firestore: ref.read(firestoreProvider),
  ),
);

class ProfileService {
  final FirebaseFirestore _firestore;

  ProfileService({
    required FirebaseFirestore firestore,
  }) : _firestore = firestore;

  CollectionReference get _profiles => _firestore.collection(
        FirebaseConstants.profilesCollection,
      );

  Stream<List<ProfileModel>> getAll() {
    final profiles = _profiles.snapshots().map(
          (snapshot) => snapshot.docs
              .map((profile) => ProfileModel.fromMap(profile))
              .toList(),
        );
    // TODO: Pagination
    // .limit(10)
    // .orderBy("updatedAt", descending: true)

    return profiles;
  }

  Stream<ProfileModel> get(String profileId) => _profiles
      .doc(profileId)
      .snapshots()
      .map((snapshot) => ProfileModel.fromMap(snapshot));

  Future update(ProfileModel profile) async {
    return _profiles.doc(profile.uid).update(profile.toMap());
  }

  Future delete(ProfileModel profile) async {
    return _profiles.doc(profile.uid).delete();
  }
}
