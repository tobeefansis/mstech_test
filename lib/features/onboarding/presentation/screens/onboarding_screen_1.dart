import 'package:flutter/material.dart';
import 'package:flutter_glass_morphism/flutter_glass_morphism.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';

import '../../../../../core/widgets/glass_scaffold.dart';

class OnboardingScreen1 extends ConsumerWidget {
  const OnboardingScreen1({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GlassScaffold(
      body: Column(
        children: [
          // ── Lottie animation ─────────────────────────────────────────────
          Expanded(
            flex: 5,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(48, 80, 48, 24),
              child: Lottie.asset(
                'assets/lottie/onboarding_1.json',
                fit: BoxFit.contain,
              ),
            ),
          ),

          // ── Glass bottom card ─────────────────────────────────────────────
          GlassMorphismMaterial(
            blurIntensity: 22,
            opacity: 0.12,
            glassThickness: 1.5,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(36)),
            enableGlassBorder: true,
            child: SafeArea(
              top: false,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(28, 36, 28, 28),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'Welcome! 👋',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Discover amazing features designed just for you.',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white.withValues(alpha: 0.68),
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 32),
                    SizedBox(
                      width: double.infinity,
                      height: 52,
                      child: GlassMorphismButton(
                        onPressed: () => context.go('/onboarding/page2'),
                        style: GlassMorphismButtonStyle(
                          backgroundColor: const Color(0xFF8B6FF9),
                          borderRadius: BorderRadius.circular(16),
                          blurIntensity: 10,
                        ),
                        child: const Text(
                          'Next',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
