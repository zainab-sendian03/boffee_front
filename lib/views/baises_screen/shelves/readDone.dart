import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:userboffee/Core/Models/d_withFile.dart';
import 'package:userboffee/Core/Models/reading_model.dart';
import 'package:userboffee/Core/constants/colors.dart';
import 'package:userboffee/Core/constants/linksapi.dart';
import 'package:userboffee/Core/service/real/reading_service.dart';
import 'package:userboffee/views/PDFviewer.dart';

class ReadingDone extends StatefulWidget {
  const ReadingDone({super.key, required this.status});
  final String status;

  @override
  State<ReadingDone> createState() => _ReadingDoneState();
}

class _ReadingDoneState extends State<ReadingDone> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Reading Done"),
        backgroundColor: Light_Brown,
      ),
      body: FutureBuilder(
        future: ServeShelf().getAllBook(widget.status),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(color: dark_Brown),
            );
          } else if (snapshot.hasData) {
            List<ReadingModel> books = snapshot.data as List<ReadingModel>;
            if (books.isEmpty) {
              return const Center(
                child: Text("No books found in this status"),
              );
            }
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, mainAxisSpacing: 8, crossAxisSpacing: 2),
              itemCount: books.length,
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.only(top: 8, left: 8, right: 8),
                child: Stack(
                  children: [
                    Container(
                      width: 200,
                      height: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
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
                      child: Padding(
                        padding: const EdgeInsets.only(right: 5),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 120),
                                child: Text(
                                  books[index].title.toString(),
                                  style: TextStyle(
                                      fontSize: 14, color: dark_Brown),
                                  overflow: TextOverflow.ellipsis,
                                ).tr(),
                              ),
                            ]),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 6, left: 10, right: 10),
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => PDFviewer(
                                detail_File: Detail_withFile(),
                              ),
                            ),
                          );
                        },
                        child: Container(
                          height: 130,
                          width: 170,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: NetworkImage(
                                  "$linkservername${books[index].cover}",
                                ),
                                fit: BoxFit.fill),
                            borderRadius: BorderRadius.circular(10),
                            color: Light_Brown,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text("Error::::: ${snapshot.error}"),
            );
          } else {
            return const Center(
              child: Text("No books found."),
            );
          }
        },
      ),
    );
  }
}
