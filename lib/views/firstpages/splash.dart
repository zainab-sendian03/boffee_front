import 'package:flutter/material.dart';
import 'package:userboffee/Core.dart';
import 'package:userboffee/Core/config/options.dart';
import 'package:userboffee/views/firstpages/pageview.dart';
import 'dart:async';
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
    //!maryam has update  here
    if (mounted) super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.bounceOut,
    );
//!maryam has update here
    if (mounted) _animationController.forward();

    Timer(const Duration(seconds: 3), () {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                pref.getString('token') == null ? OnBoarding() : CorePage()),
      );
    });
  }

  @override
  void dispose() {
    //! maryam has update this magic
    if (mounted) _animationController.dispose();
    if (mounted) super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
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
    );
  }
}
