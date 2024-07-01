import 'dart:io';

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:userboffee/Core/Models/post_model.dart';
import 'package:userboffee/Core/constants/colors.dart';
import 'package:userboffee/Core/constants/components.dart';
import 'package:userboffee/Core/service/real/qutes_ser.dart';
import 'package:userboffee/feature/getbooks/bloc/books_bloc.dart';
import 'package:userboffee/feature/getpost/bloc/getpost_bloc.dart';

class BookUi extends StatelessWidget {
  BookUi({super.key});
  TextEditingController body_controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return 
    
    BlocProvider(
      create: (context) => BooksBloc()..add(GettingBooks()),
      child: Builder(builder: (context) {
        return BlocBuilder<BooksBloc, BooksState>(
          builder: (context, state) {
            print("before if in get books");
            if (state is SuccessGetBook_state) {
              print("state is SuccessGetBook_state in ui");
              return Column(
                children: [
                 
             
                  BlocListener<BooksBloc, BooksState>(
                    listener: (context, state) {
                      // TODO: implement listener
                      if (state is SuccessGetBook_state) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text("Get Data"),
                          backgroundColor: Light_Brown,
                        ));
                      }
                    },
                    child: Expanded(
                      child: GridView.builder(
                        itemCount: state.Books.length,
                        itemBuilder: (context, int index) {
                          return Card(
                            child: Container(
                              
                              child: Column(children: [
                               Container(decoration: BoxDecoration(image: DecorationImage(image: AssetImage(state.Books[index].cover))),),
                              Text(state.Books[index].title),
                            // File(state.Books[index].file)
                              ],),
                               
                               
                               ),
                          );
                        }, gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2),
                      ),
                    ),
                  )
                ],
              );
            } else if (state is ErorrGetBooks_state) {
              print("Error in else if in ui books");
              return CircularProgressIndicator();
            } else {
               print("Excep in else in ui books ");
              return CircularProgressIndicator();
            }
          },
        );
      }),
    );
  }
}
