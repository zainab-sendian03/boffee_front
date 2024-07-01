// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:io';

import 'package:userboffee/Core/Models/basic_model.dart';

class Bookmodel extends ResultModel {
  num id;
  String title;
  String file;
  String cover;
  String author_name;
  num points;
  String description;
  num total_pages;
  num type_id;
  Bookmodel({
    required this.id,
    required this.title,
    required this.file,
    required this.cover,
    required this.author_name,
    required this.points,
    required this.description,
    required this.total_pages,
    required this.type_id,
  });

  Bookmodel copyWith({
    num? id,
    String? title,
    String? file,
    String? cover,
    String? author_name,
    num? points,
    String? description,
    num? total_pages,
    num? type_id,
  }) {
    return Bookmodel(
      id: id ?? this.id,
      title: title ?? this.title,
      file: file ?? this.file,
      cover: cover ?? this.cover,
      author_name: author_name ?? this.author_name,
      points: points ?? this.points,
      description: description ?? this.description,
      total_pages: total_pages ?? this.total_pages,
      type_id: type_id ?? this.type_id,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'file': file,
      'cover': cover,
      'author_name': author_name,
      'points': points,
      'description': description,
      'total_pages': total_pages,
      'type_id': type_id,
    };
  }

  factory Bookmodel.fromMap(Map<String, dynamic> map) {
    return Bookmodel(
      id: map['id'] as num,
      title: map['title'] as String,
      file: map['file'] as String,
      cover: map['cover'] as String,
      author_name: map['author_name'] as String,
      points: map['points'] as num,
      description: map['description'] as String,
      total_pages: map['total_pages'] as num,
      type_id: map['type_id'] as num,
    );
  }

  String toJson() => json.encode(toMap());

  factory Bookmodel.fromJson(String source) =>
      Bookmodel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Bookmodel(id: $id, title: $title, file: $file, cover: $cover, author_name: $author_name, points: $points, description: $description, total_pages: $total_pages, type_id: $type_id)';
  }

  @override
  bool operator ==(covariant Bookmodel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.title == title &&
        other.file == file &&
        other.cover == cover &&
        other.author_name == author_name &&
        other.points == points &&
        other.description == description &&
        other.total_pages == total_pages &&
        other.type_id == type_id;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        file.hashCode ^
        cover.hashCode ^
        author_name.hashCode ^
        points.hashCode ^
        description.hashCode ^
        total_pages.hashCode ^
        type_id.hashCode;
  }
}
