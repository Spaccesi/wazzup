import 'package:flutter/material.dart';
import 'package:wazzup/models/profile_model.dart';

import '../../../core/constants/asset_constant.dart';

class ProfileListTile extends StatelessWidget {
  const ProfileListTile(this.profile, {super.key, this.onTap});
  final ProfileModel profile;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(profile.name),
      subtitle: Text(profile.email),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(
            profile.photo ?? AssetConstant.profileDefaultImage.path),
        // radius: 36,
      ),
      onTap: onTap,
    );
  }
}
