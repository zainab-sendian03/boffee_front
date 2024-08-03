import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:userboffee/Core.dart';
import 'package:userboffee/Core/config/options.dart';
import 'package:userboffee/Core/constants/components.dart';
import 'package:userboffee/Core/constants/linksapi.dart';
import 'package:userboffee/Core/service/real/crud.dart';
import 'package:userboffee/core/constants/images.dart';
import 'package:userboffee/views/auth/signup.dart';
import 'package:userboffee/views/forgetpass/mailadd.dart';
import '../../core/constants/colors.dart';

class login extends StatefulWidget {
  const login({super.key});

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
  final user_name = TextEditingController();
  final password = TextEditingController();
  bool passwordVisible = true;
  bool isLoading = false;

  final Crud _crud = Crud();
  GlobalKey<FormState> formstats = GlobalKey();
  late final String? Function(String?) valid;
// String accesToken = getit.get<SharedPreferences>().getString('token') ?? '';
  logIn() async {
    setState(() {
      isLoading = true;
    });
    if (formstats.currentState!.validate()) {
      try {
        var response = await _crud.postrequest(
          linklogin,
          {
            "user_name": user_name.text,
            "password": password.text,
          },
          headers: {
            "Accept": "application/json",
            "Content-Type": "application/json",
          },
        );

        setState(() {
          isLoading = false;
        });
        print("Response status: ${response['statusCode']}");
        print("Response body: ${response['body']}");

        if (response is Map && response['success'] == true) {
          pref.setString("id", response['data']['id'].toString());
          pref.setString("user_name", response['data']['user_name']);
          pref.setString("password", response['data']['password']);
          pref.setString("token", response['data']['token']);

          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const CorePage()),
          );
        } else {
          alert(
              formstats.currentContext!,
              "Your password or User name is incorrect or the account does not exist\nPlease try again!",
              "Wrong",
              "Close");
        }
      } catch (e) {
        print("ERROR $e");
      }
    } else {
      setState(() {
        isLoading = false;
      });
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
                padding: const EdgeInsets.only(top: 100, left: 20),
                child: Text("Welcome Back!".tr(),
                    style: TextStyle(
                        fontSize: 30,
                        color: medium_Brown,
                        fontWeight: FontWeight.bold))),
            Padding(
                padding: EdgeInsets.only(top: 150, left: 70),
                child: Text("Login to continue".tr(),
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
                          const EdgeInsets.only(right: 50, left: 50, top: 320),
                      child: Column(children: [
                        CustomTextFormField(
                          hintText: "user_name".tr(),
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
                          hintText: "Password".tr(),
                          controller: password,
                          min: 8,
                          max: 20,
                        ),
                        TextButton(
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (context) => const mailadd()),
                              );
                            },
                            child: Padding(
                              padding: EdgeInsets.only(left: 157, bottom: 10),
                              child: Text(
                                "Forget password?".tr(),
                                style:
                                    TextStyle(fontSize: 15, color: dark_Brown),
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
                              backgroundColor: medium_Brown,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25)),
                              padding: const EdgeInsets.only(
                                  left: 40, right: 40, top: 15, bottom: 15)),
                          child: Text(
                            "Login".tr(),
                            style: TextStyle(fontSize: 15, color: white),
                          ),
                        ),
                        Padding(
                            padding: const EdgeInsets.only(top: 45, left: 30),
                            child: Row(
                              children: [
                                Text("Don’t have an account?".tr(),
                                    style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w300,
                                      color: hint_color,
                                    )),
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                          builder: (context) => const signup()),
                                    );
                                  },
                                  child: Text(
                                    "SignUp".tr(),
                                    style: TextStyle(
                                        fontSize: 18, color: dark_Brown),
                                  ),
                                ),
                              ],
                            ))
                      ])))
            ])),
            if (isLoading)
              Padding(
                padding: EdgeInsets.only(top: 675),
                child: Center(
                  child: CircularProgressIndicator(
                    backgroundColor: Light_Brown,
                    color: dark_Brown,
                  ),
                ),
              ),
          ],
        ));
  }
}
