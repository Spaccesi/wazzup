import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wazzup/modules/auth/controller/auth_controller_provider.dart';

import '../../../models/profile_model.dart';
import '../services/profile_service.dart';

final profileControllerProvider =
    ChangeNotifierProvider<ProfileController>((ref) {
  final model = ProfileController(
    profileService: ref.read(profileServiceProvider),
    ref: ref,
  );
  model.init();
  return model;
});

class ProfileController extends ChangeNotifier {
  final ProfileService _profileService;
  final Ref _ref;

  ProfileController({
    required ProfileService profileService,
    required Ref ref,
  })  : _profileService = profileService,
        _ref = ref,
        super();

  final List<ProfileModel> items = [];
  final limit = 6;

  bool loading = true;
  bool busy = true;
  bool noMoreItems = false;

  void init() async {
    try {
      final newProfiles = await _profileService.getAll(limit: limit);
      items.addAll(newProfiles);

      loading = false;
      busy = false;

      notifyListeners();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void loadMore() async {
    if (noMoreItems) {
      return;
    }
    busy = true;
    try {
      Timer(const Duration(seconds: 2), () {});
      final moreItemsDocs = await _profileService.getAll(
        limit: limit,
        lastProfile: items.last,
      );
      items.addAll(moreItemsDocs);
      loading = moreItemsDocs.isNotEmpty;
      if (moreItemsDocs.length < limit) {
        noMoreItems = true;
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    busy = false;
    notifyListeners();
  }

  Stream<ProfileModel> getCurrentUser() {
    final currentUser = _ref.watch(userProvider)!;
    return _profileService.get(currentUser.uid);
  }

  Stream<ProfileModel> get(String profileId) => _profileService.get(profileId);
}
