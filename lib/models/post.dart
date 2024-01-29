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
    print('entrou ');
    Map<String, dynamic> postData = json['posts'];
    Map<String, dynamic> userData = json['user'];
    print('O que tem no postData: $postData');
    return Post(
      id: postData['id'],
      userId: postData['user_id'],
      description: postData['description'],
      imageUrl: postData['image_url'],
      user: User.fromJson(userData),
    );
  }
}
