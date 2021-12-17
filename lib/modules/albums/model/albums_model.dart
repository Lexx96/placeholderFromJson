/// Модель альбомов
class AlbumsModel {
  String title;
  String url;
  String thumbnailUrl;

  AlbumsModel({
    required this.title,
    required this.url,
    required this.thumbnailUrl,
  });

  factory AlbumsModel.fromJson(Map<String, dynamic> postsJson){
    return AlbumsModel(
      title: postsJson['title'] as String,
      url: postsJson['url'] as String,
      thumbnailUrl: postsJson['thumbnailUrl'] as String,
    );
  }
}