import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:userboffee/Core/Models/detial_model.dart';
import 'package:userboffee/Core/constants/colors.dart';
import 'package:userboffee/Core/constants/linksapi.dart';

class BookDetailsPage extends StatefulWidget {
  BookDetailsPage({super.key, required this.detailModel});
  final DetailModel detailModel;

  @override
  State<BookDetailsPage> createState() => _BookDetailsPageState();
}

class _BookDetailsPageState extends State<BookDetailsPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  Future<dynamic> alert_report(
      BuildContext context, TextEditingController noteCont) {
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: const Color(0xFFFFF8F1),
            elevation: 0,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            content: SizedBox(
              width: MediaQuery.of(context).size.width * 0.65,
              height: MediaQuery.of(context).size.height * 0.2,
              child: TextFormField(
                showCursor: false,
                maxLines: 10,
                controller: noteCont,
                decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: "write your report....",
                    hintStyle: TextStyle(color: Color(0XFFA5A5A5))),
              ),
            ),
            actions: <Widget>[
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.brown,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25)),
                ),
                child: const Text("Send",
                    style: TextStyle(
                      fontSize: 17,
                      color: Colors.white,
                    )).tr(),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Cancle",
                    style: TextStyle(
                      fontSize: 17,
                      color: Colors.brown,
                    )).tr(),
              ),
            ],
          );
        });
  }

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

//,required this.detailModel
  @override
  Widget build(
    BuildContext context,
  ) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Light_Brown,
        title: Text(
          'Book Details',
          style: TextStyle(color: dark_Brown),
        ),
        actions: [
          IconButton(
            color: white,
            icon: Icon(Icons.favorite_outline),
            onPressed: () {
              // اضف هنا الاكشن الذي تريده عند الضغط على أيقونة المفضلة
            },
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // صورة الكتاب
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 10, top: 28),
                child: Container(
                  height: 200,
                  width: 150,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(
                            "$linkservername/" +
                                widget.detailModel.cover.toString(),
                          ),
                          fit: BoxFit.fill)),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 15, top: 35),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      widget.detailModel.title.toString(),
                      style: TextStyle(
                          fontSize: 24.0, fontWeight: FontWeight.bold),
                    ).tr(),
                    SizedBox(height: 10.0),
                    Text(
                      widget.detailModel.author_name.toString(),
                      style: TextStyle(fontSize: 18.0),
                    ).tr(),
                    SizedBox(height: 10.0),
                    Text(
                      widget.detailModel.total_pages.toString(),
                      style: TextStyle(fontSize: 18.0),
                    ).tr(),
                    SizedBox(height: 10.0),
                    Text(
                      'type',
                      style: TextStyle(fontSize: 18.0),
                    ).tr(),
                  ],
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 25),
            child: TabBar(
              tabAlignment: TabAlignment.start,
              indicatorSize: TabBarIndicatorSize.label,
              indicatorColor: Colors.brown,
              unselectedLabelColor: Colors.grey,
              labelColor: Colors.brown,
              isScrollable: true,
              controller: _tabController,
              tabs: [
                Tab(
                  child: Text(
                    'Info',
                    style: TextStyle(fontSize: 18),
                  ).tr(),
                ),
                Center(
                  widthFactor: 2,
                  child: Tab(
                    child: Text(
                      'Reviews',
                      style: TextStyle(fontSize: 18),
                    ).tr(),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          bottom: 135, left: 25, right: 25),
                      child: Center(
                          child: Text(
                        widget.detailModel.description.toString(),
                        style: TextStyle(fontSize: 20),
                      ).tr()),
                    ),
                    Padding(
                        padding: const EdgeInsets.only(
                            left: 35, bottom: 70, top: 300),
                        child: SizedBox(
                          width: 130,
                          height: 50,
                          child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.brown),
                            ),
                            onPressed: () {},
                            child: Text(
                              'Read now',
                              style: TextStyle(
                                fontSize: 18,
                                color: white,
                              ),
                            ).tr(),
                          ),
                        )),
                    Padding(
                      padding: const EdgeInsets.only(top: 375, left: 35),
                      child: TextButton(
                        onPressed: () {
                          alert_report(context, TextEditingController());
                        },
                        child: Text(
                          'Report',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.grey,
                          ),
                        ).tr(),
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.only(
                          left: 200,
                          top: 300,
                          bottom: 70,
                        ),
                        child: SizedBox(
                          width: 130,
                          height: 50,
                          child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.white),
                              side: MaterialStateProperty.all(
                                  BorderSide(color: Colors.brown)),
                            ),
                            onPressed: () {},
                            child: Text(
                              'Read Later',
                              style: TextStyle(
                                fontSize: 16.8,
                                color: medium_Brown,
                              ),
                            ).tr(),
                          ),
                        )),
                  ],
                ),
                Stack(
                  children: [
                    ListView(
                      scrollDirection: Axis.vertical,
                      children: <Widget>[
                        Padding(
                          padding:
                              EdgeInsets.only(left: 30, right: 30, top: 30),
                          child: Container(
                            decoration: BoxDecoration(
                                color: offwhite,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: Light_Brown,
                                    offset: Offset(0, 5),
                                    blurRadius: 10,
                                    // spreadRadius: 10,
                                  )
                                ]),
                            height: 140,
                            width: 20,
                          ),
                        ),
                      ],
                    ),
                    //   AddComment()
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
