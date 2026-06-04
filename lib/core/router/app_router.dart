import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../features/home/presentation/screens/home_screen.dart';
import '../../features/onboarding/presentation/screens/onboarding_screen_1.dart';
import '../../features/onboarding/presentation/screens/onboarding_screen_2.dart';
import '../../features/settings/presentation/screens/settings_screen.dart';
import '../../features/subscription/presentation/screens/subscription_screen.dart';
import 'router_notifier.dart';

part 'app_router.g.dart';

@Riverpod(keepAlive: true)
GoRouter appRouter(Ref ref) {
  final notifier = ref.watch(routerProvider.notifier);

  return GoRouter(
    initialLocation: '/home',
    debugLogDiagnostics: true,
    refreshListenable: notifier,
    redirect: notifier.redirect,
    routes: [
      GoRoute(
        path: '/onboarding',
        builder: (context, state) => const OnboardingScreen1(),
        routes: [
          GoRoute(
            path: 'page2',
            builder: (context, state) => const OnboardingScreen2(),
          ),
        ],
      ),
      GoRoute(
        path: '/subscription',
        builder: (context, state) => const SubscriptionScreen(),
      ),
      GoRoute(path: '/home', builder: (context, state) => const HomeScreen()),
      GoRoute(
        path: '/settings',
        builder: (context, state) => const SettingsScreen(),
      ),
    ],
  );
}
