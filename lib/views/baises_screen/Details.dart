import 'dart:convert';

import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:userboffee/Core.dart';
import 'package:userboffee/Core/Models/basic_model.dart';
import 'package:userboffee/Core/Models/d_withFile.dart';
import 'package:userboffee/Core/Models/reading_model.dart';
import 'package:userboffee/Core/Models/reviwe.dart';
import 'package:userboffee/Core/config/options.dart';
import 'package:userboffee/Core/constants/colors.dart';
import 'package:userboffee/Core/constants/linksapi.dart';
import 'package:userboffee/Core/provider/Theme_provider.dart';
import 'package:userboffee/Core/service/real/crud.dart';
import 'package:userboffee/Core/service/real/getallrevuwe.dart';
import 'package:userboffee/Core/service/real/reading_service.dart';
import 'package:userboffee/Core/service/real/readinglater.dart';
import 'package:userboffee/Core/service/reporrt.dart';
import 'package:userboffee/views/profile/AddComment.dart';
import 'package:userboffee/views/PDFviewer.dart';
import 'package:http/http.dart' as http;

class BookDetailsPage extends StatefulWidget {
  const BookDetailsPage({super.key, required this.detail_File});
  final Detail_withFile detail_File;

  @override
  State<BookDetailsPage> createState() => _BookDetailsPageState();
}

class _BookDetailsPageState extends State<BookDetailsPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  double avgRating = 0;
  bool isFirstTime = true;
  int MyPoints = 0;
  bool isReviwe = true;
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
                onPressed: () async {
                  ResultModel resultModel = await ServiceReport().postAllReport(
                      noteCont.text, widget.detail_File.shelfId.toString());
                  if (resultModel is successModel) {
                    Navigator.pop(context);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("Please enter new report")));
                  }
                  ElevatedButton.styleFrom(
                    backgroundColor: medium_Brown,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25)),
                  );
                },
                child: const Text("Send",
                    style: TextStyle(
                      fontSize: 17,
                      color: Colors.white,
                    )),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Cancle",
                    style: TextStyle(
                      fontSize: 17,
                      color: Colors.brown,
                    )),
              ),
            ],
          );
        });
  }

  bool isFav = false;

  final Crud _crud = Crud();
  Future<void> get_AVG_rating() async {
    try {
      final bookId = widget.detail_File.file!.id;
      final url = "$link_AVGrating/$bookId";

      print("AVG Rating URL: $url");

      var response = await _crud.getrequest(url);
      print("Server response: $response");

      if (response is Map && response.containsKey('average_rating')) {
        setState(() {
          avgRating = double.parse(response['average_rating']);
        });
        print("Average rating fetched successfully");
      } else {
        print("Failed to fetch average rating");
        print("Server response: $response");
      }
    } catch (e) {
      print(e);
    }
  }

  void _showSnackBar(String msg, AnimatedSnackBarType type) {
    AnimatedSnackBar(
      duration: const Duration(seconds: 8),
      builder: (context) {
        return MaterialAnimatedSnackBar(
          messageText: msg,
          type: type,
          foregroundColor: Colors.white,
          backgroundColor: medium_Brown,
        );
      },
    ).show(context);
  }

  Future<void> fetchPoints() async {
    try {
      var response = await http.get(
        Uri.parse(link_userDetails),
        headers: getoptions2(),
      );
      print("Server response: ${response.body}");

      if (response.statusCode == 200) {
        var responseBody = json.decode(response.body);
        if (responseBody is Map<String, dynamic> &&
            responseBody['success'] == true) {
          setState(() {
            MyPoints = responseBody['data']['my_points'] ?? 0;
            print("User_points: $MyPoints");
          });
        } else {
          print('Failed to fetch User points');
        }
      } else {
        print('Failed to fetch User points');
      }
    } catch (e) {
      print(e);
      print('An error occurred');
    }
  }

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
    get_AVG_rating();
    fetchPoints();
    _initializePreferences();
  }

  Future<void> checkFirstTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isFirstTime = prefs.getBool('isFirstTime') ?? true;
    if (isFirstTime) {
      _showSnackBar("The book has been added to Reading shelf".tr(),
          AnimatedSnackBarType.success);
      await prefs.setBool('isFirstTime', false);
    }
  }

  Future<void> _initializePreferences() async {
    pref = await SharedPreferences.getInstance();
    setState(() {
      // Load the saved favorite status
      isFav = pref.getBool('isFav_${widget.detail_File.file!.id}') ?? false;
    });
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: context.watch<ThemeProvider>().newcolor,
        title: Text(
          'Book Details'.tr(),
          style: TextStyle(color: dark_Brown),
        ),
        actions: [
          IconButton(
              color: white,
              icon: Icon(
                isFav ? Icons.favorite : Icons.favorite_border,
                color: isFav ? const Color.fromARGB(255, 160, 14, 3) : white,
              ),
              onPressed: () async {
                if (!isFav) {
                  try {
                    await Dio().post(
                      "http://$ip_Zainab:8000/api/add/${widget.detail_File.file!.id}",
                      options: Options(headers: getoptions2()),
                    );
                    setState(() {
                      isFav = true;
                    });
                    _showSnackBar("The book has been added to your profile",
                        AnimatedSnackBarType.success);
                  } catch (e) {
                    print('Error adding to favorites: $e');
                    ScaffoldMessenger.of(context)
                        .showSnackBar(const SnackBar(content: Text("Failed")));
                  }
                } else {
                  try {
                    await Dio().delete(
                      "http://$ip_Zainab:8000/api/remove/${widget.detail_File.file!.id}",
                      options: Options(headers: getoptions2()),
                    );
                    setState(() {
                      isFav = false;
                    });
                    _showSnackBar("The book has been removed from your profile",
                        AnimatedSnackBarType.info);
                  } catch (e) {
                    print('Error removing from favorites: $e');
                    ScaffoldMessenger.of(context)
                        .showSnackBar(const SnackBar(content: Text("Failed")));
                  }
                }
                ;
                pref.setBool('isFav_${widget.detail_File.file!.id}', isFav);
              }),
        ],
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_outlined,
            color: dark_Brown,
            size: 35,
          ),
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const CorePage()),
            );
          },
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // صورة الكتاب
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 10, top: 28),
                child: Container(
                  height: 200,
                  width: 150,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(
                            "http://$ip_Zainab:8000${widget.detail_File.file!.cover}",
                          ),
                          fit: BoxFit.fill)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 7, top: 35),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      widget.detail_File.file!.title.toString(),
                      style: const TextStyle(
                          fontSize: 24.0, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10.0),
                    Text(
                      widget.detail_File.file!.author_name.toString(),
                      style: const TextStyle(
                        fontSize: 17.0,
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    Text(
                      widget.detail_File.file!.total_pages.toString(),
                      style: const TextStyle(fontSize: 18.0),
                    ),
                    const SizedBox(height: 10.0),
                    const SizedBox(height: 10.0),
                    RatingBarIndicator(
                      rating: avgRating,
                      unratedColor: Colors.amber.withAlpha(50),
                      itemCount: 5,
                      itemSize: 30.0,
                      itemBuilder: (context, _) => const Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                    ),
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
                  child: const Text(
                    'Info',
                    style: TextStyle(fontSize: 18),
                  ).tr(),
                ),
                Center(
                  widthFactor: 2,
                  child: Tab(
                    child: Text(
                      'Reviews'.tr(),
                      style: const TextStyle(fontSize: 18),
                    ),
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
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              bottom: 135, left: 25, right: 25),
                          child: Center(
                              child: Text(
                            widget.detail_File.file!.description.toString(),
                            style: const TextStyle(fontSize: 20),
                          )),
                        ),
                      ],
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 10, right: 10, top: 50),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                              padding: const EdgeInsets.only(
                                  bottom: 70, top: 230, left: 10),
                              child: SizedBox(
                                width: 130,
                                height: 50,
                                child: ElevatedButton(
                                  style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Colors.brown),
                                  ),
                                  onPressed: () async {
                                    int bookPonits =
                                        widget.detail_File.file!.points;
                                    if (bookPonits <= MyPoints) {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) => PDFviewer(
                                            detail_File: widget.detail_File,
                                          ),
                                        ),
                                      );

                                      bool added = await ReadLaterService()
                                          .addToReadLater(
                                        widget.detail_File.file!.id,
                                      );
                                      if (added) {
                                        _showSnackBar(
                                            "${"The book has been added to Reading shelf and".tr()} $bookPonits${"coffee beans were extracted".tr()}",
                                            AnimatedSnackBarType.success);
                                      } else {
                                        _showSnackBar(
                                          "Failed to add the book to Read Later shelf"
                                              .tr(),
                                          AnimatedSnackBarType.error,
                                        );
                                      }
                                    } else {
                                      _showSnackBar(
                                          "You don't have enough coffee beans to open this book.\nEarn more beans by reading more books and then try again"
                                              .tr(),
                                          AnimatedSnackBarType.error);
                                    }
                                  },
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
                              padding: const EdgeInsets.only(
                                top: 230,
                                right: 10,
                                bottom: 70,
                              ),
                              child: SizedBox(
                                width: 130,
                                height: 50,
                                child: ElevatedButton(
                                  style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            no_color),
                                    elevation: MaterialStateProperty.all(0),
                                    side: MaterialStateProperty.all(
                                        const BorderSide(color: Colors.brown)),
                                  ),
                                  onPressed: () async {
                                    bool added =
                                        await ReadLaterService().addToReadLater(
                                      widget.detail_File.file!.id,
                                    );
                                    print("bookid issss:" +
                                        widget.detail_File.file!.id.toString());
                                    if (added) {
                                      _showSnackBar(
                                        "The book has been added to Read Later shelf"
                                            .tr(),
                                        AnimatedSnackBarType.success,
                                      );
                                    } else {
                                      _showSnackBar(
                                        "Failed to add the book to Read Later shelf"
                                            .tr(),
                                        AnimatedSnackBarType.error,
                                      );
                                    }
                                  },
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
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 330, left: 40),
                      child: TextButton(
                        onPressed: () {
                          alert_report(context, TextEditingController());
                        },
                        child: const Text(
                          'Report',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.grey,
                          ),
                        ).tr(),
                      ),
                    ),
                  ],
                ),
                Stack(
                  children: [
                    FutureBuilder<List<ReviweModel>>(
                        future: CommentService().getAllComment(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            List<ReviweModel> comment =
                                snapshot.data as List<ReviweModel>;
                            return ListView.builder(
                              itemCount: comment.length,
                              itemBuilder: (context, int index) {
                                return (index + 1 != comment.length)
                                    ? Padding(
                                        padding: const EdgeInsets.only(
                                            left: 30, right: 30, top: 30),
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: offwhite,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Light_Brown,
                                                  offset: const Offset(0, 5),
                                                  blurRadius: 10,
                                                  // spreadRadius: 10,
                                                )
                                              ]),
                                          height: 140,
                                          width: 20,
                                          child: Padding(
                                            padding: const EdgeInsets.all(12.0),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Text(
                                                  comment[index].body,
                                                  style: const TextStyle(
                                                    fontSize: 20,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      )
                                    : AddComment(
                                        id: widget.detail_File.file!.id);
                              },
                            );
                          } else {
                            print('nooo');
                            return Center(
                                child: CircularProgressIndicator(
                                    color: dark_Brown));
                          }
                        }),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
