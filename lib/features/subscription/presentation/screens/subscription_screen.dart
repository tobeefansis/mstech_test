import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/subscription_status.dart';
import '../providers/subscription_provider.dart';

class SubscriptionScreen extends ConsumerWidget {
  const SubscriptionScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(subscriptionProvider);
    final theme = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40),
              Text(
                'Choose Your Plan',
                style: theme.textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Unlock all features with a subscription.',
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 48),

              // Monthly card
              _SubscriptionCard(
                title: 'Monthly',
                price: '\$9.99 / month',
                description: 'Billed monthly, cancel anytime.',
                status: SubscriptionStatus.monthly,
                isLoading: state.isLoading,
              ),
              const SizedBox(height: 20),

              // Yearly card (with badge)
              _SubscriptionCard(
                title: 'Yearly',
                price: '\$59.99 / year',
                description: 'That\'s just \$5/month — best value!',
                badge: 'Save 50%',
                status: SubscriptionStatus.yearly,
                isLoading: state.isLoading,
              ),

              const Spacer(),
              Center(
                child: TextButton(
                  onPressed: state.isLoading
                      ? null
                      : () {
                          // TODO: Implement restore purchases
                        },
                  child: const Text('Restore Purchases'),
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
    final theme = Theme.of(context);

    return Stack(
      clipBehavior: Clip.none,
      children: [
        // Card body
        InkWell(
          onTap: isLoading
              ? null
              : () async {
                  await ref
                      .read(subscriptionProvider.notifier)
                      .subscribe(status);
                  // RouterNotifier will automatically redirect to /home
                },
          borderRadius: BorderRadius.circular(16),
          child: Ink(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              gradient: LinearGradient(
                colors: [
                  theme.colorScheme.primaryContainer,
                  theme.colorScheme.surface,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              border: Border.all(color: theme.colorScheme.primary, width: 2),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: theme.textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          price,
                          style: theme.textTheme.bodyLarge?.copyWith(
                            color: theme.colorScheme.primary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          description,
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (isLoading)
                    SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: theme.colorScheme.primary,
                      ),
                    )
                  else
                    Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: theme.colorScheme.primary,
                    ),
                ],
              ),
            ),
          ),
        ),

        // Discount badge
        if (badge != null)
          Positioned(
            top: -14,
            right: 16,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
              decoration: BoxDecoration(
                color: Colors.orange,
                borderRadius: BorderRadius.circular(20),
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
