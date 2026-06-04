import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/constants/app_constants.dart';
import '../../domain/repositories/onboarding_repository.dart';

class OnboardingRepositoryImpl implements OnboardingRepository {
  const OnboardingRepositoryImpl(this._prefs);

  final SharedPreferences _prefs;

  @override
  bool isOnboardingCompleted() =>
      _prefs.getBool(AppConstants.onboardingCompletedKey) ?? false;

  @override
  Future<void> completeOnboarding() =>
      _prefs.setBool(AppConstants.onboardingCompletedKey, true);
}
