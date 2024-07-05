// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_test/core/constants/colors.dart';
import 'package:flutter_application_test/core/provider/Theme_provider.dart';
import 'package:flutter_application_test/views/baises_screen/BooksUi.dart';
import 'package:flutter_application_test/views/baises_screen/Levels_Ui.dart';
import 'package:flutter_application_test/views/baises_screen/QuetsPage.dart';
import 'package:flutter_application_test/views/baises_screen/Shelves_Ui.dart';
import 'package:flutter_application_test/views/baises_screen/setting.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CorePage extends StatefulWidget {
  const CorePage({
    Key? key,
  }) : super(key: key);
  @override
  _CorePageState createState() => _CorePageState();
}

class _CorePageState extends State<CorePage> {
  int page = 0;
  final GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

  List<Widget> Pages = [QuetsPage(), BookUi(), Shelves_UI(), Levels_UI()];
  List<String> AppBarTitle = ["Home", "Books", "Shelves", "Levels"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 150,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            width: 150,
            child: Text(
              AppBarTitle[page],
              style: TextStyle(
                  color: dark_Brown, fontSize: 20, fontWeight: FontWeight.w500),
            ),
          ),
        ),
        actions: [
          PopupMenuButton(
              onSelected: (value) {
                if (value == "value_Setting") {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return SettingUi();
                  }));
                }
              },
              iconColor: dark_Brown,
              color: biege,
              itemBuilder: (context) => [
                    PopupMenuItem(
                      value: "value_Setting",
                      child: Row(
                        children: [
                          Icon(
                            Icons.settings,
                            color: dark_Brown,
                          ),
                          Text(
                            "Setting",
                            style: TextStyle(color: dark_Brown),
                          ),
                        ],
                      ),
                    ),
                    PopupMenuItem(
                      value: "value_Profile",
                      child: Row(
                        children: [
                          Icon(
                            Icons.person,
                            color: dark_Brown,
                          ),
                          Text("My Profile",
                              style: TextStyle(color: dark_Brown))
                        ],
                      ),
                    ),
                    PopupMenuItem(
                      value: "value_Logout",
                      child: Row(
                        children: [
                          Icon(
                            Icons.logout,
                            color: dark_Brown,
                          ),
                          Text("Logout", style: TextStyle(color: dark_Brown))
                        ],
                      ),
                    ),
                    PopupMenuItem(
                      value: "value_Contact",
                      child: Row(
                        children: [
                          Icon(
                            Icons.email,
                            color: dark_Brown,
                          ),
                          Text("Contact us",
                              style: TextStyle(color: dark_Brown))
                        ],
                      ),
                    )
                  ])
        ],
        backgroundColor: Light_Brown,
      ),
      bottomNavigationBar: CurvedNavigationBar(
        key: _bottomNavigationKey,
        index: 0,
        items: const [
          CurvedNavigationBarItem(
            child: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          CurvedNavigationBarItem(
            child: Icon(Icons.book),
            label: 'Books',
          ),
          CurvedNavigationBarItem(
            child: Icon(Icons.shelves),
            label: 'Shelves',
          ),
          CurvedNavigationBarItem(
            child: Icon(Icons.add_chart),
            label: 'Levels',
          ),
        ],
        color: Light_Brown,
        buttonBackgroundColor: medium_Brown,
        backgroundColor: context.watch<ThemeProvider>().isDarkmode
            ? const Color.fromARGB(255, 33, 31, 31)
            : Colors.white,
        animationCurve: Curves.linear,
        animationDuration: const Duration(milliseconds: 600),
        onTap: (index) {
          setState(() {
            page = index;
          });
        },
        letIndexChange: (index) => true,
      ),
      body: Pages[page],
    );
  }
}
