import 'package:flutter/material.dart';
import 'package:mobile/app_theme.dart';
import 'package:mobile/di/injection.dart';
import 'package:mobile/routing/app_routing.dart';
import 'package:mobile/screens/login/login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'PostGet',
      theme: baseTheme,
      routerConfig: router,
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Login());
  }
}
