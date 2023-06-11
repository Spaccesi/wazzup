import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/utils/show_snack_bar.dart';
import '../../../models/profile_model.dart';
import '../services/auth_service.dart';
import 'auth_controller_provider.dart';

final authControllerProvider = StateNotifierProvider<AuthController, bool>(
  (ref) => AuthController(
    authRepository: ref.watch(authRepositoryProvider),
    ref: ref,
  ),
);

class AuthController extends StateNotifier<bool> {
  final AuthRepository _authRepository;
  final Ref _ref;

  AuthController({
    required AuthRepository authRepository,
    required Ref ref,
  })  : _authRepository = authRepository,
        _ref = ref,
        super(false);

  Stream<User?> get authStateChange => _authRepository.authStateChange;

  void signInWithGoogle(BuildContext context) async {
    state = true;
    final user = await _authRepository.signInWithGoogle();
    state = false;
    user.fold(
      (l) => showSnackBar(context, l.message),
      (userModel) => _ref.read(userProvider.notifier).update(
            (state) => state = ProfileModel(
              email: userModel.user!.email!,
              name: userModel.user!.displayName!,
              uid: userModel.user!.uid,
              photo: userModel.user!.photoURL,
            ),
          ),
    );
  }

  Stream<ProfileModel> getUserData(String uid) {
    return _authRepository.getUserData(uid);
  }

  void signInWithEmailAndLink(String email) {}

  Future signOut() async {
    _authRepository.logOut();
    _ref.read(userProvider.notifier).update((state) => state = null);
  }
}
