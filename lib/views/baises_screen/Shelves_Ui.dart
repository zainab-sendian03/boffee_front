import 'package:flutter/material.dart';
import 'package:flutter_application_test/core/constants/colors.dart';
import 'package:flutter_application_test/views/reading.dart';

class Shelves_UI extends StatelessWidget {
  const Shelves_UI({super.key});

  @override
  Widget build(BuildContext context) {
    Color buttomColor = const Color(0xff94745B);
    return Padding(
        padding: const EdgeInsets.only(top: 40),
        child: Center(
            child: Column(children: [
          Stack(children: [
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Reading(
                              status: 'reading',
                            )));
              },
              child: Container(
                  height: 160,
                  width: 330,
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: medium_Brown,
                          offset: const Offset(0, 2),
                          blurRadius: 10,
                        )
                      ],
                      borderRadius: BorderRadius.circular(20),
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        colorFilter: ColorFilter.mode(
                          buttomColor.withOpacity(0.5),
                          BlendMode.srcOver,
                        ),
                        image: const AssetImage(
                          'asset/images/reading.png', // Replace with your image URL
                        ),
                      ))),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 120, left: 15),
              child: Text(
                "Reading",
                style: TextStyle(fontSize: 22, color: white),
              ),
            ),
          ]),
          const SizedBox(
            height: 40,
          ),
          InkWell(
            onTap: () {},
            child: Stack(
              children: [
                Container(
                    height: 160,
                    width: 330,
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: medium_Brown,
                            offset: const Offset(0, 2),
                            blurRadius: 10,
                          )
                        ],
                        borderRadius: BorderRadius.circular(20),
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          colorFilter: ColorFilter.mode(
                            buttomColor.withOpacity(0.5),
                            BlendMode.srcOver,
                          ),
                          image: const AssetImage(
                            'asset/images/readdone.png', // Replace with your image URL
                          ),
                        ))),
                Padding(
                  padding: const EdgeInsets.only(top: 120, left: 15),
                  child: Text(
                    "Read Done",
                    style: TextStyle(fontSize: 22, color: white),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          InkWell(
            onTap: () {},
            child: Stack(
              children: [
                Container(
                    height: 160,
                    width: 330,
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: medium_Brown,
                            offset: const Offset(0, 2),
                            blurRadius: 10,
                          )
                        ],
                        borderRadius: BorderRadius.circular(20),
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          colorFilter: ColorFilter.mode(
                            buttomColor.withOpacity(0.5),
                            BlendMode.srcOver,
                          ),
                          image: const AssetImage(
                            'asset/images/readlater.png', // Replace with your image URL
                          ),
                        ))),
                Padding(
                  padding: const EdgeInsets.only(top: 120, left: 15),
                  child: Text(
                    "Read Later",
                    style: TextStyle(fontSize: 22, color: white),
                  ),
                ),
              ],
            ),
          ),
        ])));
  }
}
