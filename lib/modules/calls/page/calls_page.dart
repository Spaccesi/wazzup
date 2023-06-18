import 'package:flutter/material.dart';

class CallsPage extends StatelessWidget {
  const CallsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        ListTile(
          leading: CircleAvatar(
            radius: 36,
            child: Positioned(
              right: 0,
              bottom: 0,
              child: Icon(Icons.link),
            ),
          ),
          title: Text('Create call link'),
          subtitle: Text('Share a link for your WazzUp call'),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                'To start callink contacts who have WazzUp, you will need to keep waiting because this feature is not implemented. Sorry.',
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
