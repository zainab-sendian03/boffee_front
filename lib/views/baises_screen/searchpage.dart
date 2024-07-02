import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:userboffee/Core/Models/bookmodel_maya.dart';
import 'package:userboffee/Core/Models/detial_model.dart';
import 'package:userboffee/Core/constants/colors.dart';
import 'package:userboffee/Core/service/real/search_service.dart';
import 'package:userboffee/views/baises_screen/BooksUi.dart';
import 'package:userboffee/views/baises_screen/Details.dart';


class searchpage extends StatefulWidget {
  const searchpage({super.key});

  @override
  State<searchpage> createState() => _searchpageState();
}

class _searchpageState extends State<searchpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: medium_Brown,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(15),
            child: TextField(
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        prefixIcon: Icon(
                          Icons.search,
                          size: 30,
                        ),
                        hintText: "Search".tr(),
                        hoverColor: Color.fromARGB(255, 76, 32, 6),
                        iconColor: Color.fromARGB(255, 60, 24, 3),
                        focusColor: Color.fromARGB(255, 76, 32, 6),
                        fillColor: Color.fromARGB(255, 222, 193, 157)),
                    onChanged: (value) {
                      setState(() {
                        tokenize = value;
                      });
                    },
                    controller: search,
            ),
          ),
        
      
          
      
        FutureBuilder(
              future: Servicesearch().PostAllBook(tokenize.toString()),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<BookModel> temp = snapshot.data as List<BookModel>;
                  return Expanded(
                    flex: 1,
                    child: ListView.builder(
                        itemCount: (tokenize == '') ? 0 : temp.length,
                        itemBuilder: (context, index) => (tokenize != '')
                            ? ListTile(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => BookDetailsPage(
                                              detailModel: DetailModel(
                                                  id: temp[index].id,
                                                  title: temp[index].title,
                                                  author_name:
                                                      temp[index].toString(),
                                                  description:
                                                      temp[index].toString(),
                                                  cover: temp[index].toString(),
                                                  total_pages: 20))));
                                },
                                title: Text(temp[index].title),
                              )
                            : FlutterLogo(
                                size: 70,
                              )),
                  );
   
                    } else
                  return CircularProgressIndicator();
}),
        ])
);}}
  