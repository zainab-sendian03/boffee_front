
class User {
  final String userName;
  final String age;
  final String gender;

  User({required this.userName, required this.age, required this.gender});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userName: json['user_name'],
      age: json['age'],
      gender: json['gender'],
    );
  }
}

