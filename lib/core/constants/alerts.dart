import 'package:flutter/material.dart';
import 'package:flutter_application_test/core/constants/colors.dart';

import '../../data/datasource/static.dart';

Future<dynamic> wrongLogin(BuildContext context) {
  return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        String contentText = contentT;
        return AlertDialog(
          backgroundColor: Colors.white60,
          elevation: 0,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          icon: const Icon(
            Icons.error,
            size: 50,
            color: Color(0xFF94745B),
          ),
          title: const Column(
            children: [
              Center(
                child: Text(
                  "Wrong",
                  style: TextStyle(
                    fontSize: 30,
                    color: Color(0xFF5D3F2E),
                  ),
                ),
              ),
              Divider(
                color: Color(0xFF94745B),
                thickness: 2,
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
                    backgroundColor: Colorss.buttomColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25)),
                    padding: const EdgeInsets.only(
                        left: 40, right: 40, top: 15, bottom: 15)),
                child: const Text("Close",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                    )),
              ),
            ),
          ],
        );
      });
}
