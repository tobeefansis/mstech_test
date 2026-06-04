import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/constants/app_constants.dart';
import '../../domain/entities/subscription_status.dart';
import '../../domain/repositories/subscription_repository.dart';

class SubscriptionRepositoryImpl implements SubscriptionRepository {
  const SubscriptionRepositoryImpl(this._prefs);

  final SharedPreferences _prefs;

  @override
  SubscriptionStatus getSubscriptionStatus() {
    final raw = _prefs.getString(AppConstants.subscriptionStatusKey);
    if (raw == null) return SubscriptionStatus.none;
    return SubscriptionStatus.values.firstWhere(
      (e) => e.name == raw,
      orElse: () => SubscriptionStatus.none,
    );
  }

  @override
  Future<void> saveSubscriptionStatus(SubscriptionStatus status) =>
      _prefs.setString(AppConstants.subscriptionStatusKey, status.name);
}
