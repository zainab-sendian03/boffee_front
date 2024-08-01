import 'package:flutter/material.dart';
import 'package:userboffee/Core/Models/basic_model.dart';
import 'package:userboffee/Core/Models/post_model.dart';
import 'package:userboffee/Core/service/real/qutes_ser.dart';

class myPostUi extends StatelessWidget {
   myPostUi({super.key});

  @override
  Widget build(BuildContext context) {
    return 
       FutureBuilder(
          future: my_post_ser(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              ListofEverything<PostModel> result =
                  snapshot.data as ListofEverything<PostModel>;
              print(result.toString());
              return ListView.builder(
                  itemCount: result.listresult.length,
                  itemBuilder: (context, index) {
                    return Container(
                      height: 170,
                      child: ListTile(
                        title:
                            Text(result.listresult[index].user_name.toString()),
                        subtitle: Text(result.listresult[index].body.toString()),
                        trailing: Icon(Icons.bookmark_add),
                      ),
                    );
                  });
            } else {
              return Center(child: CircularProgressIndicator());
            }
          });
    
  }
}
