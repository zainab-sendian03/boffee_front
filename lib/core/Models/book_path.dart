class mypdf_model {
  String? title;
  String? cover;
  String? file;
  String? authorName;
  int? totalPages;
  int? points;
  String? typeName;

  mypdf_model(
      {this.title,
      this.cover,
      this.file,
      this.authorName,
      this.totalPages,
      this.points,
      this.typeName});

  mypdf_model.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    cover = json['cover'];
    file = json['file'];
    authorName = json['author_name'];
    totalPages = json['total_pages'];
    points = json['points'];
    typeName = json['type_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['cover'] = this.cover;
    data['file'] = this.file;
    data['author_name'] = this.authorName;
    data['total_pages'] = this.totalPages;
    data['points'] = this.points;
    data['type_name'] = this.typeName;
    return data;
  }
}
