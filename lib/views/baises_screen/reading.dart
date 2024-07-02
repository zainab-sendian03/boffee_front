import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:userboffee/Core/Models/reading_model.dart';
import 'package:userboffee/Core/service/real/reading_service.dart';

class Reading extends StatelessWidget {
  Reading({super.key, required this.status});
  final String status;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder(
          future: ServeShelf().getAllBook(key.toString()),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<ReadingModel> status = snapshot.data as List<ReadingModel>;
              return GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 8,
                      crossAxisSpacing: 8),
                  itemCount: status.length,
                  itemBuilder: (context, index) {
                    return Container(
                        child: Text(status[index].status),
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: Image.network(
                          status[index].status,
                          errorBuilder: (context, error, stackTrace) {
                            return FlutterLogo(
                              size: 70,
                            );
                          },
                        ).image)));
                  });
            } else
              return Center(child: CircularProgressIndicator());
          }),
    );
  }
}
