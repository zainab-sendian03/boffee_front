import 'package:flutter/material.dart';
import 'package:flutter_application_test/core/Models/note_model.dart';

class NoteProvider {
  static final ValueNotifier<List<NoteModel>> notesNotifier = ValueNotifier([]);
}
