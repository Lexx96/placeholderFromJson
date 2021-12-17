/// Модель комментариев
class CommentsModel {
  String name;
  String email;
  String body;

  CommentsModel({
    required this.name,
    required this.email,
    required this.body,
  });

  factory CommentsModel.fromJson(Map<String, dynamic> postsJson){
    return CommentsModel(
      name: postsJson['name'] as String,
      email: postsJson['email'] as String,
      body: postsJson['body'] as String
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "email": email,
      "body": body
    };
  }
}