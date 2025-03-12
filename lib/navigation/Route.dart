import 'package:go_router/go_router.dart';
import 'package:flutterhelloworld/screens/HomeScreen.dart';
import 'package:flutterhelloworld/screens/ProfileScreen.dart';
import 'package:flutterhelloworld/screens/SettingsScreen.dart';
import 'package:flutterhelloworld/screens/SplashScreen.dart';
import 'package:flutterhelloworld/screens/onboarding/OnboardingScreen1.dart';
import 'package:flutterhelloworld/screens/onboarding/OnboardingScreen2.dart';
import '../main.dart'; // Здесь импортируется ScaffoldWithNavBar

final GoRouter router = GoRouter(
  debugLogDiagnostics: true,
  initialLocation: '/splash',
  routes: [
    GoRoute(
      path: '/splash',
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: '/onboarding1',
      builder: (context, state) => const OnboardingScreen1(),
    ),
    GoRoute(
      path: '/onboarding2',
      builder: (context, state) => const OnboardingScreen2(),
    ),
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return ScaffoldWithNavBar(navigationShell: navigationShell);
      },
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/home',
              builder: (context, state) => const HomeScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/profile',
              builder: (context, state) => const ProfileScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/settings',
              builder: (context, state) => const SettingsScreen(),
            ),
          ],
        ),
      ],
    ),
  ],
);