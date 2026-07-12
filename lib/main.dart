import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/controllers/app_controller.dart';
import 'core/theme/app_theme.dart';
import 'features/auth/controllers/auth_controller.dart';
import 'features/auth/screens/welcome_screen.dart';
import 'features/main/screens/main_navigation_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AppController()),
        ProxyProvider<AppController, AuthController>(
          update: (_, appController, _) => AuthController(appController),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final isLoggedIn = context.watch<AppController>().isLoggedIn;

    return MaterialApp(
      title: 'Clawdy',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: isLoggedIn ? const MainNavigationScreen() : const WelcomeScreen(),
    );
  }
}
