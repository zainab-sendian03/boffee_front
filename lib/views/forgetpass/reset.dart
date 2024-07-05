import 'package:flutter/material.dart';
import 'package:flutter_application_test/core/constants/components.dart';
import 'package:flutter_application_test/views/auth/login.dart';

import '../../core/constants/colors.dart';
import '../../core/constants/images.dart';

class resetpass extends StatefulWidget {
  const resetpass({super.key});

  @override
  State<resetpass> createState() => _resetpassState();
}

class _resetpassState extends State<resetpass> {
  GlobalKey<FormState> formstats = GlobalKey();
  final pass = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              bg1,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
              padding: EdgeInsets.only(
                bottom: 400,
              ),
              child: Center(
                child: Text("Reset Your Password",
                    style: TextStyle(
                        fontSize: 35,
                        color: medium_Brown,
                        fontWeight: FontWeight.bold)),
              )),
          Padding(
              padding: EdgeInsets.only(
                bottom: 230,
              ),
              child: Center(
                child: Text(
                    "Your new password must be\ndifferent from previously used\n password",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 23,
                        color: dark_Brown,
                        fontWeight: FontWeight.w400)),
              )),
          Container(
              child: ListView(children: [
            Form(
                key: formstats,
                child: Padding(
                    padding:
                        const EdgeInsets.only(right: 35, left: 35, top: 390),
                    child: Column(children: [
                      CustomTextFormField(
                        hintText: "Password",
                        controller: pass,
                        min: 3,
                        max: 10,
                        visPassword: false,
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => login()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: medium_Brown,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25)),
                            padding: const EdgeInsets.only(
                                left: 40, right: 40, top: 15, bottom: 15)),
                        child: Text(
                          "Done",
                          style: TextStyle(fontSize: 15, color: white),
                        ),
                      ),
                    ])))
          ])),
        ],
      ),
    );
  }
}
