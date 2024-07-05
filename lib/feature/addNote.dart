import 'package:flutter/material.dart';

import '../core/constants/colors.dart';

class AddNote extends StatefulWidget {
  const AddNote({super.key});

  @override
  State<AddNote> createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  TextEditingController notecontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: const Color(0xFFFFF8F1),
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      content: SizedBox(
        width: MediaQuery.of(context).size.width * 0.65,
        height: MediaQuery.of(context).size.height * 0.2,
        child: TextFormField(
          showCursor: false,
          maxLines: 10,
          controller: notecontroller,
          decoration: const InputDecoration(
              border: InputBorder.none,
              hintText: "add your note....",
              hintStyle: TextStyle(color: Color(0XFFA5A5A5))),
        ),
      ),
      actions: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 50),
          child: ElevatedButton(
            onPressed: () => Navigator.pop(context),
            style: ElevatedButton.styleFrom(
                backgroundColor: medium_Brown,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25)),
                padding: const EdgeInsets.only(
                    left: 25, right: 25, top: 10, bottom: 10)),
            child: const Text("Add",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white,
                )),
          ),
        ),
      ],
    );
  }
}
