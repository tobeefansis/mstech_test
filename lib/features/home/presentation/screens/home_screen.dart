import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../subscription/presentation/providers/subscription_provider.dart';
import '../widgets/emoji_cell.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  static const _emojis = [
    '😀',
    '😂',
    '🥰',
    '😎',
    '🤩',
    '🎉',
    '🔥',
    '⭐',
    '🌈',
    '🦋',
    '🚀',
    '🎸',
    '🍕',
    '🎨',
    '🏆',
    '🦄',
    '🌺',
    '🎭',
    '💎',
    '🌍',
    '🐶',
    '🐱',
    '🐼',
    '🦊',
    '🐸',
    '🍩',
    '🎂',
    '🍦',
    '🌮',
    '🍜',
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final subscriptionState = ref.watch(subscriptionProvider);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        centerTitle: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_rounded),
            tooltip: 'Настройки',
            onPressed: () => context.push('/settings'),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: Chip(
              avatar: Icon(
                Icons.workspace_premium_rounded,
                size: 16,
                color: theme.colorScheme.primary,
              ),
              label: Text(
                subscriptionState.status.displayName,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.primary,
                ),
              ),
              backgroundColor: theme.colorScheme.primaryContainer,
            ),
          ),
        ],
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
        ),
        itemCount: _emojis.length,
        itemBuilder: (context, index) => EmojiCell(emoji: _emojis[index]),
      ),
    );
  }
}
