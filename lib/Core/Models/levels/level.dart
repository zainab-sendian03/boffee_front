// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:userboffee/Core/Models/basic_model.dart';

class Level extends ResultModel {
  num id;
  num user_id;
  num books;
  String level;
  Level({
    required this.id,
    required this.user_id,
    required this.books,
    required this.level,
  });

  Level copyWith({
    num? id,
    num? user_id,
    num? books,
    String? level,
  }) {
    return Level(
      id: id ?? this.id,
      user_id: user_id ?? this.user_id,
      books: books ?? this.books,
      level: level ?? this.level,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'user_id': user_id,
      'books': books,
      'level': level,
    };
  }

  factory Level.fromMap(Map<String, dynamic> map) {
    return Level(
      id: map['id'] as num,
      user_id: map['user_id'] as num,
      books: map['books'] as num,
      level: map['level'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Level.fromJson(String source) => Level.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Level(id: $id, user_id: $user_id, books: $books, level: $level)';
  }

  @override
  bool operator ==(covariant Level other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.user_id == user_id &&
      other.books == books &&
      other.level == level;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      user_id.hashCode ^
      books.hashCode ^
      level.hashCode;
  }
}
