import 'package:flutterhelloworld/model/meal.dart';
import 'package:flutterhelloworld/screens/home/searchMeal/search_meal_screen.dart';
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
    GoRoute(
      path: Desctinations.Meal,
      builder: (context, state) => MealScreen(
        onAddMeal: state.extra as Function(Meal), // Передаём callback через extra
        mealType: state.uri.queryParameters['mealType'] != null
            ? MealType.values.firstWhere(
                (e) => e.toString() == 'MealType.${state.uri.queryParameters['mealType']}')
            : MealType.breakfast, // Передаём mealType через query-параметр
      ),
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