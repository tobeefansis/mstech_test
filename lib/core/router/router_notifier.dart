import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../features/onboarding/presentation/providers/onboarding_provider.dart';
import '../../features/onboarding/presentation/providers/onboarding_state.dart';
import '../../features/subscription/domain/entities/subscription_status.dart';
import '../../features/subscription/presentation/providers/subscription_provider.dart';
import '../../features/subscription/presentation/providers/subscription_state.dart';

part 'router_notifier.g.dart';

/// Listens to auth-like state changes and notifies [GoRouter] to re-evaluate
/// redirect guards. Implements [Listenable] so it can be passed directly as
/// [GoRouter.refreshListenable].
@Riverpod(keepAlive: true)
class RouterNotifier extends _$RouterNotifier implements Listenable {
  VoidCallback? _routerListener;

  @override
  void build() {
    ref.listen<OnboardingState>(
      onboardingProvider,
      (_, __) => _routerListener?.call(),
    );
    ref.listen<SubscriptionState>(
      subscriptionProvider,
      (_, __) => _routerListener?.call(),
    );
  }

  /// Called by [GoRouter] on every navigation event.
  String? redirect(BuildContext context, GoRouterState routerState) {
    final isOnboardingDone = ref.read(onboardingProvider).isCompleted;
    final subscriptionStatus = ref.read(subscriptionProvider).status;

    final location = routerState.matchedLocation;

    // --- Onboarding guard ---
    if (!isOnboardingDone) {
      if (location == '/onboarding' || location == '/onboarding/page2') {
        return null;
      }
      return '/onboarding';
    }

    // --- Subscription guard ---
    if (subscriptionStatus == SubscriptionStatus.none) {
      if (location == '/subscription') return null;
      return '/subscription';
    }

    // --- Redirect away from completed flows ---
    if (location == '/onboarding' ||
        location == '/onboarding/page2' ||
        location == '/subscription') {
      return '/home';
    }

    return null;
  }

  // ── Listenable ──────────────────────────────────────────────────────────────

  @override
  void addListener(VoidCallback listener) => _routerListener = listener;

  @override
  void removeListener(VoidCallback listener) => _routerListener = null;
}
