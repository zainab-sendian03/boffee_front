import 'package:flutter/material.dart';
import 'package:flutter_application_test/core/constants/colors.dart';
import 'package:flutter_application_test/core/constants/components.dart';
import 'package:flutter_application_test/feature/getpost/bloc/getpost_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class QuetsPage extends StatelessWidget {
  const QuetsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetpostBloc()..add(GettingPostEvent()),
      child: Builder(builder: (context) {
        return BlocBuilder<GetpostBloc, GetpostState>(
          builder: (context, state) {
            //   print("before if");
            if (state is SuccessGetPost_state) {
              return Column(
                children: [
                  const SearchContainer(),
                  BlocListener<GetpostBloc, GetpostState>(
                    listener: (context, state) {
                      // TODO: implement listener
                      if (state is SuccessGetPost_state) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: const Text("Get Data"),
                          backgroundColor: Light_Brown,
                        ));
                      }
                    },
                    child: Expanded(
                      child: ListView.builder(
                        itemCount: state.posts.length,
                        itemBuilder: (context, int index) {
                          // return ListTile(
                          //     contentPadding: EdgeInsets.all(17),
                          //     isThreeLine: true,
                          //     subtitle: Text(state.posts[index].body),
                          //     title: Text(state.posts[index].user_name),
                          //     trailing: SizedBox(
                          //       height: 20,
                          //       width: 60,
                          //       child: Row(
                          //         mainAxisAlignment:
                          //             MainAxisAlignment.spaceBetween,
                          //         children: [
                          //           Icon(Icons.share_rounded),
                          //           Icon(Icons.favorite_border),
                          //         ],
                          //       ),
                          //     ));
                          ////////////////===================
                          ///

                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                              //  height: 200,
                              width: double.infinity,
                              //  height:100 ,
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 20,
                                    child: Row(
                                      children: [
                                        Text(
                                          state.posts[index].user_name,
                                          style: const TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.7,
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
                                                right: 6, left: 6),
                                            child: IconButton(
                                              onPressed: () {},
                                              icon: const Icon(
                                                  Icons.share_rounded),
                                            )),
                                        IconButton(
                                          onPressed: () {},
                                          icon:
                                              const Icon(Icons.favorite_border),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const Divider(
                                    color: Color.fromARGB(255, 209, 209, 209),
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  )
                ],
              );
            } else if (state is ErorrGetpost_state) {
              //  print("Error in else if");
              return const CircularProgressIndicator();
            } else {
              //   print("Excep in else ");
              return const CircularProgressIndicator();
            }
          },
        );
      }),
    );
  }
}
