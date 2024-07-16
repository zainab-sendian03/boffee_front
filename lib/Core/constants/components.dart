// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:userboffee/Core/Models/post_model.dart';

import 'package:userboffee/Core/constants/colors.dart';
import 'package:userboffee/Core/constants/functions/validInput.dart';
import 'package:userboffee/Core/service/real/qutes_ser.dart';
import 'package:userboffee/feature/addpost_bloc/addPost/addpost_bloc.dart';
import 'package:userboffee/feature/getpost/bloc/getpost_bloc.dart';

TextEditingController body_controller = TextEditingController();

class ColorContainer extends StatelessWidget {
  const ColorContainer({super.key, required this.color});
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(7),
      width: MediaQuery.of(context).size.width*0.1,
      height: 40,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
    );
  }
}

class LanguageContainer extends StatelessWidget {
  const LanguageContainer({
    Key? key,
    required this.text,
  }) : super(key: key);
  final String text;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 30,
      decoration: BoxDecoration(
          color: Light_Brown, borderRadius: BorderRadius.circular(5)),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(fontWeight: FontWeight.w800, fontSize: 17),
      ).tr(),
    );
  }
}

class CircleIndecaterSwitch extends StatelessWidget {
  const CircleIndecaterSwitch({super.key});

  @override
  Widget build(BuildContext context) {
    try {
      return CircularProgressIndicator();
    } catch (e) {
      //print(e.toString());
      return Lottie.network(
          "https://lottie.host/5f19fea0-3f26-40dd-8516-cdc04ee6ee90/7vO10mg8BD.json");
    }
  }
}

// class QutesContainer extends StatelessWidget {
//   QutesContainer({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: ListTile(
//           contentPadding: EdgeInsets.all(17),
//           isThreeLine: true,
//           subtitle: Text("life it is not bad  "),
//           title: Text("maryam"),
//           trailing: SizedBox(
//             height: 20,
//             width: 60,
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Icon(Icons.share_rounded),
//                 Icon(Icons.favorite_border),
//               ],
//             ),
//           )),
//     );
//   }
// }

class SearchContainer extends StatelessWidget {
  const SearchContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0xFF5D3F2E)),
          borderRadius: BorderRadius.circular(30),
          color: Colors.white,
        ),
        child: TextFormField(
          onTap: () {
            BuildContext? dialogContext;
            showDialog(
                context: context,
                builder: (context) {
                  return BlocProvider(
                    create: (context) => AddpostBloc(),
                    child: Builder(builder: (context) {
                      return AlertDialog(
                        backgroundColor: biege,
                        content: BlocListener<AddpostBloc, AddpostState>(
                          listener: (context, state) {
                          if (state is Succuess_createpostState) {
                            Navigator.pop(context);
                            context.read<GetpostBloc>().add(GettingPostEvent());
                          }
                          },
                          child: Container(
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
                                                  "write your prefered quote\n#book_name"
                                                      .tr())),
                                    )),
                                Align(
                                  alignment: Alignment(1, -0.5),
                                  // child: BlocListener<GetpostBloc, GetpostState>(
                                  //   listener: (context, state) {
                                  //   if(state is  SuccessGetPost_state){
                                  //    if(state is Succuess_createpostState){state.posts.length++;}
                                  //   }
                                  // },
                                  child: InkWell(
                                      onTap: () {
                                        context.read<AddpostBloc>().add(
                                              createpostEvent(
                                                post: PostModel(
                                                    body: body_controller.text,
                                                    user_name: "maryam"),
                                              ),
                                            );

                                        //  Navigator.pop(dialogContext);
                                        // Navigator.pop(context);
                                        // ScaffoldMessenger.of(context).hideCurrentSnackBar();
                                      },
                                      child: Container(
                                        width: 50,
                                        height: 28,
                                        decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                              colors: [
                                                Color.fromARGB(
                                                    255, 227, 222, 222),
                                                Color.fromARGB(
                                                    255, 182, 159, 152),
                                                Color.fromARGB(
                                                    255, 164, 138, 129),
                                                medium_Brown
                                              ],
                                              begin: Alignment.bottomLeft,
                                              end: Alignment.topRight),
                                          borderRadius:
                                              BorderRadius.circular(7),
                                        ),
                                        child: Text(
                                          "Post".tr(),
                                          style: TextStyle(
                                            color: white,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      )),
                                  //  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
                  );
                });
          },
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: 'write your prefered quote'.tr(),
            hintStyle: const TextStyle(color: Color(0xFFA5A5A5)),
            prefixIcon: IconButton(
                icon: const Icon(
                  Icons.search,
                  color: Color(0xFF5D3F2E),
                ),
                onPressed: () {}),
          ),
        ),
      ),
    );
  }
}

Future<dynamic> alert(
    BuildContext context, String cont, String title, String buttTxt) {
  return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        String contentText = cont;
        return AlertDialog(
          backgroundColor: Colors.white60,
          elevation: 0,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          icon: const Icon(
            Icons.error,
            size: 50,
            color: Color(0xFF94745B),
          ),
          title: Column(
            children: [
              Center(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 30,
                    color: Color(0xFF5D3F2E),
                  ),
                ),
              ),
              const Divider(
                color: Color(0xFF94745B),
                thickness: 2,
              )
            ],
          ),
          content: Text(
            contentText,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w400,
            ),
          ),
          actions: <Widget>[
            Center(
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                    backgroundColor: medium_Brown,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25)),
                    padding: const EdgeInsets.only(
                        left: 40, right: 40, top: 15, bottom: 15)),
                child: Text(buttTxt,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                    )),
              ),
            ),
          ],
        );
      });
}

class CustomTextFormField extends StatefulWidget {
  final String hintText;
  final TextEditingController controller;
  final int min;
  final int max;
  final bool visPassword;
  final bool showVisPasswordToggle;
  final void Function()? onTapIcon;

  const CustomTextFormField({
    Key? key,
    required this.hintText,
    required this.controller,
    required this.min,
    required this.max,
    this.visPassword = true,
    this.showVisPasswordToggle = false,
    this.onTapIcon,
  }) : super(key: key);

  @override
  _CustomTextFormFieldState createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  late bool _visPassword;
  late TextEditingController conf_pass;

  @override
  void initState() {
    super.initState();
    _visPassword = widget.visPassword;
    conf_pass = TextEditingController();
  }

  void _handleTapIcon() {
    if (widget.onTapIcon != null) {
      widget.onTapIcon!();
    }

    setState(() {
      _visPassword = !_visPassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      validator: (valid) => validInput(valid!, widget.max, widget.min),
      obscureText: _visPassword,
      decoration: InputDecoration(
        errorMaxLines: 2,
        suffixIcon: widget.showVisPasswordToggle
            ? IconButton(
                icon: Icon(
                  _visPassword ? Icons.visibility_off : Icons.visibility,
                  color: medium_Brown,
                  size: 21,
                ),
                onPressed: _handleTapIcon,
              )
            : null,
        hintText: widget.hintText,
        contentPadding:
            const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Color(0xFFDBC3AB), width: 2.0),
          borderRadius: BorderRadius.circular(20),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }
}
