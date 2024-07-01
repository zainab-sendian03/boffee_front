import 'package:flutter/material.dart';

import 'package:userboffee/Core/constants/components.dart';
import 'package:userboffee/core/constants/images.dart';
import 'package:userboffee/views/forgetpass/getcode.dart';

import '../../core/constants/colors.dart';

class mailadd extends StatefulWidget {
  const mailadd({super.key});

  @override
  State<mailadd> createState() => _mailaddState();
}

class _mailaddState extends State<mailadd> {
  GlobalKey<FormState> formstats = GlobalKey();
  final email = TextEditingController();

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
                child: Text("Mail Address here",
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
                    "Enter the email address associated\n with your account",
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
                        hintText: "Email",
                        controller: email,
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
                            MaterialPageRoute(builder: (context) => getCode()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: medium_Brown,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25)),
                            padding: const EdgeInsets.only(
                                left: 40, right: 40, top: 15, bottom: 15)),
                        child: Text(
                          "Send",
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