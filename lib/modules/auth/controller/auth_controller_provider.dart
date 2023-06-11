import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/profile_model.dart';
import 'auth_controller.dart';

final userProvider = StateProvider<ProfileModel?>((ref) {
  final currentUser = ref.watch(authStateChangeProvider).value;

  if (currentUser != null) {
    return ProfileModel(
      uid: currentUser.uid,
      name: currentUser.displayName ?? '--',
      photo: currentUser.photoURL ?? '',
      email: currentUser.email ?? '',
    );
  }
  return null;
});

final authStateChangeProvider = StreamProvider<User?>((ref) {
  final authController = ref.watch(authControllerProvider.notifier);
  return authController.authStateChange;
});

final getUserDataProvider = StreamProvider.family((ref, String uid) {
  final authController = ref.watch(authControllerProvider.notifier);
  return authController.getUserData(uid);
});
