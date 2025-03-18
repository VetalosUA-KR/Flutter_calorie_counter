import 'package:go_router/go_router.dart';
import 'package:flutterhelloworld/screens/home/HomeScreen.dart';
import 'package:flutterhelloworld/screens/profile/ProfileScreen.dart';
import 'package:flutterhelloworld/screens/SettingsScreen.dart';
import 'package:flutterhelloworld/screens/SplashScreen.dart';
import 'package:flutterhelloworld/screens/onboarding/OnboardingScreen1.dart';
import 'package:flutterhelloworld/screens/onboarding/OnboardingScreen2.dart';
import '../main.dart'; // Здесь импортируется ScaffoldWithNavBar
import 'package:flutterhelloworld/navigation/Destination.dart';

final GoRouter router = GoRouter(
  debugLogDiagnostics: true,
  initialLocation: Desctinations.Splash,
  routes: [
    GoRoute(
      path: Desctinations.Splash,
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: Desctinations.OnboardingUserInfo,
      builder: (context, state) => const OnboardingScreen1(),
    ),
    GoRoute(
      path: Desctinations.OnboardinActivityLevel,
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
              path: Desctinations.Home,
              builder: (context, state) => const HomeScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: Desctinations.Profile,
              builder: (context, state) => const ProfileScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: Desctinations.Settings,
              builder: (context, state) => const SettingsScreen(),
            ),
          ],
        ),
      ],
    ),
  ],
);