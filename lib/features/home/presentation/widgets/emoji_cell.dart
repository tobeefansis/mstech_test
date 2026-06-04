import 'package:flutter/material.dart';
import 'package:flutter_glass_morphism/flutter_glass_morphism.dart';

class EmojiCell extends StatelessWidget {
  const EmojiCell({super.key, required this.emoji});

  final String emoji;

  @override
  Widget build(BuildContext context) {
    return GlassMorphismMaterial(
      blurIntensity: 16,
      opacity: 0.1,
      glassThickness: 1.0,
      borderRadius: BorderRadius.circular(16),
      enableGlassBorder: true,
      child: Center(child: Text(emoji, style: const TextStyle(fontSize: 30))),
    );
  }
}
