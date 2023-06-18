import 'package:flutter/material.dart';
import 'package:wazzup/core/widgets/alert_dialog.dart';

class CommunitiesPage extends StatelessWidget {
  const CommunitiesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text('Inroducing communities'),
        const Text('Communities'),
        ElevatedButton(
          onPressed: () => showDialog(
              context: context,
              builder: (context) => const CustomAlertDialog(
                    title: 'Nothing here :(',
                  )),
          child: const Text('Start your community'),
        )
      ],
    );
  }
}
