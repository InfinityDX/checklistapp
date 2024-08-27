import 'package:checklistapp/helper/g_color.dart';
import 'package:flutter/material.dart';

class SettingsTile extends StatelessWidget {
  final Widget? child;
  const SettingsTile({this.child, super.key});

  @override
  Widget build(BuildContext context) {
    Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: GColor.scheme.surfaceContainer,
        borderRadius: BorderRadius.circular(16),
      ),
      child: child,
    );
  }
}
