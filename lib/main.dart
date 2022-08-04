import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:zartek_test/app_services/auth_service.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          tabBarTheme: const TabBarTheme(labelColor: Colors.black),
          primarySwatch: Colors.blue,
        ),
        home: AuthService().handleAuth());
  }
}
