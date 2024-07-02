// import 'dart:io';

// import 'package:flutter/material.dart';

// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:userboffee/Core/Models/post_model.dart';
// import 'package:userboffee/Core/constants/colors.dart';
// import 'package:userboffee/Core/constants/components.dart';
// import 'package:userboffee/Core/service/real/qutes_ser.dart';
// import 'package:userboffee/feature/getbooks/bloc/books_bloc.dart';
// import 'package:userboffee/feature/getpost/bloc/getpost_bloc.dart';

// class BookUi extends StatelessWidget {
//   BookUi({super.key});
//   TextEditingController body_controller = TextEditingController();
//   @override
//   Widget build(BuildContext context) {
//     return 
    
//     BlocProvider(
//       create: (context) => BooksBloc()..add(GettingBooks()),
//       child: Builder(builder: (context) {
//         return BlocBuilder<BooksBloc, BooksState>(
//           builder: (context, state) {
//             print("before if in get books");
//             if (state is SuccessGetBook_state) {
//               print("state is SuccessGetBook_state in ui");
//               return Column(
//                 children: [
                 
             
//                   BlocListener<BooksBloc, BooksState>(
//                     listener: (context, state) {
//                       // TODO: implement listener
//                       if (state is SuccessGetBook_state) {
//                         ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//                           content: Text("Get Data"),
//                           backgroundColor: Light_Brown,
//                         ));
//                       }
//                     },
//                     child: Expanded(
//                       child: GridView.builder(
//                         itemCount: state.Books.length,
//                         itemBuilder: (context, int index) {
//                           return Card(
//                             child: Container(
                              
//                               child: Column(children: [
//                                Container(decoration: BoxDecoration(image: DecorationImage(image: AssetImage(state.Books[index].cover))),),
//                               Text(state.Books[index].title),
//                             // File(state.Books[index].file)
//                               ],),
                               
                               
//                                ),
//                           );
//                         }, gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                           crossAxisCount: 2),
//                       ),
//                     ),
//                   )
//                 ],
//               );
//             } else if (state is ErorrGetBooks_state) {
//               print("Error in else if in ui books");
//               return CircularProgressIndicator();
//             } else {
//                print("Excep in else in ui books ");
//               return CircularProgressIndicator();
//             }
//           },
//         );
//       }),
//     );
//   }
// }
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

import 'package:userboffee/Core/Models/basic_model.dart';
import 'package:userboffee/Core/Models/category.dart';
import 'package:userboffee/Core/Models/detial_model.dart';
import 'package:userboffee/Core/constants/colors.dart';
import 'package:userboffee/Core/constants/linksapi.dart';
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

String tokenize = '';

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
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Most reading'.tr(),
                          style:
                              TextStyle(fontSize: 23, color: Color(0xFF5D3F2E)),
                        ).tr(),
                      ),
                    )
                  ],
                ),
                Flexible(
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 4,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.only(
                          top: 10,
                          left: 15,
                          right: 10,
                        ),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => BookDetailsPage(
                                  detailModel: DetailModel(
                                    id: 2,
                                    title: 'title',
                                    author_name: 'author_name',
                                    description: 'description',
                                    cover: 'cover',
                                    total_pages: 23,
                                  ),
                                ),
                              ),
                            );
                          },
                          child: Container(
                            width: 220,
                            // height: 100,
                            color: medium_Brown,
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Column(
                  //mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Builder(builder: (context) {
                        return Align(
                          alignment: Alignment.bottomLeft,
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 15, top: 20),
                            child: Text(
                              'Categories'.tr(),
                              style: TextStyle(
                                  // fontFamily: 'Imprima',
                                  fontSize: 23,
                                  color: Color(0xFF5D3F2E)),
                            ).tr(),
                          ),
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
                                            mainAxisSpacing: 8,
                                            crossAxisSpacing: 8),
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
                                                              detailModel:
                                                                  temp[index]),
                                                    ));
                                                print(temp[index]);
                                              },
                                              child: Container(
                                                height: 110,
                                                width: 180,
                                                decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                      image: NetworkImage(
                                                       " $linkservername" +
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
