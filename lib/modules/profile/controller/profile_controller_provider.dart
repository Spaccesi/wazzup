import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wazzup/models/profile_model.dart';

import 'profile_controller.dart';

final profilesProvider = StreamProvider<List<ProfileModel>>((ref) {
  final profileController = ref.watch(profileControllerProvider.notifier);
  return profileController.getAll();
});
