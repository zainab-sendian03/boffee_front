import 'package:flutter/material.dart';
import 'package:flutter_application_test/core/constants/Customtextformfiled.dart';
import 'package:flutter_application_test/core/constants/alerts.dart';
import 'package:flutter_application_test/core/constants/linksapi.dart';
import 'package:flutter_application_test/core/components/crud.dart';
import 'package:flutter_application_test/main.dart';
import 'package:flutter_application_test/view/home.dart';
import 'package:flutter_application_test/view/screens/auth/signup.dart';
import '../../../core/constants/colors.dart';

class login extends StatefulWidget {
  const login({super.key});

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
  final user_name = TextEditingController();
  final password = TextEditingController();
  bool passwordVisible = true;

  final Crud _crud = Crud();
  GlobalKey<FormState> formstats = GlobalKey();
  late final String? Function(String?) valid;

  logIn() async {
    if (formstats.currentState!.validate()) {
      try {
        var response = await _crud.postrequest(linklogin, {
          "user_name": user_name.text,
          "password": password.text,
        });
        if (response is Map && response['success'] == true) {
          pref.setString("id", response['data']['id'].toString());
          pref.setString("user_name", response['data']['user_name']);
          pref.setString("password", response['data']['password']);
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => home()),
          );
        } else {
          wrongLogin(formstats.currentContext!);
        }
      } catch (e) {
        print("ERROR $e");
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
                padding: EdgeInsets.only(top: 100, left: 20),
                child: Text("Welcome Back!",
                    style: TextStyle(
                        fontSize: 30,
                        color: Color(0xFF94745B),
                        fontWeight: FontWeight.bold))),
            const Padding(
                padding: EdgeInsets.only(top: 150, left: 70),
                child: Text("Login to continue",
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
                          const EdgeInsets.only(right: 50, left: 50, top: 320),
                      child: Column(children: [
                        CustomTextFormField(
                          hintText: "user_name",
                          controller: user_name,
                          min: 3,
                          max: 10,
                          visPassword: false,
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        CustomTextFormField(
                          showVisPasswordToggle: true,
                          hintText: "Password",
                          controller: password,
                          min: 8,
                          max: 20,
                        ),
                        TextButton(
                            onPressed: () {},
                            child: const Padding(
                              padding: EdgeInsets.only(left: 157, bottom: 10),
                              child: Text(
                                "Forget password?",
                                style: TextStyle(
                                    fontSize: 15, color: Color(0xFF5D3F2E)),
                              ),
                            )),
                        const SizedBox(
                          height: 60,
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            await logIn();
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colorss.buttomColor,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25)),
                              padding: const EdgeInsets.only(
                                  left: 40, right: 40, top: 15, bottom: 15)),
                          child: const Text(
                            "Login",
                            style: TextStyle(fontSize: 15, color: Colors.white),
                          ),
                        ),
                        Padding(
                            padding: const EdgeInsets.only(top: 45, left: 30),
                            child: Row(
                              children: [
                                const Text("Don’t have an account?",
                                    style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w300,
                                      color: Color(0xFFA5A5A5),
                                    )),
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                          builder: (context) => signup()),
                                    );
                                  },
                                  child: const Text(
                                    "SignUp",
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
