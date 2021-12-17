/// Модель постов
class PostsModel {
  int id;
  String title;
  String body;

  PostsModel({
    required this.id,
    required this.title,
    required this.body,
  });

  factory PostsModel.fromJson(Map<String, dynamic> postsJson){
    return PostsModel(
      id: postsJson['id'] as int,
      title: postsJson['title'] as String,
      body: postsJson['body'] as String,
    );
  }
}