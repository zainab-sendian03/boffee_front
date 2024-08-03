import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:userboffee/Core/Models/bookmodel_maya.dart';
import 'package:userboffee/Core/Models/d_withFile.dart';
import 'package:userboffee/Core/provider/Theme_provider.dart';
import 'package:userboffee/Core/service/real/search_service.dart';
import 'package:userboffee/views/baises_screen/BooksUi.dart';
import 'package:userboffee/views/baises_screen/Details.dart';

import '../../Core/Models/detial_model.dart';

class searchpage extends StatefulWidget {
  const searchpage({super.key});

  @override
  State<searchpage> createState() => _searchpageState();
}

class _searchpageState extends State<searchpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: context.watch<ThemeProvider>().newcolor,
        ),
        body: Column(children: [
          Padding(
            padding: const EdgeInsets.all(15),
            child: TextField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  prefixIcon: const Icon(
                    Icons.search,
                    size: 30,
                  ),
                  hintText: ('Search....'),
                  hoverColor: const Color.fromARGB(255, 76, 32, 6),
                  iconColor: const Color.fromARGB(255, 60, 24, 3),
                  focusColor: const Color.fromARGB(255, 76, 32, 6),
                  fillColor: const Color.fromARGB(255, 222, 193, 157)),
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
                                                detail_File: Detail_withFile(
                                                    file: DetailModel(
                                                      id: temp[index].id,
                                                      title: temp[index].title,
                                                      author_name: temp[index]
                                                          .toString(),
                                                      description: temp[index]
                                                          .toString(),
                                                      cover: temp[index]
                                                          .toString(),
                                                      total_pages: 20,
                                                      file: '',
                                                      points: 0,
                                                    ),
                                                    shelfId: 0),
                                              )));
                                },
                                title: Text(temp[index].title),
                              )
                            : const FlutterLogo(
                                size: 70,
                              )),
                  );
                } else {
                  return const CircularProgressIndicator();
                }
              }),
        ]));
  }
}
