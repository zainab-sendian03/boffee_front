import 'package:flutter/material.dart';
import 'package:userboffee/Core/Models/note_model.dart';

class NoteProvider {
  static final ValueNotifier<List<NoteModel>> notesNotifier = ValueNotifier([]);
}
