
import 'package:flutter/material.dart';
import 'package:userboffee/Core/constants/components.dart';
import 'package:userboffee/Core/constants/linksapi.dart';
import 'package:userboffee/Core/service/real/crud.dart';
import 'package:userboffee/core/constants/images.dart';
import 'package:userboffee/views/auth/login.dart';
import '../../core/constants/colors.dart';

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
          MaterialPageRoute(builder: (context) => const login()),
        );
      } else if (confirmpass != password) {
        alert(formstats.currentContext!,
            "Password does not match. Please re-type again.", "Wrong", "Close");
      } else {
        print("fail signup");
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
                bg1,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
                padding: const EdgeInsets.only(top: 80, left: 20),
                child: Text("Welcome to boffee",
                    style: TextStyle(
                        fontSize: 30,
                        color: medium_Brown,
                        fontWeight: FontWeight.bold))),
            Padding(
                padding: const EdgeInsets.only(top: 120, left: 70),
                child: Text("let's create an account",
                    style: TextStyle(
                        fontSize: 25,
                        color: medium_Brown,
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
                            Text(
                              "Gender",


style: TextStyle(
                                  color: dark_Brown,
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
                                activeColor: medium_Brown,
                                onChanged: (value) {
                                  setState(() {
                                    if (value == true) {
                                      male = true;
                                      female = false;
                                    }
                                  });
                                }),
                            Text(
                              "Male",
                              style: TextStyle(fontSize: 17, color: dark_Brown),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Checkbox(
                                shape: const CircleBorder(),
                                side: BorderSide(color: medium_Brown),
                                activeColor: medium_Brown,
                                value: female,
                                onChanged: (value) {
                                  setState(() {
                                    if (value == true) {
                                      female = true;
                                      male = false;
                                    }
                                  });
                                }),
                            Text(
                              "Female",
                              style: TextStyle(fontSize: 17, color: dark_Brown),
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
                              backgroundColor: medium_Brown,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25)),
                              padding: const EdgeInsets.only(
                                  left: 40, right: 40, top: 15, bottom: 15)),

child: Text(
                            "Sign Up",
                            style: TextStyle(fontSize: 15, color: white),
                          ),
                        ),
                        Padding(
                            padding: const EdgeInsets.only(top: 25, left: 55),
                            child: Row(
                              children: [
                                Text("Already a member?",
                                    style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w300,
                                      color: hint_color,
                                    )),
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                          builder: (context) => const login()),
                                    );
                                  },
                                  child: Text(
                                    "Login",
                                    style: TextStyle(
                                        fontSize: 18, color: dark_Brown),
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