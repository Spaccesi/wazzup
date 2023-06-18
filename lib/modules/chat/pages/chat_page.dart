import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wazzup/core/widgets/error_widget.dart';
import 'package:wazzup/core/widgets/loaging_widget.dart';
import 'package:wazzup/models/profile_model.dart';
import 'package:wazzup/modules/auth/controller/auth_controller_provider.dart';
import 'package:wazzup/modules/chat/controller/message_controller.dart';
import 'package:wazzup/modules/chat/controller/message_controller_provider.dart';

import '../../../models/chat_model.dart';

class ChatPage extends ConsumerStatefulWidget {
  const ChatPage({this.profile, this.chat, super.key});
  final ProfileModel? profile;
  final ChatModel? chat;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ChatPageState();
}

class _ChatPageState extends ConsumerState<ChatPage> {
  final TextEditingController _message = TextEditingController();
  @override
  Widget build(BuildContext context) {
    late String chatName;
    late String chatPhoto;
    if (widget.profile != null) {
      chatName = widget.profile!.name;
      chatPhoto = widget.profile!.photo!;
    } else if (widget.chat != null && widget.chat!.isGroup == false) {
      final currentUser = ref.watch(userProvider)!;
      final profileToSHow = widget.chat!.caches
          .firstWhere((element) => element.uid != currentUser.uid);
      chatName = profileToSHow.name;
      chatPhoto = profileToSHow.photo!;
    } else if (widget.chat != null && widget.chat!.isGroup == true) {
      chatName = widget.chat!.name!;
      chatPhoto = widget.chat!.photo!;
    }
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.videocam)),
          IconButton(
              onPressed: () {}, icon: const Icon(Icons.local_phone_rounded)),
          PopupMenuButton(
            itemBuilder: (context) => widget.chat!.isGroup
                ? [
                    const PopupMenuItem(
                      child: Text('Group info'),
                    ),
                    const PopupMenuItem(
                      enabled: false,
                      child: Text('Group media'),
                    ),
                    const PopupMenuItem(
                      enabled: false,
                      child: Text('Search'),
                    ),
                    const PopupMenuItem(
                      enabled: false,
                      child: Text('Mute notifications'),
                    ),
                    const PopupMenuItem(
                      enabled: false,
                      child: Text('Mensajes desaparecidos'),
                    ),
                    const PopupMenuItem(
                      enabled: false,
                      child: Text('Wallpaper'),
                    ),
                    const PopupMenuItem(
                      child: Text('More'),
                    ), // report, exit group, clear chat, export chat, add shortcut
                  ]
                : [
                    const PopupMenuItem(
                      child: Text('Ver contacto'),
                    ),
                    const PopupMenuItem(
                      enabled: false,
                      child: Text('Media, links, and docs'),
                    ),
                    const PopupMenuItem(
                      enabled: false,
                      child: Text('Search'),
                    ),
                    const PopupMenuItem(
                      enabled: false,
                      child: Text('Mute notifications'),
                    ),
                    const PopupMenuItem(
                      child: Text('Mensajes desaparecidos'),
                    ),
                    const PopupMenuItem(
                      child: Text('Wallpaper'),
                    ),
                    const PopupMenuItem(
                      child: Text('More'),
                    ), // report, block, clear chat, export chat, add shortcut
                  ],
            icon: const Icon(Icons.more_vert),
          ),
        ],
        centerTitle: false,
        title: Expanded(
          child: Row(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(chatPhoto),
              ),
              const SizedBox(
                width: 8,
              ),
              Expanded(
                child: Text(
                  chatName,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
      body: widget.chat != null
          ? ref.watch(messagesProvider(widget.chat!.id!)).when(
                data: (data) => ListView.builder(
                  itemCount: data.length,
                  itemBuilder: ((context, index) => Text(
                        data[index].message ?? 'jaja',
                      )),
                ),
                error: (error, t) => ErrorCustomWidget(
                  error: error.toString(),
                ),
                loading: () => const LoadingCustomWidget(),
              )
          : const SizedBox.shrink(),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.only(
          bottom: 32,
          top: 6,
          left: 16,
          right: 16,
        ),
        width: double.infinity,
        // color: context.colors.background,
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: _message,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    gapPadding: 4,
                  ),
                  prefixIcon: IconButton(
                    icon: const Icon(Icons.emoji_emotions),
                    color: Colors.white,
                    onPressed: () {},
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 4,
                    horizontal: 0,
                  ),
                  suffixIcon: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.attach_file_outlined),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 12,
            ),
            FloatingActionButton(
              onPressed: () {
                ref.watch(messageControllerProvider.notifier).send(
                      context: context,
                      chatId: widget.chat?.id,
                      message: _message.text,
                      otherProfile: widget.profile,
                    );
                _message.text = '';
              },
              child: const Icon(Icons.send),
            ),
          ],
        ),
      ),
    );
  }
}
