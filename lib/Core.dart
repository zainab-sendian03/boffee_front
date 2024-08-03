// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:userboffee/Core/config/options.dart';
import 'package:userboffee/Core/constants/colors.dart';
import 'package:userboffee/Core/provider/Theme_provider.dart';
import 'package:userboffee/Core/service/real/logout.dart';
import 'package:userboffee/views/auth/signup.dart';
import 'package:userboffee/views/baises_screen/BooksUi.dart';
import 'package:userboffee/views/baises_screen/Levels_Ui.dart';

import 'package:userboffee/views/baises_screen/QuetsPage.dart';
import 'package:userboffee/views/baises_screen/Shelves_Ui.dart';
import 'package:userboffee/views/baises_screen/setting.dart';

import 'package:userboffee/views/profile/profile.dart';

class CorePage extends StatefulWidget {
  const CorePage({
    Key? key,
  }) : super(key: key);
  @override
  _CorePageState createState() => _CorePageState();
}

class _CorePageState extends State<CorePage> {
  int page = 0;
  GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

  List<Widget> Pages = [QuetsPage(), BookUi(), Shelves_UI(), Levels_UI()];
  List<String> AppBarTitle = ["Home", "Books", "Shelves", "Levels"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 150,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: 150,
            child: Text(
              AppBarTitle[page],
              style: TextStyle(
                  color: dark_Brown, fontSize: 20, fontWeight: FontWeight.w500),
            ).tr(),
          ),
        ),
        actions: [
          PopupMenuButton(
              onSelected: (value) async {
                if (value == "value_Setting") {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return SettingUi();
                  }));
                }
                if (value == "value_Profile") {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) => Profile()));
                  // Navigator.push(context, MaterialPageRoute(builder: (context) {
                  //   return myfavPostUI();

                  //   // myPostUi();
                  // }));
                }
                if (value == "value_Contact") {
                  openemail();
                }
                if (value == "value_Logout") {
                  bool res = await logout();
                  print("res logout");
                  if (res) {
                    print("res logout is true");
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => signup()));
                    pref.clear();
                    print("\pref has cleared");
                  }
                }
              },
              iconColor: dark_Brown,
              color: biege,
              itemBuilder: (context) => [
                    PopupMenuItem(
                      child: Row(
                        children: [
                          Icon(
                            Icons.settings,
                            color: dark_Brown,
                          ),
                          Text(
                            "Setting",
                            style: TextStyle(color: dark_Brown),
                          ).tr(),
                        ],
                      ),
                      value: "value_Setting",
                    ),
                    PopupMenuItem(
                      child: Row(
                        children: [
                          Icon(
                            Icons.person,
                            color: dark_Brown,
                          ),
                          Text("My Profile",
                                  style: TextStyle(color: dark_Brown))
                              .tr()
                        ],
                      ),
                      value: "value_Profile",
                    ),
                    PopupMenuItem(
                      child: Row(
                        children: [
                          Icon(
                            Icons.logout,
                            color: dark_Brown,
                          ),
                          Text("Logout", style: TextStyle(color: dark_Brown))
                              .tr()
                        ],
                      ),
                      value: "value_Logout",
                    ),
                    PopupMenuItem(
                      child: Row(
                        children: [
                          Icon(
                            Icons.email,
                            color: dark_Brown,
                          ),
                          Text("Contact us",
                                  style: TextStyle(color: dark_Brown))
                              .tr()
                        ],
                      ),
                      value: "value_Contact",
                    )
                  ])
        ],
        //!  /////////////////Edit here
        backgroundColor: context.watch<ThemeProvider>().newcolor,
      ),
      bottomNavigationBar: CurvedNavigationBar(
        key: _bottomNavigationKey,
        index: 0,
        items: [
          CurvedNavigationBarItem(
            child: Icon(Icons.home_outlined),
            label: 'Home'.tr(),
          ),
          CurvedNavigationBarItem(
            child: Icon(Icons.book),
            label: 'Books'.tr(),
          ),
          CurvedNavigationBarItem(
            child: Icon(Icons.shelves),
            label: 'Shelves'.tr(),
          ),
          CurvedNavigationBarItem(
            child: Icon(Icons.add_chart),
            label: 'Levels'.tr(),
          ),
        ], //context.watch<ThemeProvider>().newcolor,
        color: context.watch<ThemeProvider>().newcolor,
        buttonBackgroundColor: context.watch<ThemeProvider>().newcolor,
        backgroundColor: no_color,
        animationCurve: Curves.linear,
        animationDuration: Duration(milliseconds: 600),
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

openemail() async {
  // String? encodeQueryParameters(Map<String, String> params) {
  //   return params.entries
  //       .map((MapEntry<String, String> e) =>
  //           '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
  //       .join('&');
  // }

  final Uri emailUri_maryam = Uri(
    scheme: "mailto",
    path: "maryamalbaba200@gmail.com",
    // query: encodeQueryParameters(<String, String>{
    //   'subject': 'Example Subject & Symbols are allowed!',
    // }),
  );

  // if (  await canLaunchUrl(emailUri_maryam)) {
  //  launchUrl(emailUri_maryam);

  // } else {
  //   throw Exception("Couldnot lunch $emailUri_maryam");
  // }
  try {
    print("try in urlluncheer");
    await launchUrl(emailUri_maryam);
  } catch (e) {
    print("error in url luncher contact with us");
    print(e.toString());
  }
}
