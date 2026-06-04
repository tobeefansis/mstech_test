enum SubscriptionStatus {
  none,
  monthly,
  yearly;

  String get displayName => switch (this) {
    SubscriptionStatus.none => 'No Subscription',
    SubscriptionStatus.monthly => 'Monthly',
    SubscriptionStatus.yearly => 'Yearly',
  };
}
