// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_application_test/core/Models/note_model.dart';
import 'package:flutter_application_test/core/constants/colors.dart';
import 'package:flutter_application_test/core/constants/components.dart';
import 'package:flutter_application_test/core/constants/linksapi.dart';
import 'package:flutter_application_test/core/provider/Note_provider.dart';
import 'package:flutter_application_test/core/service/real/crud.dart';

class Profile extends StatefulWidget {
  const Profile({
    Key? key,
  }) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  NoteModel? noteModel;

  TextEditingController notecontroller = TextEditingController();
  Future<Map<String, dynamic>>? _user;
  final Crud crud = Crud();
  int indexPage = 0;
  String token = "4|fMNeGwvIFMZ9Dq0tKMsSk3MixWmWqQKHG17Z0CRl";

  @override
  void initState() {
    _tabController = TabController(length: 4, vsync: this);
    super.initState();
    _user = getUserDetails();
  }

  AlertDialog _alertDialog(BuildContext context, {NoteModel? noteToEdit}) {
    notecontroller.text = noteToEdit?.body ?? '';
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
            onPressed: () async {
              await Edit_Note(noteToEdit!);
            },
            style: ElevatedButton.styleFrom(
                backgroundColor: medium_Brown,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25)),
                padding: const EdgeInsets.only(
                    left: 25, right: 25, top: 10, bottom: 10)),
            child: Text(noteToEdit == null ? "Add" : "Edit",
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.white,
                )),
          ),
        ),
      ],
    );
  }

  Edit_Note(NoteModel note) async {
    try {
      final url = "$link_EditNote/${note.id}";

      Map<String, dynamic> body = {
        "page_num": note.pageNum,
        "body": notecontroller.text,
        "book_id": note.bookId,
      };
      var response = await crud.postrequest(
        url,
        body,
        headers: {
          "Accept": "application/json",
          "Authorization": "Bearer $token",
          "Content-Type": "application/json",
        },
      );

      print("index page is: ${note.pageNum}");
      print("Response: $response");

      if (response is Map && response['success'] == true) {
        NoteModel updatedNote = NoteModel.fromJson(response['data']);
        NoteProvider.notesNotifier.value = [
          ...NoteProvider.notesNotifier.value.where((n) => n.id != note.id),
          updatedNote
        ];
        Navigator.pop(context);
        print("success note");
      } else {
        print("fail");
        print("Server response: $response");
      }
    } catch (e) {
      print("ERROR $e");
    }
  }

  final Crud _crud = Crud();

  Future<Map<String, dynamic>> getNote() async {
    try {
      var response = await _crud.getrequest(link_showNote, headers: {
        "Authorization": "Bearer $token",
      });

      print("Server response: $response");

      if (response is Map<String, dynamic> && response['success'] == true) {
        return response;
      } else {
        return {
          'success': false,
          'message': 'Failed to fetch Notes',
        };
      }
    } catch (e) {
      print(e);
      return {
        'success': false,
        'message': 'An error occurred',
      };
    }
  }

  Future<Map<String, dynamic>> getUserDetails() async {
    try {
      var response = await http.get(
        Uri.parse(link_userDetails),
        headers: {
          "Authorization": "Bearer $token",
        },
      );
      print("Server response: ${response.body}");

      if (response.statusCode == 200) {
        var responseBody = json.decode(response.body);
        if (responseBody is Map<String, dynamic> &&
            responseBody['success'] == true) {
          return responseBody;
        } else {
          return {
            'success': false,
            'message': 'Failed to fetch User Details',
          };
        }
      } else {
        return {
          'success': false,
          'message': 'Failed to fetch User Details',
        };
      }
    } catch (e) {
      print(e);
      return {
        'success': false,
        'message': 'An error occurred',
      };
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: insidbook_color,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_outlined,
            color: dark_Brown,
            size: 35,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            color: insidbook_color,
            height: 180,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                FutureBuilder<Map<String, dynamic>>(
                  future: _user,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                          child: CircularProgressIndicator(color: dark_Brown));
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else if (snapshot.hasData &&
                        snapshot.data?['success'] == true) {
                      var user = snapshot.data?['data'];
                      return Padding(
                        padding: const EdgeInsets.only(left: 15, top: 30),
                        child: user == null
                            ? Center(
                                child: CircularProgressIndicator(
                                color: dark_Brown,
                              ))
                            : Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 20, right: 10, bottom: 65),
                                    child: CircleAvatar(
                                      radius: 45,
                                      backgroundColor: Color(0xFF41C9D2),
                                      child: Text(
                                        user['user_name'][0].toUpperCase(),
                                        style: const TextStyle(
                                          fontSize: 30.0,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        user['user_name'],
                                        style: TextStyle(
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.bold,
                                          color: dark_Brown,
                                        ),
                                      ),
                                      const SizedBox(height: 10.0),
                                      Text(
                                        user['gender'],
                                        style: TextStyle(
                                          fontSize: 17.0,
                                          color: medium_Brown,
                                        ),
                                      ),
                                      const SizedBox(height: 10.0),
                                      Text(
                                        user['age'].toString(),
                                        style: TextStyle(
                                          fontSize: 17.0,
                                          color: medium_Brown,
                                        ),
                                      ),
                                      const SizedBox(height: 10.0),
                                      Row(
                                        children: [
                                          Image.asset(
                                            "asset/images/coin.png",
                                            scale: 4,
                                          ),
                                          const SizedBox(width: 4.0),
                                          Text(
                                            "${user['my_points']}",
                                            style: TextStyle(
                                              fontSize: 17.0,
                                              fontWeight: FontWeight.bold,
                                              color: dark_Brown,
                                            ),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                      );
                    } else {
                      return const Center(
                          child: Text('Failed to fetch user details'));
                    }
                  },
                )
              ],
            ),
          ),
          Container(
            color: insidbook_color,
            child: TabBar(
              tabAlignment: TabAlignment.start,
              indicatorSize: TabBarIndicatorSize.label,
              indicatorColor: Colors.brown,
              unselectedLabelColor: Colors.grey,
              labelColor: Colors.brown,
              isScrollable: true,
              controller: _tabController,
              tabs: const [
                Tab(
                  child: Text(
                    'My quotes',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                Tab(
                  child: Text(
                    'Favourite book',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                Tab(
                  child: Text(
                    'Favourite quotes',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                Tab(
                  child: Text(
                    'My notes',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                buildPlaceholderTab(), // "My quotes"
                buildPlaceholderTab(), //  "Favourite book"
                buildPlaceholderTab(), // "Favourite quotes"
                buildNotesTab(), // "My notes"
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildPlaceholderTab() {
    return Stack(
      children: [
        ListView(
          scrollDirection: Axis.vertical,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 30, right: 30, top: 30),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.brown,
                      offset: Offset(0, 5),
                      blurRadius: 10,
                    )
                  ],
                ),
                height: 140,
                width: 20,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget buildNotesTab() {
    return Stack(
      children: [
        ValueListenableBuilder<List<NoteModel>>(
          valueListenable: NoteProvider.notesNotifier,
          builder: (context, notesData, child) {
            if (notesData.isEmpty) {
              return const Center(child: Text('No notes available'));
            }
            return ListView.builder(
              itemCount: notesData.length,
              shrinkWrap: true,
              itemBuilder: (context, i) {
                return CardNote(
                  noteModel: notesData[i],
                  onDelete: () {
                    NoteProvider.notesNotifier.value =
                        List.from(NoteProvider.notesNotifier.value)
                          ..removeAt(i);
                  },
                  onEdit: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return _alertDialog(context, noteToEdit: notesData[i]);
                      },
                    );
                  },
                );
              },
            );
          },
        ),
      ],
    );
  }
}
