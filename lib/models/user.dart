class User {
  int? id;
  String? name;
  String? email;
  String? role;
  String? token;

  User({
    this.id,
    this.name,
    this.email,
    this.role,
    this.token,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['user']['id'],
      name: json['user']['name'],
      email: json['user']['email'],
      role: json['user']['role'],
      token: json['token'],
    );
  }
}
