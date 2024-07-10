// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_application_test/core/Models/detial_model.dart';
import 'package:flutter_application_test/core/constants/components.dart';
import 'package:flutter_application_test/core/constants/linksapi.dart';
import 'package:flutter_application_test/core/service/real/crud.dart';
import 'package:flutter_application_test/views/Details.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_application_test/core/constants/colors.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PDFviewer extends StatefulWidget {
  const PDFviewer({
    Key? key,
    required this.detailModel,
  }) : super(key: key);
  final DetailModel detailModel;

  @override
  State<PDFviewer> createState() => _PDFviewerState();
}

class _PDFviewerState extends State<PDFviewer> {
  //PDFViewController? pdfcontroller;
  final PdfViewerController _pdfViewerController = PdfViewerController();

  int indexPage = 0;
  double ratingValue = 0;
  // ignore: unused_field
  final double _initialRating = 0.0;
  GlobalKey x = GlobalKey();
  TextEditingController review_con = TextEditingController();
  TextEditingController notecontroller = TextEditingController();

  void initState() {
    super.initState();
    _initializePDFView();
    _loadLastPage();
  }

  Future<void> _initializePDFView() async {
    await Future.delayed(const Duration(seconds: 2));
    print("PDFView initialization complete");
  }

  Future<void> _loadLastPage() async {
    final prefs = await SharedPreferences.getInstance();
    int? lastPage = prefs.getInt('lastPage');
    setState(() {
      if (lastPage != null) {
        indexPage = lastPage;
        _pdfViewerController.jumpToPage(indexPage);
      } else {
        indexPage = 0;
        _pdfViewerController.jumpToPage(indexPage);
      }
    });
  }

  Future<void> _savePageIndex(int pageIndex) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('lastPage', pageIndex);
  }

  final Crud crud = Crud();
  Rate() async {
    try {
      String bookId = widget.detailModel.id.toString();
      String rateValue = ratingValue.toString();

      var response = await crud.postrequest(linkrating, {
        "book_id": bookId,
        "rate": rateValue,
      });
      print("rating is:$ratingValue");
      print("id is:${widget.detailModel.id}");

      if (response is Map && response['success'] == true) {
        Navigator.of(context).push(
          MaterialPageRoute(
              builder: (context) => BookDetailsPage(
                    detailModel: widget.detailModel,
                  )),
        );
      } else {
        print("fail");
      }
    } catch (e) {
      print("ERROR $e");
    }
  }

  SnackBar snakB(BuildContext context) {
    return SnackBar(
      dismissDirection: DismissDirection.up,
      duration: const Duration(days: 365),
      backgroundColor: const Color(0xFFFFF8F1),
      elevation: 10,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      content: StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return SizedBox(
            height: MediaQuery.of(context).size.height * 0.45,
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
                      onPressed: () async {
                        await Rate();
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

  @override
  Widget build(BuildContext context) {
    double percent = ((100 * indexPage) / widget.detailModel.total_pages);
    String finalPercent = percent.toStringAsFixed(0);

    return Scaffold(
        appBar: AppBar(
          backgroundColor: insidbook_color,
          title: Text(widget.detailModel.title),
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_outlined,
              color: dark_Brown,
              size: 35,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AddNote();
                  },
                );
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
        body: FutureBuilder(
            future: _initializePDFView(),
            builder: (context, snapshot) {
              print("Initialization done");
              final pdfFilePath = widget.detailModel.file;
              final pdfUrl = "http://10.0.2.2:8000$pdfFilePath";
              print("Loading PDF from URL: $pdfUrl");
              return Stack(
                children: [
                  SizedBox(
                    height: 620,
                    child: SfPdfViewer.network(
                      pdfUrl,
                      controller: _pdfViewerController,
                      canShowScrollHead: false,
                      pageSpacing: 2,
                      onTextSelectionChanged:
                          (PdfTextSelectionChangedDetails details) {
                        if (details.selectedText != null) {
                          print(details.selectedText);
                        }
                      },
                      onPageChanged: (details) {
                        _savePageIndex(details.newPageNumber);
                        print('$indexPage');
                      },
                      initialScrollOffset: const Offset(10, 10),
                      onDocumentLoadFailed: (details) {
                        print("Failed to load PDF: ${details.description}");
                      },
                    ),
                  ),

                  // SfPdfViewer.asset(
                  //   pdffile,
                  //   canShowScrollHead: false,
                  //   pageSpacing: 2,
                  //   onTextSelectionChanged:
                  //       (PdfTextSelectionChangedDetails details) {
                  //     if (details.selectedText != null) {
                  //       print(details.selectedText);
                  //     }
                  //   },
                  //   initialScrollOffset: Offset(10, 10),
                  // ),
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
                                padding:
                                    const EdgeInsets.only(left: 40, top: 15),
                                child: ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      if (indexPage > 0) {
                                        indexPage--;
                                        _pdfViewerController
                                            .jumpToPage(indexPage);
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
                                padding:
                                    const EdgeInsets.only(right: 40, top: 15),
                                child: ElevatedButton(
                                  onPressed: () {
                                    if (indexPage <
                                        widget.detailModel.total_pages) {
                                      setState(() {
                                        indexPage++;
                                        _pdfViewerController
                                            .jumpToPage(indexPage);
                                        _savePageIndex(indexPage);
                                        print("$indexPage");
                                      });
                                    }
                                    if (indexPage ==
                                        widget.detailModel.total_pages) {
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
                                overlayShape: const RoundSliderOverlayShape(
                                    overlayRadius: 24.0),
                              ),
                              child: Slider(
                                autofocus: true,
                                activeColor: medium_Brown,
                                inactiveColor: white,
                                value: indexPage.toDouble().clamp(
                                    1.0,
                                    (widget.detailModel.total_pages)
                                        .toDouble()),
                                min: 0,
                                max:
                                    (widget.detailModel.total_pages).toDouble(),
                                divisions:
                                    (widget.detailModel.total_pages) as int,
                                onChanged: (double value) {
                                  setState(() {
                                    indexPage = value.toInt();
                                    _pdfViewerController.jumpToPage(indexPage);
                                    _savePageIndex(indexPage);
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
                                  "Page $indexPage/${widget.detailModel.total_pages}",
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
              );
            }));
  }
}
