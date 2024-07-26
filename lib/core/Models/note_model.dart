class NoteModel {
  int? id;
  int? userId;
  int? bookId;
  int? pageNum;
  String? body;
  int? color;
  String? title;
  String? createdAt;
  String? updatedAt;
  String? bookCover;

  NoteModel({
    this.id,
    this.userId,
    this.bookId,
    this.pageNum,
    this.body,
    this.color,
    this.title,
    this.createdAt,
    this.updatedAt,
    this.bookCover,
  });

  factory NoteModel.fromJson(Map<String, dynamic> json) {
    return NoteModel(
      id: json['id'],
      userId: json['user_id'],
      bookId: json['book_id'],
      pageNum: json['page_num'],
      body: json['body'],
      title: json['title'],
      color: json['color'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      bookCover: json['book_cover'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'book_id': bookId,
      'page_num': pageNum,
      'body': body,
      'color': color,
      'title': title,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'book_cover': bookCover,
    };
  }
}
