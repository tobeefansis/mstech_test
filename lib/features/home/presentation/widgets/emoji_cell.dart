import 'package:flutter/material.dart';

class EmojiCell extends StatelessWidget {
  const EmojiCell({super.key, required this.emoji});

  final String emoji;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Center(child: Text(emoji, style: const TextStyle(fontSize: 34))),
    );
  }
}
