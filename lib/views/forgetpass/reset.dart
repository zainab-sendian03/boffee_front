import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:userboffee/Core/config/options.dart';
import 'package:userboffee/Core/constants/components.dart';
import 'package:userboffee/Core/constants/linksapi.dart';
import 'package:userboffee/Core/service/real/crud.dart';
import 'package:userboffee/views/auth/login.dart';

import '../../core/constants/colors.dart';
import '../../core/constants/images.dart';

class resetpass extends StatefulWidget {
  const resetpass({super.key});

  @override
  State<resetpass> createState() => _resetpassState();
}

class _resetpassState extends State<resetpass> {
  GlobalKey<FormState> formstats = GlobalKey();
  var pass = TextEditingController();
  var conf_pass = TextEditingController();
  final Crud _crud = Crud();
  bool isLoading = false;

  Future<void> resetPassword() async {
    String? code = pref.getString('code');
    if (formstats.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });
      try {
        var response = await _crud.postrequest(
            link_Reset,
            {
              "code": code,
              "password": pass.text,
              "password_confirmation": conf_pass.text
            },
            headers: getoptions2());
        setState(() {
          isLoading = false;
        });
        print("Response body: ${response['body']}");
        print('Retrieved code: $code');
        if (response is Map &&
            response['message'] == "Password has been successfully reset") {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const login()),
          );
        } else {
          alert(
              formstats.currentContext!,
              "The password confirmation does not match.".tr(),
              "Wrong".tr(),
              "Close".tr());

          print('Failed to send email: ${response['message']}');
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
            padding: const EdgeInsets.only(top: 40, right: 20),
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
                bottom: 400,
              ),
              child: Center(
                child: Text("Reset Your Password".tr(),
                    style: TextStyle(
                        fontSize: 35,
                        color: medium_Brown,
                        fontWeight: FontWeight.bold)),
              )),
          Padding(
              padding: const EdgeInsets.only(
                bottom: 230,
              ),
              child: Center(
                child: Text(
                    "Your new password must be\ndifferent from previously used\n password"
                        .tr(),
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
                        hintText: "Password".tr(),
                        controller: pass,
                        min: 3,
                        max: 20,
                        visPassword: false,
                        showVisPasswordToggle: true,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomTextFormField(
                        hintText: "Confirm Password".tr(),
                        controller: conf_pass,
                        min: 3,
                        max: 20,
                        visPassword: true,
                        showVisPasswordToggle: true,
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          await resetPassword();
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: medium_Brown,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25)),
                            padding: const EdgeInsets.only(
                                left: 40, right: 40, top: 15, bottom: 15)),
                        child: Text(
                          "Done".tr(),
                          style: TextStyle(fontSize: 15, color: white),
                        ),
                      ),
                    ])))
          ])),
          if (isLoading)
            Stack(
              children: [
                Container(
                  height: double.infinity,
                  width: double.infinity,
                  decoration: BoxDecoration(color: black.withOpacity(0.5)),
                ),
                Center(
                  child: CircularProgressIndicator(
                    backgroundColor: medium_Brown,
                    color: insidbook_color,
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
