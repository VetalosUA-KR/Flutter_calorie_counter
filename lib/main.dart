import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'navigation/Route.dart';
import 'theme/app_colors.dart';
import 'theme/theme_bloc.dart';
import 'package:flutterhelloworld/user_profile.dart';
import 'repository/user_profile_repository.dart';
import 'block/onboarding_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(UserProfileAdapter());
  final box = await Hive.openBox<UserProfile>('userProfileBox');
  final repository = UserProfileRepository(box);

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<ThemeBloc>(
          create: (context) => ThemeBloc(),
        ),
        BlocProvider<OnboardingBloc>(
          create: (context) => OnboardingBloc(repository: repository)..add(LoadUserProfile()),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class ScaffoldWithNavBar extends StatefulWidget {
  final StatefulNavigationShell navigationShell;

  const ScaffoldWithNavBar({super.key, required this.navigationShell});

  @override
  State<ScaffoldWithNavBar> createState() => _ScaffoldWithNavBarState();
}

class _ScaffoldWithNavBarState extends State<ScaffoldWithNavBar> {
  DateTime? _lastBackPressed;

  Future<bool> _onWillPop() async {
    final now = DateTime.now();
    if (_lastBackPressed == null ||
        now.difference(_lastBackPressed!) > const Duration(seconds: 2)) {
      _lastBackPressed = now;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Нажмите ещё раз назад, чтобы выйти из приложения'),
          duration: const Duration(seconds: 2),
          backgroundColor: AppColors.getSnackBar(context),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return false;
    }
    return true;
  }

  void _goBranch(int index) {
    widget.navigationShell.goBranch(index);
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        if (!didPop) {
          final shouldPop = await _onWillPop();
          if (shouldPop) {
            SystemNavigator.pop();
          }
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Hi, Vitalii',
            style: TextStyle(color: AppColors.getText(context)),
          ),
          backgroundColor: AppColors.getAppBar(context),
        ),
        body: widget.navigationShell,
        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: AppColors.getPrimary(context),
          unselectedItemColor: AppColors.getHint(context),
          selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w400),
          currentIndex: widget.navigationShell.currentIndex,
          onTap: _goBranch,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
            BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
          ],
        ),
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        return MaterialApp.router(
          routerConfig: router,
          theme: ThemeData(
            brightness: Brightness.light,
            primaryColor: AppColors.lightPrimary,
            scaffoldBackgroundColor: AppColors.lightBackground,
            appBarTheme: const AppBarTheme(
              elevation: 0,
            ),
            textTheme: const TextTheme(
              bodyMedium: TextStyle(color: AppColors.lightText),
            ),
            snackBarTheme: const SnackBarThemeData(
              behavior: SnackBarBehavior.floating,
            ),
          ),
          darkTheme: ThemeData(
            brightness: Brightness.dark,
            primaryColor: AppColors.darkPrimary,
            scaffoldBackgroundColor: AppColors.darkBackground,
            appBarTheme: const AppBarTheme(
              elevation: 0,
            ),
            textTheme: const TextTheme(
              bodyMedium: TextStyle(color: AppColors.darkText),
            ),
            snackBarTheme: const SnackBarThemeData(
              behavior: SnackBarBehavior.floating,
            ),
          ),
          themeMode: state.themeMode,
        );
      },
    );
  }
}