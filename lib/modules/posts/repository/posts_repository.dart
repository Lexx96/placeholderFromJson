import 'package:http/http.dart' as http;

/// Класс управления запросами модуля постов
class PostsRepository {
  /// Основной URL запросов модуля
  static String url = 'https://jsonplaceholder.typicode.com/posts';

  /// Получения списка постов с лимитом
  /// Принимает id пользователя int [userId] и кол-во постов int [limit]
  static getLimitPosts<Response>({required int userId, required int limit}) async {
    return await http.get(
      Uri.parse('$url?userId=$userId&_start=0&_limit=$limit'),
    );
  }

  /// Получения всех постов
  /// Принимает id пользователя int [userId]
  static getAllPosts<Response>({required int userId}) async {
    return await http.get(
      Uri.parse('$url?userId=$userId'),
    );
  }

  /// Получения делатьной информации поста по postId
  /// Принимает id поста int [postId]
  static getDetailPost<Response>({required int postId}) async {
    return await http.get(
      Uri.parse('$url/$postId'),
    );
  }
}