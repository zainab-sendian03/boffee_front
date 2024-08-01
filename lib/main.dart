import 'package:flutter/material.dart';
import 'package:flutter_application_test/core/config/options.dart';
import 'package:flutter_application_test/core/provider/Theme_provider.dart';
import 'package:flutter_application_test/views/auth/login.dart';
import 'package:provider/provider.dart';
import 'core/provider/CoinProvider.dart';

String token = "3|NTO82H0HqEo4yqVYKOJHaAj0xMX7K7obtUFs7hte";

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Setup();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => CoinProvider(),
        ),
        ChangeNotifierProvider(
            create: (context) => ThemeProvider()..initTheme()),
      ],
      child: Builder(builder: (context) {
        return MaterialApp(
          //theme: context.watch<ThemeProvider>().themedata,
          debugShowCheckedModeBanner: false,
          home: login(),
        );
      }),
    );
  }
}
