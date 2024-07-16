import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:userboffee/Core/constants/colors.dart';
import 'package:userboffee/Core/constants/linksapi.dart';
import 'package:userboffee/feature/levels/levels_bloc.dart';

class Levels_UI extends StatelessWidget {
  Levels_UI({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LevelsBloc()..add(success_level_event()),
      child: Builder(
                 
                  
                   
        builder: (context) { 
         

      //  context.read<LevelsBloc>().add(success_level_event(image: '', ratio: null));
        return BlocConsumer<LevelsBloc, LevelsState>(
          listener: (context, state) {
            if (state is Suceess_level_state) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("sucess"),backgroundColor: Colors.green,));
            } else {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("ooofffffff",),backgroundColor: Colors.red,));
            }
          },
          builder: (context, state) {

            if (state is Suceess_level_state) {
              print("success in ui level");
              return Column(
                children: [
                  Container(

                    width: 400,
                    height: 100,
                    color: lightColor,
                    child: Text("qwertyuiop[sdfghjkl;klhkmojoeo]"),
                  ),
                 
                           Container(
                            width: 400,
                            height: 500,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image:
                                    // http://$ip_local:8000/api
                                   
                                        NetworkImage("$linkservername"+state.image))),
                          )
                       
                  
                ],
              );
            } else if (state is Error_level_state) {
              print("something is error in level ui");
              return Center(child: Text("something is error"));
            } else {
              print("ooops exception in level ui");
              return Center(child: Text("ooops exception"));
            }
          },
        );
      }),
    );
  }
}

class $ {
}
