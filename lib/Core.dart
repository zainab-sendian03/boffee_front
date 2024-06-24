// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';
import 'package:flutter/material.dart';
import 'package:userboffee/Core/components/colors.dart';
import 'package:userboffee/views/BooksUi.dart';
import 'package:userboffee/views/Levels_Ui.dart';

import 'package:userboffee/views/QuetsPage.dart';
import 'package:userboffee/views/Shelves_Ui.dart';

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

List<Widget>Pages=[
  QuetsPage(),
  BookUi(),
  Shelves_UI(),
  Levels_UI()
  
  
];
List<String>AppBarTitle=[
  "Home",
  "Books",
  "Shelves",
  "Levels"

];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        
        backgroundColor: Light_Brown,
        title: Text(AppBarTitle[page],style: TextStyle(color: dark_Brown),
        ),
      ),
      bottomNavigationBar: CurvedNavigationBar(
        key: _bottomNavigationKey,
        index: 0,
        items: [
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
        buttonBackgroundColor:medium_Brown ,
        backgroundColor:white,
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