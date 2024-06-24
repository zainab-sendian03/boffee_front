// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:userboffee/Core/Models/basic_model.dart';

class PostModel extends ResultModel {
  String body;
  String user_name;
  PostModel({
    required this.body,
    required this.user_name,
  });

  PostModel copyWith({
    String? body,
    String? user_name,
  }) {
    return PostModel(
      body: body ?? this.body,
      user_name: user_name ?? this.user_name,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'body': body,
      'user_name': user_name,
    };
  }

  factory PostModel.fromMap(Map<String, dynamic> map) {
    return PostModel(
      body: map['body'] as String,
      user_name: map['user_name'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory PostModel.fromJson(String source) => PostModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'ShowPostModel(body: $body, user_name: $user_name)';

  @override
  bool operator ==(covariant PostModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.body == body &&
      other.user_name == user_name;
  }

  @override
  int get hashCode => body.hashCode ^ user_name.hashCode;
}
