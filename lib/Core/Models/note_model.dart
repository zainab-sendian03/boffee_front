class NoteModel {
  int? id;
  int? userId;
  int? bookId;
  int? pageNum;
  String? body;
  int? color;
  String? createdAt;
  String? updatedAt;
  String? title;
  String? cover;
  String? file;

  NoteModel(
      {this.id,
      this.userId,
      this.bookId,
      this.pageNum,
      this.body,
      this.color,
      this.createdAt,
      this.updatedAt,
      this.title,
      this.cover,
      this.file});

  NoteModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    bookId = json['book_id'];
    pageNum = json['page_num'];
    body = json['body'];
    color = json['color'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    title = json['title'];
    cover = json['cover'];
    file = json['file'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['book_id'] = this.bookId;
    data['page_num'] = this.pageNum;
    data['body'] = this.body;
    data['color'] = this.color;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['title'] = this.title;
    data['cover'] = this.cover;
    data['file'] = this.file;
    return data;
  }
}
