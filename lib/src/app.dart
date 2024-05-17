import 'package:escape_anchovy/main.dart';
import 'package:escape_anchovy/res/theme/themes.dart';
import 'package:escape_anchovy/src/screen/exercise/complete_screen.dart';
import 'package:escape_anchovy/src/screen/exercise/exercise_controller.dart';
import 'package:escape_anchovy/src/screen/exercise/exercise_screen1.dart';
import 'package:escape_anchovy/src/screen/exercise/exercise_screen2.dart';
import 'package:escape_anchovy/src/screen/exercise/timer_screen.dart';
import 'package:escape_anchovy/src/screen/home/home_controller.dart';
import 'package:escape_anchovy/src/screen/home/home_screen.dart';
import 'package:escape_anchovy/src/screen/note/note_screen.dart';
import 'package:escape_anchovy/src/screen/splash/splash_screen.dart';
import 'package:escape_anchovy/src/screen/user_name/user_name_screen.dart';
import 'package:flutter/material.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final settingController = SettingController();
  final homeController = HomeController();
  final exerciseController = ExerciseController();

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: settingController,
        builder: (snapshot, context) {
          return MaterialApp(
            home: const SplashScreen(),
            theme: Themes.light,
            darkTheme: Themes.dark,
            themeMode: settingController.themeMode,
            initialRoute: SplashScreen.routeName,
            onGenerateRoute: (RouteSettings routeSettings) {
              return route(routeSettings);
            },
          );
        });
  }

  MaterialPageRoute<void> route(RouteSettings routeSettings) {
    return MaterialPageRoute<void>(
        settings: routeSettings,
        builder: (BuildContext context) {
          switch (routeSettings.name) {
            case SplashScreen.routeName:
              return const SplashScreen();
            case HomeScreen.routeName:
              return HomeScreen(
                  settingController: settingController,
                  homeController: homeController,
                  exerciseController: exerciseController);
            case UserNameScreen.routeName:
              return const UserNameScreen();
            case NoteScreen.routeName:
              return const NoteScreen();
            case ExerciseScreen1.routeName:
              return ExerciseScreen1(
                  exerciseController: exerciseController,
                  homeController: homeController);
            case ExerciseScreen2.routeName:
              return ExerciseScreen2(
                  exerciseController: exerciseController,
                  homeController: homeController);
            case TimerScreen.routeName:
              return TimerScreen(exerciseController: exerciseController);
            case CompleteScreen.routeName:
              return CompleteScreen(
                  exerciseController: exerciseController,
                  homeController: homeController);
            default:
              return const Text('Error');
          }
        });
  }
}
