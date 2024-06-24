// ignore_for_file: public_member_api_docs, sort_constructors_first
class ResultModel {}

class ErrorModel extends ResultModel {}

class ExceptionModel extends ResultModel {}

class successModel extends ResultModel {}

class ListOf<T> extends ResultModel {

  List<T> result;
  ListOf({
    required this.result,
  });
}
