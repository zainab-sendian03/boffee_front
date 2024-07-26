// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:flutter_application_test/core/Models/detial_model.dart';
import 'package:flutter_application_test/core/Models/note_model.dart';
import 'package:flutter_application_test/core/constants/linksapi.dart';
import 'package:flutter_application_test/core/provider/Note_provider.dart';
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
  final PdfViewerController _pdfViewerController = PdfViewerController();
  TextEditingController review_con = TextEditingController();
  TextEditingController notecontroller = TextEditingController();
  String? currentPdfFile;
  int indexPage = 0;
  double ratingValue = 0;
  final Crud crud = Crud();
  GlobalKey x = GlobalKey();
  String token = "4|fMNeGwvIFMZ9Dq0tKMsSk3MixWmWqQKHG17Z0CRl";
  @override
  void initState() {
    super.initState();

    _initializePDFView();
  }

  Future<void> _initializePDFView() async {
    await Future.delayed(const Duration(seconds: 2));
    if (currentPdfFile != widget.detailModel.file) {
      setState(() {
        indexPage = 0;
        currentPdfFile = widget.detailModel.file;
      });
    }
    await _loadLastPage();
    print("PDFView initialization complete");
  }

  Future<void> _loadLastPage() async {
    final prefs = await SharedPreferences.getInstance();
    int? lastPage = prefs.getInt('lastPage_${widget.detailModel.id}');
    int? lastFileId = prefs.getInt('lastFile_${widget.detailModel.id}');

    if (lastPage != null && widget.detailModel.id == lastFileId) {
      setState(() {
        indexPage = lastPage;
      });
      _pdfViewerController.jumpToPage(indexPage);
    } else {
      setState(() {
        indexPage = 0;
      });
    }
  }

  Future<void> _savePageIndex(int pageIndex) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('lastPage_${widget.detailModel.id}', pageIndex);
    await prefs.setInt(
        'lastFile_${widget.detailModel.id}', widget.detailModel.id);
  }

  add_Rate() async {
    try {
      Map<String, dynamic> body = {
        "book_id": widget.detailModel.id,
        "rate": ratingValue.toInt(),
      };
      print("Rating Book ID: ${widget.detailModel.id}");
      var response = await crud.postrequest(
        link_rating,
        body,
        headers: {
          "Accept": "application/json",
          "Authorization": "Bearer $token",
          "Content-Type": "application/json",
        },
      );
      print("rating is: $ratingValue");
      print("id is: ${widget.detailModel.id}");
      print("Response: $response");

      if (response is Map && response['success'] == true) {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => BookDetailsPage(
                  detailModel: widget.detailModel,
                )));
        print("success");
      } else {
        print("fail");
        print("Server response: $response");
      }
    } catch (e) {
      print("ERROR $e");
    }
  }

  add_Note() async {
    try {
      print("Note Book ID: ${widget.detailModel.id}");
      final bookId = widget.detailModel.id;
      final url = "$link_storeNote/$bookId";

      Map<String, dynamic> body = {
        "page_num": indexPage,
        "body": notecontroller.text,
        "book_id": widget.detailModel.id,
      };
      var response = await crud.postrequest(
        url,
        body,
        headers: {
          "Accept": "application/json",
          "Authorization": "Bearer 3|b1BZirQmIeGc6IUCWxW5LnTLvXY9VuyHmSJGTnFt",
          "Content-Type": "application/json",
        },
      );
      print("index page is: $indexPage");
      print("Response: $response");

      if (response is Map && response['success'] == true) {
        NoteModel newNote = NoteModel.fromJson(response['data']);
        NoteProvider.notesNotifier.value = [
          ...NoteProvider.notesNotifier.value,
          newNote
        ];
        Navigator.pop(context);
        print("success note");
      } else {
        print("fail");
        print("Server response: $response");
      }
    } catch (e) {
      print("ERROR $e");
    }
  }

  // update_progress() async {
  //   try {
  //     final bookId = widget.detailModel.id;
  //     final url = "$link_progress/$bookId";
  //     Map<String, dynamic> body = {
  //       "progress": indexPage,
  //     };
  //     var response = await crud.postrequest(
  //       url,
  //       body,
  //       headers: {
  //         "Accept": "application/json",
  //         "Authorization": "Bearer $token",
  //         "Content-Type": "application/json",
  //       },
  //     );
  //     print("index page is: $indexPage");
  //     print("Response: $response");

  //     if (response is Map && response['success'] == true) {
  //       Navigator.pop(context);
  //       print("success note");
  //     } else {
  //       print("fail");
  //       print("Server response: $response");
  //     }
  //   } catch (e) {
  //     print("ERROR $e");
  //   }
  // }

  AlertDialog _alertDialog(BuildContext context) {
    return AlertDialog(
      backgroundColor: const Color(0xFFFFF8F1),
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      content: SizedBox(
        width: MediaQuery.of(context).size.width * 0.65,
        height: MediaQuery.of(context).size.height * 0.2,
        child: TextFormField(
          showCursor: false,
          maxLines: 10,
          controller: notecontroller,
          decoration: const InputDecoration(
              border: InputBorder.none,
              hintText: "add your note....",
              hintStyle: TextStyle(color: Color(0XFFA5A5A5))),
        ),
      ),
      actions: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 50),
          child: ElevatedButton(
            onPressed: () => add_Note(),
            style: ElevatedButton.styleFrom(
                backgroundColor: medium_Brown,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25)),
                padding: const EdgeInsets.only(
                    left: 25, right: 25, top: 10, bottom: 10)),
            child: const Text("Add",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white,
                )),
          ),
        ),
      ],
    );
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
                        await add_Rate();
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
                    return _alertDialog(context);
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
                      enableDocumentLinkAnnotation: true,
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
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                                "Failed to load PDF: ${details.description}"),
                          ),
                        );
                      },
                    ),
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
                                        widget.detailModel.total_pages + 1) {
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
