import 'package:flutter/material.dart';
import 'package:flutter_application_test/Core.dart';
import 'package:flutter_application_test/core/constants/colors.dart';
import 'package:flutter_application_test/core/constants/components.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';
import 'package:path/path.dart';

class PDFviewer extends StatefulWidget {
  final File file;
  const PDFviewer({super.key, required this.file});

  @override
  State<PDFviewer> createState() => _PDFviewerState();
}

class _PDFviewerState extends State<PDFviewer> {
  late PDFViewController controller;
  int pages = 100;
  int indexPage = 0;
  // ignore: unused_field
  late double _rating;
  // ignore: unused_field
  final double _initialRating = 0.0;
  GlobalKey x = GlobalKey();
  TextEditingController review_con = TextEditingController();
  TextEditingController notecontroller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadPageIndex().then((value) {
      setState(() {
        indexPage = value;
        // ignore: unnecessary_null_comparison
        if (controller != null) {
          controller.setPage(indexPage);
        }
        _savePageIndex(indexPage);
      });
    });
  }

  void _savePageIndex(int index) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('lastPageIndex', index);
  }

  Future<int> _loadPageIndex() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt('lastPageIndex') ?? 0;
  }

  @override
  Widget build(BuildContext context) {
    final name = basename(widget.file.path);
    double percent = ((100 * indexPage) / pages);
    String finalPercent = percent.toStringAsFixed(0);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: insidbook_color,
        title: Text(name),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_outlined,
            color: dark_Brown,
            size: 35,
          ),
          onPressed: () {
            Navigator.pop(context);
            dispose();
          },
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              alert(context, "add note", "", "Add");
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(no_color),
              elevation: MaterialStateProperty.all(0),
            ),
            child: Icon(
              Icons.add_comment_outlined,
              color: dark_Brown,
              size: 30,
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          PDFView(
            filePath: widget.file.path,
            onRender: (pages) => setState(() {
              this.pages = pages!;
            }),
            onViewCreated: (controller) => setState(() {
              this.controller = controller;
              controller.setPage(indexPage);
            }),
            onPageChanged: (indexPage, _) => setState(() {
              this.indexPage = indexPage!;
              _savePageIndex(indexPage);
            }),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 620),
            child: Container(
              width: 500,
              height: 170,
              decoration: BoxDecoration(color: insidbook_color),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 40, top: 15),
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              if (indexPage > 0) {
                                indexPage--;
                                controller.setPage(indexPage);
                                _savePageIndex(indexPage);
                              }
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: medium_Brown,
                            shape: const CircleBorder(),
                            padding: const EdgeInsets.only(
                              left: 10,
                              right: 10,
                              top: 15,
                              bottom: 15,
                            ),
                          ),
                          child: Icon(
                            Icons.arrow_back_ios,
                            color: white,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 40, top: 15),
                        child: ElevatedButton(
                          onPressed: () {
                            if (indexPage < pages) {
                              setState(() {
                                indexPage++;
                                controller.setPage(indexPage);
                                _savePageIndex(indexPage);
                              });
                            }
                            if (indexPage == pages) {
                              SnackBar snackBar = snakB(context);
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: medium_Brown,
                            shape: const CircleBorder(),
                            padding: const EdgeInsets.only(
                              left: 10,
                              right: 10,
                              top: 15,
                              bottom: 15,
                            ),
                          ),
                          child: Icon(
                            Icons.arrow_forward_ios,
                            color: white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Center(
                    child: SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                        trackHeight: 3.0,
                        thumbShape: const RoundSliderThumbShape(
                            enabledThumbRadius: 6.0),
                        overlayShape:
                            const RoundSliderOverlayShape(overlayRadius: 24.0),
                      ),
                      child: Slider(
                        autofocus: true,
                        activeColor: medium_Brown,
                        inactiveColor: white,
                        value: indexPage.toDouble(),
                        min: 0,
                        max: (pages - 1).toDouble(),
                        divisions: pages - 1,
                        onChanged: (double value) {
                          setState(() {
                            indexPage = value.toInt();
                            controller.setPage(indexPage);
                            //savePageIndex(indexPage);
                          });
                        },
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 40),
                        child: Text(
                          "Page $indexPage/$pages",
                          style: TextStyle(fontSize: 15, color: white),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 35),
                        child: Text(
                          "Completed $finalPercent%",
                          style: TextStyle(
                            fontSize: 15,
                            color: dark_Brown,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

SnackBar snakB(BuildContext context) {
  double ratingValue = 0;

  return SnackBar(
    duration: const Duration(days: 365),
    backgroundColor: const Color(0xFFFFF8F1),
    elevation: 20,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(30),
    ),
    content: StatefulBuilder(
      builder: (BuildContext context, StateSetter setState) {
        return SizedBox(
          height: MediaQuery.of(context).size.height * 0.40,
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.celebration,
                  color: medium_Brown,
                  size: 50,
                ),
                const SizedBox(height: 12),
                Text(
                  'Congratulations!',
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    color: medium_Brown,
                    fontSize: 25,
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  'You have read this book completely and obtained 100 gold coins.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'What is your rate for this book?',
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                    fontSize: 25,
                  ),
                ),
                const SizedBox(height: 10),
                RatingBar.builder(
                  initialRating: ratingValue,
                  minRating: 1,
                  unratedColor: Colors.amber.withAlpha(50),
                  itemCount: 5,
                  itemSize: 50.0,
                  itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                  itemBuilder: (context, _) => const Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (rating) {
                    setState(() {
                      ratingValue = rating;
                    });
                  },
                  updateOnDrag: true,
                ),
                const SizedBox(height: 4),
                Text(
                  'Your rating: $ratingValue',
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if (ratingValue > 0) {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) => const CorePage()),
                        );
                        ScaffoldMessenger.of(context).hideCurrentSnackBar();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF94745B),
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: const Text(
                      'Submit',
                      style: TextStyle(color: Colors.white, fontSize: 23),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    ),
  );
}
