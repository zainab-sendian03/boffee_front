import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:userboffee/Core/config/options.dart';

import 'package:userboffee/Core/constants/components.dart';
import 'package:userboffee/Core/constants/linksapi.dart';
import 'package:userboffee/Core/service/real/crud.dart';
import 'package:userboffee/core/constants/images.dart';
import 'package:userboffee/views/forgetpass/getcode.dart';

import '../../core/constants/colors.dart';

class mailadd extends StatefulWidget {
  const mailadd({super.key});

  @override
  State<mailadd> createState() => _mailaddState();
}

class _mailaddState extends State<mailadd> {
  GlobalKey<FormState> formstats = GlobalKey();
  final email = TextEditingController();
  bool isLoading = false;
  final Crud _crud = Crud();

  Future<void> mailAdd() async {
    String? userEmail = pref.getString('email');
    if (formstats.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });
      try {
        var response = await _crud.postrequest(
            link_Email,
            {
              "email": email.text,
            },
            headers: getoptions2());
        setState(() {
          isLoading = false;
        });
        print("Response body: ${response['body']}");

        if (response is Map && response['success'] == true) {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const GetCode()),
          );
        } else if (userEmail != email.text) {
          alert(formstats.currentContext!, "The selected email is invalid".tr(),
              "Wrong".tr(), "Close".tr());
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
            child: Align(
              alignment: Alignment.topRight,
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
          ),
          Padding(
              padding: const EdgeInsets.only(
                bottom: 400,
              ),
              child: Center(
                child: Text("Mail Address here".tr(),
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
                    "Enter the email address associated\n with your account"
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
                        hintText: "E-mail".tr(),
                        controller: email,
                        min: 3,
                        max: 100,
                        visPassword: false,
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          await mailAdd();
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: medium_Brown,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25)),
                            padding: const EdgeInsets.only(
                                left: 40, right: 40, top: 15, bottom: 15)),
                        child: Text(
                          "Send".tr(),
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
