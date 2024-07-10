import 'dart:convert';

class ReadingModel {
  num book_id;
  num user_id;
  String status;
  num progress;
  ReadingModel({
    required this.book_id,
    required this.user_id,
    required this.status,
    required this.progress,
  });

  ReadingModel copyWith({
    num? book_id,
    num? user_id,
    String? status,
    num? progress,
  }) {
    return ReadingModel(
      book_id: book_id ?? this.book_id,
      user_id: user_id ?? this.user_id,
      status: status ?? this.status,
      progress: progress ?? this.progress,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'book_id': book_id});
    result.addAll({'user_id': user_id});
    result.addAll({'status': status});
    result.addAll({'progress': progress});

    return result;
  }

  factory ReadingModel.fromMap(Map<String, dynamic> map) {
    return ReadingModel(
      book_id: map['book_id'] ?? 0,
      user_id: map['user_id'] ?? 0,
      status: map['status'] ?? '',
      progress: map['progress'] ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory ReadingModel.fromJson(String source) =>
      ReadingModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ReadingModel(book_id: $book_id, user_id: $user_id, status: $status, progress: $progress)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ReadingModel &&
        other.book_id == book_id &&
        other.user_id == user_id &&
        other.status == status &&
        other.progress == progress;
  }

  @override
  int get hashCode {
    return book_id.hashCode ^
        user_id.hashCode ^
        status.hashCode ^
        progress.hashCode;
  }
}
