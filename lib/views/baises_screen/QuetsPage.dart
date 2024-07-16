import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:userboffee/Core/Models/basic_model.dart';
import 'package:userboffee/Core/Models/error.dart';
import 'package:userboffee/Core/Models/post_model.dart';
import 'package:userboffee/Core/config/options.dart';
import 'package:userboffee/Core/constants/colors.dart';
import 'package:userboffee/Core/constants/components.dart';
import 'package:userboffee/Core/service/real/qutes_ser.dart';
import 'package:userboffee/feature/getpost/bloc/getpost_bloc.dart';

//num counter=0;
class QuetsPage extends StatelessWidget {
  QuetsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      context.read<GetpostBloc>().add(GettingPostEvent());
      return BlocConsumer<GetpostBloc, GetpostState>(
        buildWhen: (previous, current) => current != previous,
        listener: (context, state) {
          if (state is SuccessGetPost_state) {
            // state.posts.length;
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text("Get Data"),
              backgroundColor: Light_Brown,
            ));
          }
        },
        builder: (context, state) {
          //   print("before if");
          if (state is SuccessGetPost_state) {
            print("-----------------");
            return Column(
              children: [
                SearchContainer(),
                Expanded(
                  child: ListView.builder(
                    itemCount: state.posts.length,
                    itemBuilder: (context, int index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          //  height: 200,
                          width: double.infinity,
                          //  height:100 ,
                          child: Column(
                            children: [
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.09,
                                child: Row(
                                  children: [
                                    Text(
                                      state.posts[index].user_name,
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                              ),
                              Row(
                                children: [
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.7,
                                    child: Text(
                                      state.posts[index].body,
                                      //  maxLines: 100,
                                      // overflow: TextOverflow.ellipsis,
                                      overflow: TextOverflow.clip,
                                      softWrap: true,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Padding(
                                        padding: const EdgeInsets.only(
                                            right: 2, left: 2),
                                        child: IconButton(
                                          onPressed: () async {
                                            final urlPreview =
                                                "https://www.youtube.com/watch?v=CNUBhb_cM6E";
                                            await Share.share(
                                                "Boofee App\nحمل تطبيق بوفي الان وشاركنا اقتباس أحببته" +
                                                    "\n"
                                                        "( " +
                                                    state.posts[index].body +
                                                    ")" +
                                                    "\n$urlPreview");
                                          },
                                          icon: Icon(
                                            Icons.share_rounded,
                                            size: 18,
                                          ),
                                        )),
                                    IconButton(
                                      onPressed: () {
                                        // Future<ResultModel> res =
                                        //     add_post_tofav_ser(
                                        //         getIt<SharedPreferences>()
                                        //             .getInt("post_id")!);
                                        // print("success");
                                        // if (res is ErroeModel) {
                                        //   print("error in ui Like");
                                          
                                        // } 
                                        // else if(res is ExceptionModel){
                                        //   print("exception in ui Like");
                                        // }
                                        // else {
                                        //   print("success in ui like");
                                        // }
                                      },
                                      icon: Icon(
                                        Icons.favorite_border,
                                        size: 18,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Divider(
                                color: Color.fromARGB(255, 209, 209, 209),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                )
              ],
            );
          } else if (state is ErorrGetpost_state) {
            //  print("Error in else if");
            return Center(child: CircularProgressIndicator());
          } else {
            //   print("Excep in else ");
            return Center(child: CircularProgressIndicator());
          }
        },
      );
    });
  }
}
