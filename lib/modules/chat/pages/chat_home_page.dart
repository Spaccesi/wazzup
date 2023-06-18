import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wazzup/core/constants/app_routes.dart';
import 'package:wazzup/core/router/helper/go_route_helper.dart';
import 'package:wazzup/core/widgets/empty_list_widget.dart';
import 'package:wazzup/core/widgets/loaging_widget.dart';
import 'package:wazzup/l10n/helpers/localizations_extension.dart';
import 'package:wazzup/modules/calls/page/calls_page.dart';
import 'package:wazzup/modules/chat/widgets/chat_list_title.dart';

import '../../../core/widgets/error_widget.dart';
import '../../communities/pages/communities_page.dart';
import '../../status/page/status_page.dart';
import '../controller/chat_controller_provider.dart';

class ChatHomePage extends ConsumerStatefulWidget {
  const ChatHomePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ChatHomePageState();
}

class _ChatHomePageState extends ConsumerState<ChatHomePage>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _tabController.animateTo(1);
  }

  @override
  Widget build(BuildContext context) {
    final appBarKey = GlobalKey();
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.goRoute(AppRoute.createChat),
        elevation: 0,
        isExtended: true,
        child: const Icon(Icons.message),
      ),
      appBar: AppBar(
        key: appBarKey,
        title: const Text('WazzUp!'),
        centerTitle: false,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.camera_alt_outlined),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search),
          ),
          PopupMenuButton(
            itemBuilder: (context) => [
              PopupMenuItem(
                child: Text(context.loc.newGroup),
              ),
              PopupMenuItem(
                enabled: false,
                child: Text(context.loc.newBroadcast),
              ),
              PopupMenuItem(
                enabled: false,
                child: Text(context.loc.linkedDevices),
              ),
              PopupMenuItem(
                enabled: false,
                child: Text(context.loc.starredMessages),
              ),
              PopupMenuItem(
                child: Text(context.loc.settings),
              ),
            ],
            icon: const Icon(Icons.more_vert),
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          tabs: [
            const Tab(
              icon: Icon(Icons.groups_2_sharp),
            ),
            SizedBox(
              width: (MediaQuery.of(context).size.width - 150) / 3,
              child: Tab(
                text: context.loc.chats,
              ),
            ),
            SizedBox(
              width: (MediaQuery.of(context).size.width - 150) / 3,
              child: Tab(
                child: Text(context.loc.status),
              ),
            ),
            SizedBox(
              width: (MediaQuery.of(context).size.width - 150) / 3,
              child: Tab(
                child: Text(context.loc.calls),
              ),
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          const CommunitiesPage(),
          Container(
            child: ref.watch(chatsProvider).when(
                  data: (data) => data.isNotEmpty
                      ? ListView.builder(
                          itemCount: data.length,
                          itemBuilder: (context, index) =>
                              ChatListTitle(data[index]),
                        )
                      : EmptyListWidget(
                          createButton: ElevatedButton(
                              onPressed: () {},
                              child: const Text('Create chat')),
                        ),
                  error: (error, stackTrace) => ErrorCustomWidget(
                    error: error.toString(),
                  ),
                  loading: () => const LoadingCustomWidget(),
                ),
          ),
          const StatusPage(),
          const CallsPage(),
        ],
      ),
    );
  }
}
