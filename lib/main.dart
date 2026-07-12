import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/controllers/app_controller.dart';
import 'core/theme/app_theme.dart';
import 'features/dashboard/controllers/library_controller.dart';
import 'features/chat/controllers/camera_controller.dart';
import 'features/auth/screens/welcome_screen.dart';
import 'features/main/screens/main_navigation_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AppController()),
        ChangeNotifierProvider(create: (_) => LibraryController()),
        ChangeNotifierProvider(create: (_) => CameraController()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Clawdy',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const SplashDecider(),
    );
  }
}

class SplashDecider extends StatefulWidget {
  const SplashDecider({super.key});

  @override
  State<SplashDecider> createState() => _SplashDeciderState();
}

class _SplashDeciderState extends State<SplashDecider> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _init();
  }

  Future<void> _init() async {
    final controller = context.read<AppController>();
    await controller.checkSession();
    if (mounted) {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final isLoggedIn = context.watch<AppController>().isLoggedIn;
    return isLoggedIn ? const MainNavigationScreen() : const WelcomeScreen();
  }
}