import 'package:flutter/material.dart';
import 'package:userboffee/Core/Models/basic_model.dart';
import 'package:userboffee/Core/constants/colors.dart';
import 'package:userboffee/Core/service/real/reviwe.dart';

class AddComment extends StatefulWidget {
  AddComment({super.key, required this.id});
  final int id;

  @override
  State<AddComment> createState() => _AddCommentState();
}

class _AddCommentState extends State<AddComment> {
  TextEditingController reviwecontroller = TextEditingController();

  bool isWriting = false;
  void upd(String text) {
    setState(() {
      isWriting = text.isNotEmpty;
    });
  }

  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 30, left: 20, right: 20,top:180 ),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          decoration: BoxDecoration(
            border: Border.all(color: const Color(0xFF5D3F2E)),
            borderRadius: BorderRadius.circular(30),
            color: Colors.white,
          ),
          child: Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: controller,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Add Comment',
                    hintStyle: TextStyle(color: Color(0xFFA5A5A5)),
                  ),
                  onChanged: upd,
                ),
              ),
              if (isWriting)
                IconButton(
                  color: dark_Brown,
                  icon: const Icon(Icons.send),
                  onPressed: () async {
                    // Add your send functionality here
                    var status = await ReiweService()
                        .PostAllReviwes(widget.id, controller.text);
                    if (status is successModel) {
                      print("yes");
                    } else {
                      print("no");
                    }
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }
}
