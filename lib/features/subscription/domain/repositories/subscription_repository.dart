import '../entities/subscription_status.dart';

abstract class SubscriptionRepository {
  SubscriptionStatus getSubscriptionStatus();
  Future<void> saveSubscriptionStatus(SubscriptionStatus status);
}
