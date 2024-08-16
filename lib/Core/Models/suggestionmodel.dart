import 'dart:convert';

class SuggestionModel {
  int id;
  int user_id;
  String user_name;
  String body;
  String author_name;
  SuggestionModel({
    required this.id,
    required this.user_id,
    required this.user_name,
    required this.body,
    required this.author_name,
  });

  SuggestionModel copyWith({
    int? id,
    int? user_id,
    String? user_name,
    String? body,
    String? author_name,
  }) {
    return SuggestionModel(
      id: id ?? this.id,
      user_id: user_id ?? this.user_id,
      user_name: user_name ?? this.user_name,
      body: body ?? this.body,
      author_name: author_name ?? this.author_name,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    result.addAll({'id': id});
    result.addAll({'user_id': user_id});
    result.addAll({'user_name': user_name});
    result.addAll({'body': body});
    result.addAll({'author_name': author_name});
  
    return result;
  }

  factory SuggestionModel.fromMap(Map<String, dynamic> map) {
    return SuggestionModel(
      id: map['id']?.toInt() ?? 0,
      user_id: map['user_id']?.toInt() ?? 0,
      user_name: map['user_name'] ?? '',
      body: map['body'] ?? '',
      author_name: map['author_name'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory SuggestionModel.fromJson(String source) => SuggestionModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'SuggestionModel(id: $id, user_id: $user_id, user_name: $user_name, body: $body, author_name: $author_name)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is SuggestionModel &&
      other.id == id &&
      other.user_id == user_id &&
      other.user_name == user_name &&
      other.body == body &&
      other.author_name == author_name;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      user_id.hashCode ^
      user_name.hashCode ^
      body.hashCode ^
      author_name.hashCode;
  }
}
