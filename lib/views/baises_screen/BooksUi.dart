import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

import 'package:userboffee/Core/Models/basic_model.dart';
import 'package:userboffee/Core/Models/book_model.dart';
import 'package:userboffee/Core/Models/bookmodel_maya.dart';
import 'package:userboffee/Core/Models/category.dart';
import 'package:userboffee/Core/Models/d_withFile.dart';
import 'package:userboffee/Core/Models/detial_model.dart';
import 'package:userboffee/Core/constants/colors.dart';
import 'package:userboffee/Core/constants/linksapi.dart';
import 'package:userboffee/Core/service/mostReading.dart';
import 'package:userboffee/Core/service/real/get_type.dart';
import 'package:userboffee/Core/service/real/service_category.dart';
import 'package:userboffee/views/baises_screen/Details.dart';
import 'package:userboffee/views/baises_screen/searchpage.dart';

TextEditingController search = TextEditingController();

class BookUi extends StatefulWidget {
  const BookUi({super.key});

  @override
  State<BookUi> createState() => _BookUiState();
}

String tokenize ='';

class _BookUiState extends State<BookUi> {
  ValueNotifier<int> indexOfType = ValueNotifier(1);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<ResultModel>>(
        future: serviceUI().getAllCategories(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<CategoryModel> temp = snapshot.data as List<CategoryModel>;
            return DefaultTabController(
              length: temp.length,
              child:
                  Column(mainAxisAlignment: MainAxisAlignment.start, children: [
                Padding(
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
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => searchpage(),
                            ));
                      },
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Search'.tr(),
                        hintStyle: const TextStyle(color: Color(0xFFA5A5A5)),
                        prefixIcon: IconButton(
                            icon: const Icon(
                              Icons.search,
                              color: Color(0xFF5D3F2E),
                            ),
                            onPressed: () {}),
                      ),
                      onChanged: (value) {
                        setState(() {
                          tokenize = value;
                        });
                      },
                      controller: search,
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(3),
                      child: Text(
                        'Most reading'.tr(),
                        style:
                            TextStyle(fontSize: 23, color: Color(0xFF5D3F2E)),
                      ).tr(),
                    )
                  ],
                ),
                FutureBuilder(
                  future: mostreading(),
                  builder: ( context,  snapshot) { 
                    if (snapshot.hasData) {
                      ListofEverything<Bookmodel> resList=snapshot.data as ListofEverything<Bookmodel> ;
                     return  Expanded(
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 
                      resList.listresult.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.only(
                            top: 10,
                            left: 15,
                            right: 10,
                          ),
                          child: InkWell(
                            onTap: (){
                              Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => BookDetailsPage(
                                    detail_File: Detail_withFile(
                                  file: DetailModel(
                                    id: 2,
                                    title: 'title',
                                    author_name: 'author_name',
                                    description: 'description',
                                    cover: 'cover',
                                    total_pages: 23,
                                    file: '',
                                  ),
                                  shelfId: 0,
                                )),
                              ),
                            );
                            },
                            child: Container(
                              width: 220,
                              // height: 100,
                             // color: medium_Brown,
                             decoration: BoxDecoration(image: DecorationImage(image: NetworkImage(linkservername+resList.listresult[index].cover))),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                    } else {
                      return Center(child: CircularProgressIndicator());
                    }
                   },
                 
                ),
                Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Builder(builder: (context) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 15, top: 20),
                          child: Text(
                            'Categories'.tr(),
                            style: TextStyle(
                                // fontFamily: 'Imprima',
                                fontSize: 23,
                                color: Color(0xFF5D3F2E)),
                          ).tr(),
                        );
                      }),
                    ),
                  ],
                ),
                SizedBox(
                    height: 50,
                    // width: 50,
                    child: TabBar(
                      onTap: (value) {
                        indexOfType.value = value + 1;
                      },
                      tabAlignment: TabAlignment.start,
                      indicatorColor: Colors.brown,
                      unselectedLabelColor: Colors.grey,
                      labelColor: Colors.brown,
                      isScrollable: true,
                      //labelPadding: EdgeInsets.only(left: -20),
                      tabs: List.generate(
                        temp.length,
                        (index) => Tab(
                          child: Text(
                            temp[index].name.toString(),
                            style: TextStyle(fontSize: 18),
                          ).tr(),
                        ),
                      ),

                      // indicatorSize: TabBarIndicatorSize.tab,
                    )),
                ValueListenableBuilder(
                    valueListenable: indexOfType,
                    builder: (context, value, _) {
                      return Flexible(
                        child: FutureBuilder(
                            future: ServiceImmpl().getAllBook(value.toString()),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                List<DetailModel> temp =
                                    snapshot.data as List<DetailModel>;
                                return TabBarView(
                                    children: List.generate(
                                  6,
                                  (index) => GridView.builder(
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 2,
                                            mainAxisSpacing: 11,
                                            crossAxisSpacing: 11),
                                    itemCount: temp.length,
                                    itemBuilder: (context, index) => Padding(
                                      padding: const EdgeInsets.only(top: 8),
                                      child: Stack(
                                        children: [
                                          Container(
                                            child: Column(children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 10, top: 115),
                                                child: Text(
                                                  temp[index].title.toString(),
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      color: dark_Brown),
                                                ).tr(),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                  left: 10,
                                                ),
                                                child: Text(
                                                  temp[index]
                                                      .author_name
                                                      .toString(),
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      color: medium_Brown),
                                                ).tr(),
                                              ),
                                            ]),
                                            width: 200,
                                            height: 180,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: white,
                                              border: Border.all(
                                                color: medium_Brown,
                                              ),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Light_Brown,
                                                  offset: const Offset(0, 1),
                                                  blurRadius: 10,
                                                )
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 6, left: 10, right: 10),
                                            child: InkWell(
                                              onTap: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          BookDetailsPage(
                                                             detail_File:  Detail_withFile(file:  temp[index]),),
                                                    ));
                                                print(temp[index]);
                                              },
                                              child: Container(
                                                height: 110,
                                                width: 180,
                                                decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                      image: NetworkImage(
                                                       "$linkservername" +
                                                            temp[index]
                                                                .cover
                                                                .toString(),
                                                      ),
                                                      fit: BoxFit.fill),
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  color: Light_Brown,
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ));
                              } else {
                                return CircularProgressIndicator();
                              }
                            }),
                      );
                    }),
              ]),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}
