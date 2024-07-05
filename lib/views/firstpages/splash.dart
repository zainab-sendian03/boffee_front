import 'package:flutter/material.dart';
import 'package:flutter_application_test/Core.dart';
import 'package:flutter_application_test/core/config/options.dart';
import 'dart:async';
import 'package:flutter_application_test/views/firstpages/pageview.dart';
import '../../core/constants/colors.dart';
import '../../core/constants/images.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.bounceOut,
    );

    _animationController.forward();

    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) =>
                pref.getString('id') == null ? OnBoarding() : CorePage()),
      );
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              bg,
              fit: BoxFit.fill,
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ScaleTransition(
                    scale: _animation, child: Image.asset(logo, width: 100)),
                FadeTransition(
                  opacity: _animation,
                  child: Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: Text(
                      "Boffee",
                      style: TextStyle(
                        letterSpacing: 8,
                        fontSize: 30,
                        fontFamily: "Quicksand",
                        color: dark_Brown,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
