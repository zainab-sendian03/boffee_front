// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:userboffee/Core/Models/basic_model.dart';

class PostModel extends ResultModel {
  String body;
  String? user_name;
  int? id;
  PostModel({
    required this.body,
    this.user_name,
    this.id,
  });
  

  PostModel copyWith({
    String? body,
    String? user_name,
    int? id,
  }) {
    return PostModel(
      body: body ?? this.body,
      user_name: user_name ?? this.user_name,
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'body': body,
      'user_name': user_name,
      'id': id,
    };
  }

  factory PostModel.fromMap(Map<String, dynamic> map) {
    return PostModel(
      body: map['body'] as String,
      user_name: map['user_name'] as String,
      id: map['id'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory PostModel.fromJson(String source) => PostModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'PostModel(body: $body, user_name: $user_name, id: $id)';

  @override
  bool operator ==(covariant PostModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.body == body &&
      other.user_name == user_name &&
      other.id == id;
  }

  @override
  int get hashCode => body.hashCode ^ user_name.hashCode ^ id.hashCode;
}
