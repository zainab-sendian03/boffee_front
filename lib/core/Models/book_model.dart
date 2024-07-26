import 'dart:convert';

class BookModel {
  int id;
  String title;
  String cover;
  String author_name;

  BookModel({
    required this.id,
    required this.title,
    required this.cover,
    required this.author_name,
  });

  BookModel copyWith({
    int? id,
    String? title,
    String? cover,
    String? author_name,
  }) {
    return BookModel(
      id: id ?? this.id,
      title: title ?? this.title,
      cover: cover ?? this.cover,
      author_name: author_name ?? this.author_name,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'title': title});
    result.addAll({'cover': cover});
    result.addAll({'author_name': author_name});

    return result;
  }

  factory BookModel.fromMap(Map<String, dynamic> map) {
    return BookModel(
      id: map['id'] ?? 0,
      title: map['title'] ?? '',
      cover: map['cover'] ?? '',
      author_name: map['author_name'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory BookModel.fromJson(String source) =>
      BookModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'BookModel(id: $id, title: $title, cover: $cover, author_name: $author_name)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is BookModel &&
        other.id == id &&
        other.title == title &&
        other.cover == cover &&
        other.author_name == author_name;
  }

  @override
  int get hashCode {
    return id.hashCode ^ title.hashCode ^ cover.hashCode ^ author_name.hashCode;
  }
}
