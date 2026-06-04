import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/subscription_status.dart';

part 'subscription_state.freezed.dart';

@freezed
sealed class SubscriptionState with _$SubscriptionState {
  const factory SubscriptionState({
    @Default(SubscriptionStatus.none) SubscriptionStatus status,
    @Default(false) bool isLoading,
  }) = _SubscriptionState;
}
