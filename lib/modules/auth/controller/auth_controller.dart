import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/utils/show_snack_bar.dart';
import '../../../models/profile_model.dart';
import '../services/auth_service.dart';
import 'auth_controller_provider.dart';

final authControllerProvider = StateNotifierProvider<AuthController, bool>(
  (ref) => AuthController(
    authService: ref.watch(authServiceProvider),
    ref: ref,
  ),
);

class AuthController extends StateNotifier<bool> {
  final AuthService _authService;
  final Ref _ref;

  AuthController({
    required AuthService authService,
    required Ref ref,
  })  : _authService = authService,
        _ref = ref,
        super(false);

  Stream<User?> get authStateChange => _authService.authStateChange;

  void signInWithGoogle(BuildContext context) async {
    state = true;
    final user = await _authService.signInWithGoogle();
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
    return _authService.getUserData(uid);
  }

  void signInWithEmailAndLink(String email) {}

  Future signOut() async {
    _authService.logOut();
    _ref.read(userProvider.notifier).update((state) => state = null);
  }
}
