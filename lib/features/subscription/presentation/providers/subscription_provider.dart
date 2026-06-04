import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/providers/shared_preferences_provider.dart';
import '../../data/repositories/subscription_repository_impl.dart';
import '../../domain/entities/subscription_status.dart';
import 'subscription_state.dart';

part 'subscription_provider.g.dart';

@Riverpod(keepAlive: true)
class SubscriptionNotifier extends _$SubscriptionNotifier {
  @override
  SubscriptionState build() {
    final prefs = ref.watch(sharedPreferencesProvider);
    final repo = SubscriptionRepositoryImpl(prefs);
    return SubscriptionState(status: repo.getSubscriptionStatus());
  }

  /// Subscribes the user to the given [status].
  ///
  /// TODO: Integrate real payment processing before saving the subscription.
  /// Example:
  ///   final result = await PaymentService.purchase(status);
  ///   if (!result.isSuccess) { ... handle error ... }
  Future<void> subscribe(SubscriptionStatus status) async {
    state = state.copyWith(isLoading: true);

    try {
      // ─── Payment placeholder ──────────────────────────────────────────────
      // TODO: Call your in-app purchase / payment SDK here.
      // e.g. await InAppPurchase.instance.buyNonConsumable(...);
      // ─────────────────────────────────────────────────────────────────────

      final prefs = ref.read(sharedPreferencesProvider);
      final repo = SubscriptionRepositoryImpl(prefs);
      await repo.saveSubscriptionStatus(status);

      state = state.copyWith(status: status, isLoading: false);
    } catch (_) {
      state = state.copyWith(isLoading: false);
      rethrow;
    }
  }
}
