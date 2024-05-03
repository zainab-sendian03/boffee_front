import 'package:flutter/material.dart';

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
                "asset/images/bg1.png",
                fit: BoxFit.fill,
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 400),
                child: Image.asset(
                  "asset/images/logo.png",
                  scale: 4,
                ),
              ),
            ),
            const Center(
              child: Padding(
                  padding: EdgeInsets.only(
                    bottom: 150,
                  ),
                  child: Text("Welcome!",
                      style: TextStyle(
                          letterSpacing: 3,
                          fontSize: 30,
                          color: Color(0xFF5D3F2E),
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
                                    backgroundColor: const Color(0xFF94745B),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                  ),
                                  onPressed: () {
                                    Navigator.of(context).pushNamed("login");
                                  },
                                  child: const Text(
                                    "Login",
                                    style: TextStyle(
                                        fontSize: 23, color: Colors.white),
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
                                    backgroundColor: MaterialStateProperty.all(
                                        Colors.transparent),
                                    elevation: MaterialStateProperty.all(0),
                                    side: MaterialStateProperty.all(
                                        const BorderSide(
                                            color: Color(0xFF94745B),
                                            width: 2.0)),
                                  ),
                                  onPressed: () {
                                    Navigator.of(context).pushNamed("signup");
                                  },
                                  child: const Text(
                                    "Create a new account",
                                    style: TextStyle(
                                        fontSize: 23, color: Color(0xFF94745B)),
                                  )),
                            ),
                          ])))
            ])),
          ],
        ));
  }
}
