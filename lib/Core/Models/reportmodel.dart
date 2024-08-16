import 'dart:convert';

import 'package:userboffee/Core/Models/basic_model.dart';

class ReportModel extends ResultModel{
  int user_id;
  int book_id;
String body;
int id;
  ReportModel({
    required this.user_id,
    required this.book_id,
    required this.body,
    required this.id,
  });

  ReportModel copyWith({
    int? user_id,
    int? book_id,
    String? body,
    int? id,
  }) {
    return ReportModel(
      user_id: user_id ?? this.user_id,
      book_id: book_id ?? this.book_id,
      body: body ?? this.body,
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    result.addAll({'user_id': user_id});
    result.addAll({'book_id': book_id});
    result.addAll({'body': body});
    result.addAll({'id': id});
  
    return result;
  }

  factory ReportModel.fromMap(Map<String, dynamic> map) {
    return ReportModel(
      user_id: map['user_id']?.toInt() ?? 0,
      book_id: map['book_id']?.toInt() ?? 0,
      body: map['body'] ?? '',
      id: map['id']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory ReportModel.fromJson(String source) => ReportModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ReportModel(user_id: $user_id, book_id: $book_id, body: $body, id: $id)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is ReportModel &&
      other.user_id == user_id &&
      other.book_id == book_id &&
      other.body == body &&
      other.id == id;
  }

  @override
  int get hashCode {
    return user_id.hashCode ^
      book_id.hashCode ^
      body.hashCode ^
      id.hashCode;
  }
}
