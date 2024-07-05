import 'dart:convert';

class DetailModel {
  num id;
  String title;
  String author_name;
  String description;
  String cover;
  num total_pages;
  DetailModel({
    required this.id,
    required this.title,
    required this.author_name,
    required this.description,
    required this.cover,
    required this.total_pages,
  });

  DetailModel copyWith({
    num? id,
    String? title,
    String? author_name,
    String? description,
    String? cover,
    num? total_pages,
  }) {
    return DetailModel(
      id: id ?? this.id,
      title: title ?? this.title,
      author_name: author_name ?? this.author_name,
      description: description ?? this.description,
      cover: cover ?? this.cover,
      total_pages: total_pages ?? this.total_pages,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    result.addAll({'id': id});
    result.addAll({'title': title});
    result.addAll({'author_name': author_name});
    result.addAll({'description': description});
    result.addAll({'cover': cover});
    result.addAll({'total_pages': total_pages});
  
    return result;
  }

  factory DetailModel.fromMap(Map<String, dynamic> map) {
    return DetailModel(
      id: map['id'] ?? 0,
      title: map['title'] ?? '',
      author_name: map['author_name'] ?? '',
      description: map['description'] ?? '',
      cover: map['cover'] ?? '',
      total_pages: map['total_pages'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory DetailModel.fromJson(String source) => DetailModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'DetailModel(id: $id, title: $title, author_name: $author_name, description: $description, cover: $cover, total_pages: $total_pages)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is DetailModel &&
      other.id == id &&
      other.title == title &&
      other.author_name == author_name &&
      other.description == description &&
      other.cover == cover &&
      other.total_pages == total_pages;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      title.hashCode ^
      author_name.hashCode ^
      description.hashCode ^
      cover.hashCode ^
      total_pages.hashCode;
  }
}
