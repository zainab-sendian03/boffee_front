// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:userboffee/Core/Models/basic_model.dart';

class LikeModel extends ResultModel {
int data;
  LikeModel({
    required this.data,
  });


  LikeModel copyWith({
    int? data,
  }) {
    return LikeModel(
      data: data ?? this.data,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'data': data,
    };
  }

  factory LikeModel.fromMap(Map<String, dynamic> map) {
    return LikeModel(
      data: map['data'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory LikeModel.fromJson(String source) => LikeModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'LikeModel(data: $data)';

  @override
  bool operator ==(covariant LikeModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.data == data;
  }

  @override
  int get hashCode => data.hashCode;
}
