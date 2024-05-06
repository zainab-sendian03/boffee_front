import 'package:flutter/material.dart';
import 'package:flutter_application_test/app/home.dart';
import 'package:flutter_application_test/auth/login.dart';
import 'package:flutter_application_test/auth/signup.dart';
import 'package:flutter_application_test/welcomepages/pageview.dart';
import 'package:flutter_application_test/welcomepages/splash.dart';
import 'package:flutter_application_test/welcomepages/welcome.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: "signup",
      routes: {
        "login": (context) => const login(),
        "signup": (context) => const signup(),
        "welcome": (context) => const welcome(),
        "pview": (context) => const pageview(),
        "home": (context) => const home(),
        "splash": (context) => const CustomSplashScreen(),
      },
    );
  }
}
