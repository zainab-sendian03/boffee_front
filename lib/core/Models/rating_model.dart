class rating_model {
  int? userId;
  String? bookId;
  String? rate;
  String? updatedAt;
  String? createdAt;
  int? id;

  rating_model(
      {this.userId,
      this.bookId,
      this.rate,
      this.updatedAt,
      this.createdAt,
      this.id});

  rating_model.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    bookId = json['book_id'];
    rate = json['rate'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['book_id'] = this.bookId;
    data['rate'] = this.rate;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['id'] = this.id;
    return data;
  }
}
