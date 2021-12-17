import 'package:http/http.dart' as http;

/// Класс управления запросами модуля комментариев
class CommentsRepository {
  static String url = 'https://jsonplaceholder.typicode.com/comments';

  /// Получения списка постов с лимитом
  /// Принимает int [postId] - id поста
  static getCommentsForPost<Response>({required int postId}) async {
    return await http.get(
      Uri.parse('$url?postId=$postId'),
    );
  }

  /// Получения списка постов с лимитом
  /// Принимает модель комментария Map<String, dynamic> [model]
  static postCommentsPost<Response>({required Map<String, dynamic> model}) async {
    return await http.post(
      Uri.parse(url),
      body: model
    );
  }
}
