import 'user.dart';

class Post {
  final int id;
  final int userId;
  final String description;
  final String? imageUrl;
  final User user;

  Post({
    required this.id,
    required this.description,
    required this.userId,
    required this.user,
    this.imageUrl,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'],
      userId: json['user_id'],
      description: json['description'],
      imageUrl: json['image_url'],
      user: User.fromJson(json['user']),
    );
  }
}
