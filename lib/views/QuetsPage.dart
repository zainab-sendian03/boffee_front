import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:userboffee/Core/Models/post_model.dart';
import 'package:userboffee/Core/components/colors.dart';
import 'package:userboffee/Core/components/coponents.dart';
import 'package:userboffee/Core/service/real/qutes_ser.dart';
import 'package:userboffee/feature/getpost/bloc/getpost_bloc.dart';

class QuetsPage extends StatelessWidget {
  QuetsPage({super.key});
  TextEditingController body_controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetpostBloc()..add(GettingPostEvent()),
      child: Builder(builder: (context) {
        return BlocBuilder<GetpostBloc, GetpostState>(
          builder: (context, state) {
            if (state is SuccessGetPost_state) {
              return Column(
                children: [
                  InkWell(
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                backgroundColor: biege,
                                content: Container(
                                  height: 290,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      // color: biege,
                                      ),
                                  child: Column(
                                    children: [
                                      SizedBox(
                                          height: 200,
                                          width: 255,
                                          child: Form(
                                            child: TextFormField(
                                              controller: body_controller,
                                                maxLines: 5,
                                                decoration: InputDecoration(
                                                    border: InputBorder.none,
                                                    hintMaxLines: 3,
                                                    hintText:
                                                        "What is your mind ?")),
                                          )),
                                      Align(
                                        alignment: Alignment(1, -0.5),
                                        child: InkWell(
                                            onTap: () async {
                                              dynamic send_postreq =
                                                  await createPostser(PostModel(
                                                      body:
                                                          body_controller.text,
                                                      user_name: "maryam"));
                                            },
                                            child: Container(
                                              width: 50,
                                              height: 40,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(3),
                                                  color: medium_Brown),
                                            )),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            });
                      },
                      child: SearchContainer()),
                  BlocListener<GetpostBloc, GetpostState>(
                    listener: (context, state) {
                      // TODO: implement listener
                      if (state is SuccessGetPost_state) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text("Get Data"),
                          backgroundColor: Light_Brown,
                        ));
                      }
                    },
                    child: Expanded(
                      child: ListView.builder(
                        itemCount: state.posts.length,
                        itemBuilder: (context, int index) {
                          return ListTile(
                              contentPadding: EdgeInsets.all(17),
                              isThreeLine: true,
                              subtitle: Text(state.posts[index].body),
                              title: Text(state.posts[index].user_name),
                              trailing: SizedBox(
                                height: 20,
                                width: 60,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Icon(Icons.share_rounded),
                                    Icon(Icons.favorite_border),
                                  ],
                                ),
                              ));
                        },
                      ),
                    ),
                  )
                ],
              );
            } else if (state is ErorrGetpost_state) {
              print("Error in else if");
              return CircularProgressIndicator();
            } else {
               print("Excep in else if");
              return CircularProgressIndicator();
            }
          },
        );
      }),
    );
  }
}
