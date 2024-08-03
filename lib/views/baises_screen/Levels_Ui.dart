import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:userboffee/Core/constants/linksapi.dart';
import 'package:userboffee/Core/provider/Theme_provider.dart';
import 'package:userboffee/feature/levels/levels_bloc.dart';

class Levels_UI extends StatelessWidget {
  const Levels_UI({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LevelsBloc()..add(success_level_event()),
      child: Builder(builder: (context) {
        //  context.read<LevelsBloc>().add(success_level_event(image: '', ratio: null));
        return BlocConsumer<LevelsBloc, LevelsState>(
          listener: (context, state) {
            if (state is Suceess_level_state) {
              print("level sucess");
              //  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("sucess"),backgroundColor: Colors.green,));
            } else {
              print("level failed");
              // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("ooofffffff",),backgroundColor: Colors.red,));
            }
          },
          builder: (context, state) {
            if (state is Suceess_level_state) {
              print("success in ui level");
              return Column(
                children: [
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: 400,
                        height: 90,
                        decoration: BoxDecoration(
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.grey,
                                offset: Offset(0.0, 1.0), //(x,y)
                                blurRadius: 6.0,
                              ),
                            ],
                            color: context.watch<ThemeProvider>().newcolor,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10))),
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: const Text(
                                  "you will level up as you read more and more books\n then your coffee beans will increase")
                              .tr(),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: 400,
                    height: 500,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image:
                                // http://$ip_local:8000/api

                                NetworkImage("$linkservername${state.image}"))),
                  )
                ],
              );
            } else if (state is Error_level_state) {
              print("something is error in level ui");
              return const Center(child: Text("something is error"));
            } else {
              print("ooops exception in level ui");
              return const Center(child: Text("ooops exception"));
            }
          },
        );
      }),
    );
  }
}
