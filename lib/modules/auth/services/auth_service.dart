import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:wazzup/core/typedefs/failure.dart';
import 'package:wazzup/core/typedefs/typedefs.dart';
import 'package:wazzup/firebase/firebase_constants.dart';
import 'package:wazzup/firebase/firebase_provider.dart';

import '../../../models/profile_model.dart';

final authServiceProvider = Provider<AuthService>(
  (ref) => AuthService(
    firestore: ref.read(firestoreProvider),
    auth: ref.read(authProvider),
    googleSignIn: ref.read(googleSignInProvider),
  ),
);

class AuthService {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;
  final GoogleSignIn _googleSignIn;

  CollectionReference get _profiles =>
      _firestore.collection(FirebaseConstants.profilesCollection);

  Stream<User?> get authStateChange => _auth.authStateChanges();

  AuthService({
    required FirebaseFirestore firestore,
    required FirebaseAuth auth,
    required GoogleSignIn googleSignIn,
  })  : _auth = auth,
        _firestore = firestore,
        _googleSignIn = googleSignIn;

  FutureEither<UserCredential> signInWithGoogle() async {
    try {
      ProfileModel user;

      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      final googleAuth = await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      UserCredential userCredential =
          await _auth.signInWithCredential(credential);

      if (userCredential.additionalUserInfo!.isNewUser) {
        user = ProfileModel(
          name: userCredential.user!.displayName ?? 'No name',
          uid: userCredential.user!.uid,
          photo: userCredential.user!.photoURL,
          email: userCredential.user!.email!,
        );
        await _profiles.doc(user.uid).set(user.toMap());
      } else {
        user = await getUserData(userCredential.user!.uid).first;
      }
      return right(userCredential);
    } on FirebaseAuthException catch (e) {
      throw e.message!;
    } on PlatformException catch (e) {
      throw e.message!;
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  Stream<ProfileModel> getUserData(String uid) {
    return _profiles.doc(uid).snapshots().map(
          (profile) => ProfileModel.fromMap(profile),
        );
  }

  Future logOut() async {
    await _auth.signOut();
  }
}
