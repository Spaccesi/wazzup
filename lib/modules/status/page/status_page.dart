import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wazzup/core/theme/helpers/colors_extension.dart';
import 'package:wazzup/core/theme/helpers/texts_extension.dart';
import 'package:wazzup/modules/auth/controller/auth_controller_provider.dart';

class StatusPage extends ConsumerWidget {
  const StatusPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUser = ref.watch(userProvider)!;
    return Column(
      children: [
        ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(currentUser.photo!),
            radius: 36,
            child: Align(
              alignment: Alignment.bottomRight,
              child: Container(
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                child: Icon(
                  Icons.add_circle,
                  size: 28,
                  color: context.colors.primary,
                ),
              ),
            ),
          ),
          title: const Text('My status'),
          subtitle: const Text('Tap to add status update'),
        ),
        const Divider(),
        Text.rich(
          TextSpan(
            children: [
              WidgetSpan(
                alignment: PlaceholderAlignment.middle,
                child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 100),
                    child: const Icon(
                      Icons.lock,
                      size: 16,
                    )),
              ),
              const WidgetSpan(
                  child: SizedBox(
                width: 6,
              )),
              WidgetSpan(
                alignment: PlaceholderAlignment.middle,
                child: Text('Your status updates are ',
                    style: context.texts.bodySmall),
              ),
              WidgetSpan(
                alignment: PlaceholderAlignment.middle,
                child: Text(
                  'end-to-end encrypted',
                  style: context.texts.bodySmall
                      ?.copyWith(color: context.colors.primary),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
