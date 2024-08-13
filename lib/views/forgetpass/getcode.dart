import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:userboffee/Core/config/options.dart';
import 'package:userboffee/Core/constants/components.dart';
import 'package:userboffee/Core/constants/linksapi.dart';
import 'package:userboffee/Core/service/real/crud.dart';
import 'package:userboffee/core/constants/images.dart';
import 'package:userboffee/views/forgetpass/reset.dart';

import '../../core/constants/colors.dart';

class GetCode extends StatefulWidget {
  const GetCode({super.key});

  @override
  State<GetCode> createState() => _GetCodeState();
}

class _GetCodeState extends State<GetCode> {
  GlobalKey<FormState> formstats = GlobalKey();
  final code = TextEditingController();
  final Crud _crud = Crud();
  bool isLoading = false;

  Future<void> getTheCode() async {
    if (formstats.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });
      try {
        var response = await _crud.postrequest(
            link_checkCode,
            {
              "code": code.text,
            },
            headers: getoptions2());

        setState(() {
          isLoading = false;
        });
        print("Response body: ${response['body']}");

        if (response is Map &&
            response["message"] == "passwords.code_is_valid") {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const resetpass()),
          );
          pref.setString('code', code.text);
        } else {
          alert(
              formstats.currentContext!,
              "The entered code is incorrect\nPlease try again!".tr(),
              "Wrong".tr(),
              "Close".tr());
          print('Failed to check code: ${response['message']}');
        }
      } catch (e) {
        setState(() {
          isLoading = false;
        });
        print("ERROR: $e");
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
            padding: const EdgeInsets.only(top: 40, left: 20),
            child: IconButton(
              icon: Icon(
                Icons.arrow_back_outlined,
                color: dark_Brown,
                size: 35,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 140,
            ),
            child: Center(
              child: Column(
                children: [
                  Text("Get your code".tr(),
                      style: TextStyle(
                          fontSize: 35,
                          color: medium_Brown,
                          fontWeight: FontWeight.bold)),
                  SizedBox(height: 30),
                  Text(
                      "Please enter the 6 digit code that\n send to your account"
                          .tr(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 23,
                          color: dark_Brown,
                          fontWeight: FontWeight.w400)),
                ],
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 120, left: 35, right: 35),
              child: SingleChildScrollView(
                child: Form(
                  key: formstats,
                  child: Column(
                    children: [
                      CustomTextFormField(
                        hintText: "Code".tr(),
                        controller: code,
                        min: 6,
                        max: 6,
                        visPassword: false,
                      ),
                      SizedBox(height: 40),
                      ElevatedButton(
                        onPressed: () async {
                          await getTheCode();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: medium_Brown,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                          padding: const EdgeInsets.symmetric(
                            vertical: 15,
                            horizontal: 40,
                          ),
                        ),
                        child: Text(
                          "Verify".tr(),
                          style: TextStyle(fontSize: 15, color: white),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          if (isLoading)
            Center(
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 400,
                ),
                child: Center(
                  child: CircularProgressIndicator(
                    backgroundColor: Light_Brown,
                    color: dark_Brown,
                  ),
                ),
              ),
            )
        ],
      ),
    );
  }
}
