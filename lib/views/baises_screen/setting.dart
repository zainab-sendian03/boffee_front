import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_test/Core.dart';
import 'package:flutter_application_test/core/constants/colors.dart';
import 'package:flutter_application_test/core/constants/components.dart';
import 'package:flutter_application_test/core/provider/Theme_provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingUi extends StatelessWidget {
  SettingUi({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => CorePage()));
            },
            child: Icon(
              Icons.arrow_back_ios_new,
              color: white,
            )),
        backgroundColor: Light_Brown,
        title: Text(
          "Setting",
          style: TextStyle(color: dark_Brown),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Themes:",
                  style: TextStyle(
                      color: context.watch<ThemeProvider>().isDarkmode
                          ? Colors.white
                          : dark_Brown,
                      fontSize: 20,
                      fontWeight: FontWeight.w500),
                ),
              ),
              InkWell(
                  onTap: () {},
                  child: ColorContainer(
                    color: Color.fromARGB(255, 218, 172, 187),
                  )),
              InkWell(
                  onTap: () {},
                  child: ColorContainer(
                    color: const Color.fromARGB(255, 152, 200, 154),
                  )),
              InkWell(
                  onTap: () {},
                  child: ColorContainer(
                    color: Color.fromARGB(255, 170, 194, 213),
                  )),
              InkWell(
                  onTap: () {},
                  child: ColorContainer(
                    color: Colors.grey,
                  )),
            ],
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Mode:",
                  style: TextStyle(
                      color: context.watch<ThemeProvider>().isDarkmode
                          ? Colors.white
                          : dark_Brown,
                      fontSize: 20,
                      fontWeight: FontWeight.w500),
                ),
              ),
              Switch(
                  activeColor: context.watch<ThemeProvider>().isDarkmode
                      ? Colors.white
                      : dark_Brown,
                  value: context.watch<ThemeProvider>().isDarkmode,
                  onChanged: (value) {
                    context.read<ThemeProvider>().changeTheme();
                  })
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Language:",
              style: TextStyle(
                  color: context.watch<ThemeProvider>().isDarkmode
                      ? Colors.white
                      : dark_Brown,
                  fontSize: 20,
                  fontWeight: FontWeight.w500),
            ),
          ),
          InkWell(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: LanguageContainer(text: "Arabic"),
            ),
          ),
          InkWell(
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: LanguageContainer(text: "English"),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Font Size:",
              style: TextStyle(
                  color: context.watch<ThemeProvider>().isDarkmode
                      ? Colors.white
                      : dark_Brown,
                  fontSize: 20,
                  fontWeight: FontWeight.w500),
            ),
          ),

/////////
        ],
      ),
    );
  }
}
