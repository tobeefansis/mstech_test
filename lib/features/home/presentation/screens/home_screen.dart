import 'package:flutter/material.dart';
import 'package:flutter_glass_morphism/flutter_glass_morphism.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/widgets/glass_scaffold.dart';
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

    return GlassScaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: GlassMorphismAppBar(
          backgroundColor: const Color(0xFF4A2B70),
          title: const Text(
            'Home',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.settings_rounded, color: Colors.white),
              tooltip: 'Настройки',
              onPressed: () => context.push('/settings'),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 12),
              child: _GlassChip(
                icon: Icons.workspace_premium_rounded,
                label: subscriptionState.status.displayName,
              ),
            ),
          ],
        ),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemCount: _emojis.length,
        itemBuilder: (context, index) => EmojiCell(emoji: _emojis[index]),
      ),
    );
  }
}

class _GlassChip extends StatelessWidget {
  const _GlassChip({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return GlassMorphismMaterial(
      blurIntensity: 14,
      opacity: 0.15,
      glassThickness: 1.0,
      borderRadius: BorderRadius.circular(20),
      enableGlassBorder: true,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 14, color: const Color(0xFF9C8FFF)),
            const SizedBox(width: 5),
            Text(
              label,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Color(0xFF9C8FFF),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
