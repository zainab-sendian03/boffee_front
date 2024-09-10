import 'package:flutter/material.dart';
import 'package:userboffee/Core/constants/colors.dart';
import 'package:userboffee/views/baises_screen/shelves/readDone.dart';
import 'package:userboffee/views/baises_screen/shelves/readLater.dart';
import 'package:userboffee/views/baises_screen/shelves/reading.dart';

class Shelves_UI extends StatefulWidget {
  const Shelves_UI({super.key});

  @override
  State<Shelves_UI> createState() => _Shelves_UIState();
}

class _Shelves_UIState extends State<Shelves_UI> {
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
                        builder: (context) => const Reading(
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
                          'asset/images/reading.png',
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
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ReadingDone(
                            status: 'finished',
                          )));
            },
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
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      const ReadingLater(status: 'read_later'),
                ),
              );
            },
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
