import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wazzup/core/router/helper/go_route_helper.dart';
import 'package:wazzup/core/theme/helpers/colors_extension.dart';
import 'package:wazzup/core/theme/helpers/texts_extension.dart';
import 'package:wazzup/core/widgets/alert_dialog.dart';
import 'package:wazzup/l10n/helpers/localizations_extension.dart';
import 'package:wazzup/models/profile_model.dart';
import 'package:wazzup/modules/chat/controller/chat_controller.dart';
import 'package:wazzup/modules/profile/controller/profile_controller_provider.dart';

import '../../../core/constants/app_routes.dart';
import '../../../core/widgets/error_widget.dart';
import '../../../core/widgets/loaging_widget.dart';

class CreateChatPage extends ConsumerStatefulWidget {
  const CreateChatPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CreateChatPageState();
}

class _CreateChatPageState extends ConsumerState<CreateChatPage> {
  @override
  void initState() {
    super.initState();
  }

  bool _isGroup = false;
  final List<ProfileModel> _chatMembers = [];

  void onClickOnMember(ProfileModel profile) async {
    if (_isGroup) {
      if (_chatMembers.contains(profile)) {
        setState(() {
          _chatMembers.remove(profile);
        });
      } else {
        setState(() {
          _chatMembers.add(profile);
        });
      }
    } else {
      await ref
          .watch(chatControllerProvider.notifier)
          .exists(profile.uid)
          .first
          .then((value) {
        if (value.isNotEmpty) {
          context.goRoute(
            AppRoute.chat,
            extra: value.first,
            id: value.first.id,
            replace: true,
          );
        } else {
          context.goRoute(
            AppRoute.creatingChat,
            extra: profile,
            replace: true,
          );
        }
      });
    }
  }

  @override
  void dispose() {
    _isGroup = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: false,
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.search),
            ),
            PopupMenuButton(
              itemBuilder: (context) => [
                PopupMenuItem(
                  child: Text(context.loc.inviteAFriend),
                  onTap: () => showDialog(
                      context: context,
                      builder: (BuildContext context) =>
                          const CustomAlertDialog(title: 'Sorry')),
                ),
                PopupMenuItem(
                  child: Text(context.loc.contacts),
                  onTap: () {},
                ),
                PopupMenuItem(
                  child: Text(context.loc.refresh),
                ),
                PopupMenuItem(
                  child: Text(context.loc.help),
                ),
              ],
              icon: const Icon(Icons.more_vert),
            ),
          ],
          title: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(context.loc.selectAContact),
              Text(
                '646 ${context.loc.contacts.toLowerCase()}',
                style: context.texts.bodyMedium,
              ),
            ],
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _isGroup != true
                ? Column(
                    children: [
                      ListTile(
                        onTap: () => setState(() {
                          _isGroup = true;
                        }),
                        leading: CircleAvatar(
                          child: Icon(
                            Icons.group,
                            color: context.colors.onPrimary,
                          ),
                        ),
                        title: Text(context.loc.newGroup),
                      ),
                      ListTile(
                        onTap: () => setState(() {
                          _isGroup = true;
                        }),
                        trailing: const Icon(
                          Icons.qr_code_scanner_rounded,
                          color: Colors.grey,
                        ),
                        leading: CircleAvatar(
                          child: Icon(
                            Icons.person_add,
                            color: context.colors.onPrimary,
                          ),
                        ),
                        title: Text(context.loc.newContact),
                      ),
                      ListTile(
                        onTap: () => setState(() {
                          _isGroup = true;
                        }),
                        leading: CircleAvatar(
                          child: Icon(
                            Icons.groups_2_rounded,
                            color: context.colors.onPrimary,
                          ),
                        ),
                        title: Text(context.loc.newCommunity),
                      ),
                    ],
                  )
                : Row(
                    children: [
                      const CircleAvatar(),
                      const Expanded(child: TextField()),
                      IconButton(
                        onPressed: () => setState(() {
                          _isGroup = false;
                        }),
                        icon: const Icon(Icons.close),
                      ),
                    ],
                  ),
            SizedBox(
              height: 40,
              child: ListView.builder(
                itemCount: _chatMembers.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: ((context, index) =>
                    Text(_chatMembers[index].name)),
              ),
            ),
            const Text('Contactos en WazzUp!'),
            ref.watch(profilesProvider).when(
                  data: (data) => ListView.builder(
                    shrinkWrap: true,
                    itemCount: data.length,
                    itemBuilder: (context, index) => ListTile(
                      onTap: () => onClickOnMember(data[index]),
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(data[index].photo!),
                      ),
                      title: Text(
                        data[index].name,
                        overflow: TextOverflow.ellipsis,
                      ),
                      subtitle: Text(
                        data[index].email,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  error: (e, t) => ErrorCustomWidget(error: e.toString()),
                  loading: () => const LoadingCustomWidget(),
                ),
          ],
        ));
  }
}
