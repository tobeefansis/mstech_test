import 'package:flutter/material.dart';
import 'package:flutter_glass_morphism/flutter_glass_morphism.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/widgets/glass_scaffold.dart';
import '../../domain/entities/subscription_status.dart';
import '../providers/subscription_provider.dart';

class SubscriptionScreen extends ConsumerWidget {
  const SubscriptionScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(subscriptionProvider);

    return GlassScaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40),

              // ── Header ─────────────────────────────────────────────────
              const Text(
                'Choose Your Plan',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Unlock all features with a subscription.',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white.withValues(alpha: 0.65),
                ),
              ),
              const SizedBox(height: 48),

              // ── Monthly card ────────────────────────────────────────────
              _SubscriptionCard(
                title: 'Monthly',
                price: '\$9.99 / month',
                description: 'Billed monthly, cancel anytime.',
                status: SubscriptionStatus.monthly,
                isLoading: state.isLoading,
              ),
              const SizedBox(height: 28),

              // ── Yearly card (with badge) ────────────────────────────────
              _SubscriptionCard(
                title: 'Yearly',
                price: '\$59.99 / year',
                description: "That's just \$5/month — best value!",
                badge: 'Save 50%',
                status: SubscriptionStatus.yearly,
                isLoading: state.isLoading,
              ),

              const Spacer(),

              // ── Restore purchases ───────────────────────────────────────
              Center(
                child: TextButton(
                  onPressed: state.isLoading
                      ? null
                      : () {
                          // TODO: Implement restore purchases
                        },
                  child: Text(
                    'Restore Purchases',
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.55),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}

// ─── Private card widget ──────────────────────────────────────────────────────

class _SubscriptionCard extends ConsumerWidget {
  const _SubscriptionCard({
    required this.title,
    required this.price,
    required this.description,
    required this.status,
    required this.isLoading,
    this.badge,
  });

  final String title;
  final String price;
  final String description;
  final SubscriptionStatus status;
  final bool isLoading;
  final String? badge;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        // ── Glass card body ───────────────────────────────────────────────
        GestureDetector(
          onTap: isLoading
              ? null
              : () async {
                  await ref
                      .read(subscriptionProvider.notifier)
                      .subscribe(status);
                  // RouterNotifier automatically redirects to /home
                },
          child: GlassMorphismMaterial(
            blurIntensity: 20,
            opacity: 0.12,
            glassThickness: 1.5,
            borderRadius: BorderRadius.circular(20),
            enableGlassBorder: true,
            child: Padding(
              padding: const EdgeInsets.all(22),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          price,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF9C8FFF),
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          description,
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.white.withValues(alpha: 0.55),
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (isLoading)
                    const SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Color(0xFF9C8FFF),
                      ),
                    )
                  else
                    const Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: Color(0xFF9C8FFF),
                      size: 18,
                    ),
                ],
              ),
            ),
          ),
        ),

        // ── Discount badge ────────────────────────────────────────────────
        if (badge != null)
          Positioned(
            top: -14,
            right: 16,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFFFF6B35), Color(0xFFFF1744)],
                ),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFFFF1744).withValues(alpha: 0.4),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Text(
                badge!,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
