import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_test/core/constants/components.dart';
import 'package:flutter_application_test/core/constants/images.dart';
import 'package:flutter_application_test/views/forgetpass/reset.dart';

import '../../core/constants/colors.dart';

class getCode extends StatefulWidget {
  const getCode({super.key});

  @override
  State<getCode> createState() => _getCodeState();
}

class _getCodeState extends State<getCode> {
  GlobalKey<FormState> formstats = GlobalKey();
  final first = TextEditingController();
  final second = TextEditingController();
  final third = TextEditingController();
  final fourth = TextEditingController();

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
                child: Text("Get your code",
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
                    "Please enter the 4 digit code that\n send to your accoun",
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
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: CustomTextFormField(
                                hintText: "",
                                controller: first,
                                min: 1,
                                max: 1,
                                visPassword: false,
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              flex: 1,
                              child: CustomTextFormField(
                                hintText: "",
                                controller: second,
                                min: 1,
                                max: 1,
                                visPassword: false,
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              flex: 1,
                              child: CustomTextFormField(
                                hintText: "",
                                controller: third,
                                min: 1,
                                max: 1,
                                visPassword: false,
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              flex: 1,
                              child: CustomTextFormField(
                                hintText: "",
                                controller: fourth,
                                min: 1,
                                max: 1,
                                visPassword: false,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) => resetpass()),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: medium_Brown,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25)),
                              padding: const EdgeInsets.only(
                                  left: 40, right: 40, top: 15, bottom: 15)),
                          child: Text(
                            "Verify",
                            style: TextStyle(fontSize: 15, color: white),
                          ),
                        ),
                      ],
                    )))
          ])),
        ],
      ),
    );
  }
}
