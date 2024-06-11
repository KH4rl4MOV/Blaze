import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screen/home_screen.dart';
import 'screen/welcome_screen.dart';
import 'theme_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Проверяем, сохранены ли данные пользователя
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool userHasData = prefs.containsKey('name') && prefs.getString('name')!.isNotEmpty;

  runApp(MyApp(initialScreen: userHasData ? HomeScreen() : WelcomeScreen()));
}

class MyApp extends StatelessWidget {
  final Widget initialScreen;

  MyApp({required this.initialScreen});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
            title: 'Blaze App',
            theme: ThemeData(
              primarySwatch: Colors.blue,
              visualDensity: VisualDensity.adaptivePlatformDensity,
            ),
            home: initialScreen,
            builder: (context, child) {
              return Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(themeProvider.getBackgroundImage()),
                    fit: BoxFit.cover,
                  ),
                ),
                child: child,
              );
            },
          );
        },
      ),
    );
  }
}
