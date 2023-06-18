import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wazzup/modules/auth/controller/auth_controller_provider.dart';

import '../../../models/profile_model.dart';
import '../services/profile_service.dart';

final profileControllerProvider = StateNotifierProvider<ChatController, bool>(
  (ref) => ChatController(
    profileService: ref.watch(profileServiceProvider),
    ref: ref,
  ),
);

class ChatController extends StateNotifier<bool> {
  final ProfileService _profileService;
  final Ref _ref;

  ChatController({
    required ProfileService profileService,
    required Ref ref,
  })  : _profileService = profileService,
        _ref = ref,
        super(false);

  Stream<List<ProfileModel>> getAll() {
    // state = true;
    final profiles = _profileService.getAll();
    // state = false;
    return profiles;
  }

  Stream<ProfileModel> getCurrentUser() {
    final currentUser = _ref.watch(userProvider)!;
    return _profileService.get(currentUser.uid);
  }

  Stream<ProfileModel> get(String profileId) => _profileService.get(profileId);
}
