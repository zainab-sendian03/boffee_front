import 'package:flutter/material.dart';
import 'package:flutter_application_test/auth/constants/linksapi.dart';
import 'package:flutter_application_test/components/crud.dart';

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
  bool passwordVisible = true;
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

  bool male = false;
  bool female = true;
  bool isloading = false;
  final Crud _crud = Crud();
  signUp() async {
    isloading = true;
    print("coming");
    setState(() {});
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
      isloading = false;
      if (response['success'] == true) {
        Navigator.of(context).pushNamedAndRemoveUntil("home", (route) => false);
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
                padding: EdgeInsets.only(top: 110, left: 20),
                child: Text("Welcome to boffee",
                    style: TextStyle(
                        fontSize: 30,
                        color: Color(0xFF94745B),
                        fontWeight: FontWeight.bold))),
            const Padding(
                padding: EdgeInsets.only(top: 155, left: 70),
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
                          const EdgeInsets.only(right: 50, left: 50, top: 230),
                      child: Column(children: [
                        Row(children: [
                          Expanded(
                            child: TextFormField(
                              validator: (valid) => validinput(valid!, 10, 2),
                              controller: username,
                              decoration: InputDecoration(
                                  hintText: "User name",
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
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: TextFormField(
                              validator: (valid) => validinput(valid!, 3, 1),
                              controller: age,
                              decoration: InputDecoration(
                                  hintText: "Age",
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
                          ),
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
                                activeColor: const Color(0xFF94745B),
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
                                activeColor: const Color(0xFF94745B),
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
                        TextFormField(
                          validator: (valid) => validinput(valid!, 30, 10),
                          controller: email,
                          decoration: InputDecoration(
                              hintText: "Email",
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
                          height: 20,
                        ),
                        TextFormField(
                          controller: password,
                          validator: (valid) => validinput(valid!, 20, 8),
                          obscureText: passwordVisible,
                          decoration: InputDecoration(
                              suffixIcon: IconButton(
                                icon: Icon(
                                  passwordVisible
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  color: const Color(0xFF94745B),
                                  size: 21,
                                ),
                                onPressed: () {
                                  setState(() {
                                    passwordVisible = !passwordVisible;
                                  });
                                },
                              ),
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
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          validator: (valid) => validinput(valid!, 20, 8),
                          controller: confirmpass,
                          obscureText: passwordVisible,
                          decoration: InputDecoration(
                              suffixIcon: IconButton(
                                icon: Icon(
                                  passwordVisible
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  color: const Color(0xFF94745B),
                                  size: 21,
                                ),
                                onPressed: () {
                                  setState(() {
                                    passwordVisible = !passwordVisible;
                                  });
                                },
                              ),
                              hintText: "Confirm password",
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
                          height: 60,
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            await signUp();
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF94745B),
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
                            padding: const EdgeInsets.only(top: 45, left: 55),
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
                                    Navigator.of(context).pushNamed("login");
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
