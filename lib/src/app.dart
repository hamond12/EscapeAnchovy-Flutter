import 'package:escape_anchovy/main.dart';
import 'package:escape_anchovy/res/theme/themes.dart';
import 'package:escape_anchovy/src/screen/home/home_screen.dart';
import 'package:escape_anchovy/src/screen/note/note_screen.dart';
import 'package:escape_anchovy/src/screen/splash/splash_screen.dart';
import 'package:escape_anchovy/src/screen/user_name/user_name_screen.dart';
import 'package:flutter/material.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key, required this.settingController});

  final SettingController settingController;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: widget.settingController,
        builder: (snapshot, context) {
          return MaterialApp(
            home: const SplashScreen(),
            theme: Themes.light,
            darkTheme: Themes.dark,
            themeMode: widget.settingController.themeMode,
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
              return HomeScreen(settingController: widget.settingController);
            case UserNameScreen.routeName:
              return const UserNameScreen();
            case NoteScreen.routeName:
              return const NoteScreen();
            default:
              return const Text('Error');
          }
        });
  }
}
