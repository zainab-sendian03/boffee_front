import 'package:flutter/material.dart';
import 'package:userboffee/Core/Models/basic_model.dart';
import 'package:userboffee/Core/Models/post_model.dart';
import 'package:userboffee/Core/constants/colors.dart';
import 'package:userboffee/Core/service/real/qutes_ser.dart';

class myPostUi extends StatelessWidget {
  myPostUi({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: my_post_ser(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            ListofEverything<PostModel> result =
                snapshot.data as ListofEverything<PostModel>;
            print(result.toString());
            return ListView.builder(
                itemCount: result.listresult.length,
                itemBuilder: (context, index) {
                  return Padding(
                      padding:
                          const EdgeInsets.only(left: 20, right: 20, top: 20),
                      child: Card(
                          child: Container(
                        height: 100,
                        decoration: BoxDecoration(
                          color: biege,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.brown,
                              offset: Offset(0, 2),
                              blurRadius: 6,
                            )
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListTile(
                            title: Text(
                              result.listresult[index].user_name.toString(),
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            subtitle:
                                Text(result.listresult[index].body.toString()),
                            trailing: Icon(Icons.bookmark_add),
                          ),
                        ),
                      )));
                });
          } else {
            return Center(child: CircularProgressIndicator(color: dark_Brown));
          }
        });
  }
}
