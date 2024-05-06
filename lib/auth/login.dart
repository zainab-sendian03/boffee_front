import 'package:flutter/material.dart';
import 'package:flutter_application_test/auth/constants/linksapi.dart';
import 'package:flutter_application_test/components/crud.dart';
//import 'package:http/http.dart' as http;

class login extends StatefulWidget {
  const login({super.key});

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
  final user_name = TextEditingController();
  final password = TextEditingController();

  final Crud _crud = Crud();
  GlobalKey<FormState> formstats = GlobalKey();
  late final String? Function(String?) valid;
  validinput(String val, int max, int min) {
    if (val.length > max) {
      return " $max لا يمكن ان يكون هذا الحقل اكبر من";
    }
    if (val.isEmpty) {
      return "لا يمكن ان يكون هذا الحقل فارغ";
    }
    if (val.length < min) {
      return "$min لا يمكن ان يكون هذا الحقل اصغر من";
    }
  }

  logIn() async {
    if (formstats.currentState!.validate()) {
      var response = await _crud.postrequest(linklogin, {
        "user_name": user_name.text,
        "password": password.text,
      });
      if (response['success'] == true) {
        print("${response}");
        Navigator.of(context).pushNamedAndRemoveUntil("home", (route) => false);
      } else {
        showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) {
            String contentText =
                "كلمة السر أو الحساب الالكتروني خطأ أو الحساب غير موجود \n يرجى إعادة المحاولة ";
            return AlertDialog(
              backgroundColor: Colors.white60,
              elevation: 0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              icon: const Icon(
                Icons.error,
                size: 50,
                color: Color(0xFF94745B),
              ),
              title: const Column(
                children: [
                  Center(
                    child: Text(
                      "خطأ",
                      style: TextStyle(
                        fontSize: 30,
                        color: Color(0xFF5D3F2E),
                      ),
                    ),
                  ),
                  Divider(
                    color: Color(0xFF94745B),
                    thickness: 3,
                  )
                ],
              ),
              content: Text(
                contentText,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                ),
              ),
              actions: <Widget>[
                Center(
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF94745B),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25)),
                        padding: const EdgeInsets.only(
                            left: 40, right: 40, top: 15, bottom: 15)),
                    child: const Text("Cancel",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                        )),
                  ),
                ),
              ],
            );
          },
        );
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
                padding: EdgeInsets.only(top: 110, left: 20),
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
                          const EdgeInsets.only(right: 50, left: 50, top: 350),
                      child: Column(children: [
                        TextFormField(
                          validator: (valid) => validinput(valid!, 20, 2),
                          controller: user_name,
                          decoration: InputDecoration(
                              hintText: "user_name",
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 20, horizontal: 20),
                              focusedBorder: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20.0)),
                                borderSide: BorderSide(
                                    color: Color(0xFFB8937E), width: 2.0),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                              )),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        TextFormField(
                          controller: password,
                          validator: (valid) => validinput(valid!, 10, 8),
                          decoration: InputDecoration(
                              hintText: "Password",
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 20, horizontal: 20),
                              focusedBorder: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20.0)),
                                borderSide: BorderSide(
                                    color: Color(0xFFB8937E), width: 2.0),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                              )),
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
                              backgroundColor: const Color(0xFF94745B),
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
                                    Navigator.of(context).pushNamed("signup");
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
