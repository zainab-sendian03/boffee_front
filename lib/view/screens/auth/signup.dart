import 'package:flutter/material.dart';
import 'package:flutter_application_test/core/constants/Customtextformfiled.dart';
import 'package:flutter_application_test/core/constants/linksapi.dart';
import 'package:flutter_application_test/core/components/crud.dart';
import 'package:flutter_application_test/view/screens/auth/login.dart';

import '../../../core/constants/colors.dart';

class signup extends StatefulWidget {
  const signup({super.key});

  @override
  State<signup> createState() => _signupState();
}

class _signupState extends State<signup> {
  final username = TextEditingController();
  final age = TextEditingController();
  final password = TextEditingController();
  final email = TextEditingController();
  final confirmpass = TextEditingController();
  GlobalKey<FormState> formstats = GlobalKey();

  bool male = false;
  bool female = true;
  final Crud _crud = Crud();
  signUp() async {
    if (formstats.currentState!.validate()) {
      int genderId = male ? 1 : 2;
      var response = await _crud.postrequest(linksignup, {
        "user_name": username.text,
        "email": email.text,
        "password": password.text,
        "password confirmation": confirmpass.text,
        "age": age.text,
        "gendre_id": genderId.toString(),
      });
      if (response is Map && response['success'] == true) {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => login()),
        );
      } else {
        print("signup fail");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            Positioned.fill(
              child: Image.asset(
                "asset/images/bg1.png",
                fit: BoxFit.cover,
              ),
            ),
            const Padding(
                padding: EdgeInsets.only(top: 80, left: 20),
                child: Text("Welcome to boffee",
                    style: TextStyle(
                        fontSize: 30,
                        color: Color(0xFF94745B),
                        fontWeight: FontWeight.bold))),
            const Padding(
                padding: EdgeInsets.only(top: 120, left: 70),
                child: Text("let's create an account",
                    style: TextStyle(
                        fontSize: 25,
                        color: Color(0xFF94745B),
                        fontWeight: FontWeight.w400))),
            Container(
                child: ListView(children: [
              Form(
                  key: formstats,
                  child: Padding(
                      padding:
                          const EdgeInsets.only(right: 50, left: 50, top: 185),
                      child: Column(children: [
                        Row(children: [
                          Expanded(
                              child: CustomTextFormField(
                            visPassword: false,
                            controller: username,
                            min: 3,
                            max: 8,
                            hintText: "User name",
                          )),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                              child: CustomTextFormField(
                            visPassword: false,
                            controller: age,
                            min: 1,
                            max: 2,
                            hintText: "Age",
                          )),
                        ]),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Gender",
                              style: TextStyle(
                                  color: Color(0xFF5D3F2E),
                                  fontSize: 19,
                                  fontWeight: FontWeight.w400),
                            ),
                            const SizedBox(
                              width: 27,
                            ),
                            Checkbox(
                                value: male,
                                side:
                                    const BorderSide(color: Color(0xFF94745B)),
                                shape: const CircleBorder(),
                                activeColor: Colorss.buttomColor,
                                onChanged: (value) {
                                  setState(() {
                                    if (value == true) {
                                      male = true;
                                      female = false;
                                    }
                                  });
                                }),
                            const Text(
                              "Male",
                              style: TextStyle(
                                  fontSize: 17, color: Color(0xFF5D3F2E)),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Checkbox(
                                shape: const CircleBorder(),
                                side:
                                    const BorderSide(color: Color(0xFF94745B)),
                                activeColor: Colorss.buttomColor,
                                value: female,
                                onChanged: (value) {
                                  setState(() {
                                    if (value == true) {
                                      female = true;
                                      male = false;
                                    }
                                  });
                                }),
                            const Text(
                              "Female",
                              style: TextStyle(
                                  fontSize: 17, color: Color(0xFF5D3F2E)),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        CustomTextFormField(
                          visPassword: false,
                          controller: email,
                          min: 12,
                          max: 20,
                          hintText: "E-mail",
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        CustomTextFormField(
                          showVisPasswordToggle: true,
                          controller: password,
                          min: 8,
                          max: 20,
                          hintText: "Password",
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        CustomTextFormField(
                          showVisPasswordToggle: true,
                          controller: confirmpass,
                          min: 8,
                          max: 20,
                          hintText: "Confirm Password",
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            await signUp();
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colorss.buttomColor,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25)),
                              padding: const EdgeInsets.only(
                                  left: 40, right: 40, top: 15, bottom: 15)),
                          child: const Text(
                            "Sign Up",
                            style: TextStyle(fontSize: 15, color: Colors.white),
                          ),
                        ),
                        Padding(
                            padding: const EdgeInsets.only(top: 25, left: 55),
                            child: Row(
                              children: [
                                const Text("Already a member?",
                                    style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w300,
                                      color: Color(0xFFA5A5A5),
                                    )),
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                          builder: (context) => login()),
                                    );
                                  },
                                  child: const Text(
                                    "Login",
                                    style: TextStyle(
                                        fontSize: 18, color: Color(0xFF5D3F2E)),
                                  ),
                                ),
                              ],
                            ))
                      ])))
            ])),
          ],
        ));
  }
}
