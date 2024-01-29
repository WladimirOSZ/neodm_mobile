class User {
  final int id;
  final String name;
  final String username;
  final String? photo;
  final String? email;
  final String? token;

  User({
    required this.id,
    required this.name,
    required this.username,
    this.photo,
    this.email,
    this.token,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    print('User.fromJson: $json');
    return User(
      id: json['id'],
      name: json['name'],
      username: json['username'],
      photo: json['photo'],
    );
  }

  factory User.fromLoginJson(Map<String, dynamic> json, String token) {
    return User(
      id: json['id'],
      name: json['name'],
      username: json['username'],
      email: json['email'],
      photo: json['photo'],
      token: token,
    );
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      name: map['name'],
      username: map['username'],
      email: map['email'],
      photo: map['photo'],
      token: map['token'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'token': token,
      'username': username,
      'photo': photo,
    };
  }
}
