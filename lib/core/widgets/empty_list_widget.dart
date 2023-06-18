import 'package:flutter/material.dart';

class EmptyListWidget extends StatelessWidget {
  const EmptyListWidget({super.key, this.createButton});
  final Widget? createButton;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('Empty'),
          createButton ?? const SizedBox.shrink(),
        ],
      ),
    );
  }
}
