import 'package:flutter/material.dart';
import 'package:flutter_application_test/core/constants/colors.dart';

class AddComment extends StatefulWidget {
  const AddComment({super.key});

  @override
  State<AddComment> createState() => _AddCommentState();
}

class _AddCommentState extends State<AddComment> {
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
      padding: const EdgeInsets.only(bottom: 30, left: 20, right: 20),
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
                  onPressed: () {
                    // Add your send functionality here
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }
}
