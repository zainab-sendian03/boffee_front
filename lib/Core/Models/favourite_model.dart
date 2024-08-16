import 'dart:convert';

class FavouriteMODEL {
  int favorite_id;
  int user_id;
  int book_id;
  String title;
  String cover;
  String file;
  String author_name;
  int total_pages;
  int points;
  String type_name; 
  FavouriteMODEL({
    required this.favorite_id,
    required this.user_id,
    required this.book_id,
    required this.title,
    required this.cover,
    required this.file,
    required this.author_name,
    required this.total_pages,
    required this.points,
    required this.type_name,
  });

  FavouriteMODEL copyWith({
    int? favorite_id,
    int? user_id,
    int? book_id,
    String? title,
    String? cover,
    String? file,
    String? author_name,
    int? total_pages,
    int? points,
    String? type_name,
  }) {
    return FavouriteMODEL(
      favorite_id: favorite_id ?? this.favorite_id,
      user_id: user_id ?? this.user_id,
      book_id: book_id ?? this.book_id,
      title: title ?? this.title,
      cover: cover ?? this.cover,
      file: file ?? this.file,
      author_name: author_name ?? this.author_name,
      total_pages: total_pages ?? this.total_pages,
      points: points ?? this.points,
      type_name: type_name ?? this.type_name,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    result.addAll({'favorite_id': favorite_id});
    result.addAll({'user_id': user_id});
    result.addAll({'book_id': book_id});
    result.addAll({'title': title});
    result.addAll({'cover': cover});
    result.addAll({'file': file});
    result.addAll({'author_name': author_name});
    result.addAll({'total_pages': total_pages});
    result.addAll({'points': points});
    result.addAll({'type_name': type_name});
  
    return result;
  }

  factory FavouriteMODEL.fromMap(Map<String, dynamic> map) {
    return FavouriteMODEL(
      favorite_id: map['favorite_id']?.toInt() ?? 0,
      user_id: map['user_id']?.toInt() ?? 0,
      book_id: map['book_id']?.toInt() ?? 0,
      title: map['title'] ?? '',
      cover: map['cover'] ?? '',
      file: map['file'] ?? '',
      author_name: map['author_name'] ?? '',
      total_pages: map['total_pages']?.toInt() ?? 0,
      points: map['points']?.toInt() ?? 0,
      type_name: map['type_name'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory FavouriteMODEL.fromJson(String source) => FavouriteMODEL.fromMap(json.decode(source));

  @override
  String toString() {
    return 'FavouriteMODEL(favorite_id: $favorite_id, user_id: $user_id, book_id: $book_id, title: $title, cover: $cover, file: $file, author_name: $author_name, total_pages: $total_pages, points: $points, type_name: $type_name)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is FavouriteMODEL &&
      other.favorite_id == favorite_id &&
      other.user_id == user_id &&
      other.book_id == book_id &&
      other.title == title &&
      other.cover == cover &&
      other.file == file &&
      other.author_name == author_name &&
      other.total_pages == total_pages &&
      other.points == points &&
      other.type_name == type_name;
  }

  @override
  int get hashCode {
    return favorite_id.hashCode ^
      user_id.hashCode ^
      book_id.hashCode ^
      title.hashCode ^
      cover.hashCode ^
      file.hashCode ^
      author_name.hashCode ^
      total_pages.hashCode ^
      points.hashCode ^
      type_name.hashCode;
  }
  }
