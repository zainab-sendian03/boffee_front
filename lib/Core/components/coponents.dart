// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:lottie/lottie.dart';

import 'package:userboffee/Core/components/colors.dart';

class ColorContainer extends StatelessWidget {
  const ColorContainer({super.key, required this.color});
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
    );
  }
}

class LanguageContainer extends StatelessWidget {
  const LanguageContainer({
    Key? key,
    required this.text,
  }) : super(key: key);
  final String text;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 30,
      decoration: BoxDecoration(
          color: Light_Brown, borderRadius: BorderRadius.circular(5)),
      child: Text(
        text,
        textAlign: TextAlign.center,
      ),
    );
  }
}

class CircleIndecaterSwitch extends StatelessWidget {
  const CircleIndecaterSwitch({super.key});

  @override
  Widget build(BuildContext context) {
    try {
      return CircularProgressIndicator();
    } catch (e) {
      //print(e.toString());
      return Lottie.network(
          "https://lottie.host/5f19fea0-3f26-40dd-8516-cdc04ee6ee90/7vO10mg8BD.json");
    }
  }
}

// class QutesContainer extends StatelessWidget {
//   QutesContainer({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: ListTile(
//           contentPadding: EdgeInsets.all(17),
//           isThreeLine: true,
//           subtitle: Text("life it is not bad  "),
//           title: Text("maryam"),
//           trailing: SizedBox(
//             height: 20,
//             width: 60,
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Icon(Icons.share_rounded),
//                 Icon(Icons.favorite_border),
//               ],
//             ),
//           )),
//     );
//   }
// }


class SearchContainer extends StatelessWidget {
  const SearchContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(20),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          decoration: BoxDecoration(
            border: Border.all(color: const Color(0xFF5D3F2E)),
            borderRadius: BorderRadius.circular(30),
            color: Colors.white,
          ),
          child: TextFormField(
            onTap: () {
           ///   ShowDialogg();
            },
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: 'What is in your mind?',
              hintStyle: const TextStyle(color: Color(0xFFA5A5A5)),
              prefixIcon: IconButton(
                  icon: const Icon(
                    Icons.search,
                    color: Color(0xFF5D3F2E),
                  ),
                  onPressed: () {}),
            ),
          ),
        ),
      );

  }
}