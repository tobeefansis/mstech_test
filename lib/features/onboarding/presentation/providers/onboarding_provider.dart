import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/providers/shared_preferences_provider.dart';
import '../../data/repositories/onboarding_repository_impl.dart';
import 'onboarding_state.dart';

part 'onboarding_provider.g.dart';

@Riverpod(keepAlive: true)
class OnboardingNotifier extends _$OnboardingNotifier {
  @override
  OnboardingState build() {
    final prefs = ref.watch(sharedPreferencesProvider);
    final repo = OnboardingRepositoryImpl(prefs);
    return OnboardingState(isCompleted: repo.isOnboardingCompleted());
  }

  Future<void> completeOnboarding() async {
    final prefs = ref.read(sharedPreferencesProvider);
    final repo = OnboardingRepositoryImpl(prefs);
    await repo.completeOnboarding();
    state = state.copyWith(isCompleted: true);
  }
}
