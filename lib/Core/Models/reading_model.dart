class ReadingModel {
  final int id;
  final int bookId;
  final int userId;
  final String status;
  final String title;
  final String cover;
  final String file;

  ReadingModel({
    required this.id,
    required this.bookId,
    required this.userId,
    required this.status,
    required this.title,
    required this.cover,
    required this.file,
  });

  // Update the fromMap method to handle the new structure
  factory ReadingModel.fromMap(Map<String, dynamic> map) {
    return ReadingModel(
      id: map['shelf']['id'] ?? 0,
      bookId: map['shelf']['book_id'] ?? 0,
      userId: map['shelf']['user_id'] ?? 0,
      status: map['shelf']['status'] ?? '',
      title: map['book']['title'] ?? '',
      cover: map['book']['cover'] ?? '',
      file: map['book']['file'] ?? '',
    );
  }
}
