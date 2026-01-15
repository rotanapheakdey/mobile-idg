import 'dart:convert';

// 1. THIS FUNCTION MUST BE OUTSIDE THE CLASS
// It acts as a standalone helper for the 'compute' function.
List<Post> postFromJson(String str) {
  final jsonData = json.decode(str);
  return List<Post>.from(jsonData.map((x) => Post.fromMap(x)));
}

// 2. THE CLASS STARTS HERE
class Post {
  final int userId;
  final int id;
  final String title;
  final String body;

  Post({
    required this.userId,
    required this.id,
    required this.title,
    required this.body,
  });

  factory Post.fromMap(Map<String, dynamic> json) {
    return Post(
      userId: json['userId'],
      id: json['id'],
      title: json['title'],
      body: json['body'],
    );
  }
}