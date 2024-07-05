// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter_application_test/core/Models/book_model.dart';
import 'package:flutter_application_test/core/Models/post_model.dart';

class ResultModel {}

class ErrorModel extends ResultModel {}

class ExceptionModel extends ResultModel {}

class successModel extends ResultModel {}

class ListOf<T> extends ResultModel {
  List<PostModel> result;
  ListOf({
    required this.result,
  });
}

class ListOfbook<T> extends ResultModel {
  List<BookModel> result;
  ListOfbook({
    required this.result,
  });
}
