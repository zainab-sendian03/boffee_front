import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:userboffee/Core/config/options.dart';
import 'package:userboffee/Core/constants/colors.dart';
import 'package:userboffee/Core/service/real/qutes_ser.dart';
import 'package:userboffee/feature/getfavpost/bloc/favposts_bloc.dart';

class myfavPostUI extends StatelessWidget {
  myfavPostUI({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FavpostsBloc()..add(ShowFavPost_Event()),
      child: BlocConsumer<FavpostsBloc, FavpostsState>(
        listener: (context, state) {
          // TODO: implement listener
          if (state is SuccesGetFavpostState) {
            // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            //   content: Text("sucess"),
            //   backgroundColor: const Color.fromARGB(255, 140, 220, 181),
            // ));
            print("suucsess in fav qoutes");
          } else {
            // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            //     content: Text("Error"),
            //     backgroundColor: const Color.fromARGB(255, 219, 123, 116)));
            print("Error in fav qoutes");
          }
        },
        builder: (context, state) {
          if (state is SuccesGetFavpostState) {
            return ListView.builder(
              itemCount: state.list.length,
              itemBuilder: (context, int index) {
                return Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
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
                              state.list[index].user_name.toString(),
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text(state.list[index].body),
                            trailing: IconButton(
                                onPressed: () {
                                  print("Delet post which id is :" +
                                      "${getIt<SharedPreferences>().getInt("post_id")!}");
                                  remove_post_from_fav(
                                      getIt<SharedPreferences>()
                                          .getInt("post_id")!);
                                },
                                icon: Icon(Icons.delete)),
                          ),
                        )),
                  ),
                );
              },
            );
          } else if (state is ErrorGetFavpostState) {
            return Center(child: Text("Try again , it is Error"));
          } else {
            return Center(child: Text("Try again , it is Exception"));
          }
        },
      ),
    );
  }
}
