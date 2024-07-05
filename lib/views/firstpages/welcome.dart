import 'package:flutter/material.dart';
import 'package:flutter_application_test/core/constants/images.dart';
import 'package:flutter_application_test/views/auth/login.dart';
import 'package:flutter_application_test/views/auth/signup.dart';

import '../../core/constants/colors.dart';

class welcome extends StatefulWidget {
  const welcome({super.key});

  @override
  State<welcome> createState() => _welcomeState();
}

class _welcomeState extends State<welcome> {
  GlobalKey<FormState> formstats = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            Positioned.fill(
              child: Image.asset(
                bg1,
                fit: BoxFit.fill,
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 400),
                child: Image.asset(
                  logo,
                  scale: 4,
                ),
              ),
            ),
            Center(
              child: Padding(
                  padding: EdgeInsets.only(
                    bottom: 150,
                  ),
                  child: Text("Welcome!",
                      style: TextStyle(
                          letterSpacing: 3,
                          fontSize: 30,
                          color: dark_Brown,
                          fontWeight: FontWeight.w500))),
            ),
            Container(
                child: ListView(children: [
              Form(
                  key: formstats,
                  child: Padding(
                      padding:
                          const EdgeInsets.only(right: 30, left: 30, top: 390),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    padding: const EdgeInsets.only(
                                        top: 15, bottom: 15),
                                    backgroundColor: medium_Brown,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                  ),
                                  onPressed: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                          builder: (context) => login()),
                                    );
                                  },
                                  child: Text(
                                    "Login",
                                    style:
                                        TextStyle(fontSize: 23, color: white),
                                  )),
                            ),
                            const SizedBox(
                              height: 35,
                            ),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                  style: ButtonStyle(
                                    shape: MaterialStateProperty.all(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                    ),
                                    padding: MaterialStateProperty.all(
                                        const EdgeInsets.only(
                                            top: 15, bottom: 15)),
                                    backgroundColor:
                                        MaterialStateProperty.all(no_color),
                                    elevation: MaterialStateProperty.all(0),
                                    side: MaterialStateProperty.all(BorderSide(
                                        color: medium_Brown, width: 2.0)),
                                  ),
                                  onPressed: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                          builder: (context) => signup()),
                                    );
                                  },
                                  child: Text(
                                    "Create a new account",
                                    style: TextStyle(
                                        fontSize: 23, color: medium_Brown),
                                  )),
                            ),
                          ])))
            ])),
          ],
        ));
  }
}
