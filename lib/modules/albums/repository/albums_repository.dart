import 'package:http/http.dart' as http;

/// Класс управления запросами модуля альбомов
class AlbumsRepository {
  /// Основной URL запросов модуля
  static String url = 'https://jsonplaceholder.typicode.com/photos?userId=';

  /// Отправка запроса на сервер для получения списка альбомов с указанным лимитом
  /// Принимает int [userId] - id пользователя, int [limit] - кол-во альбомов
  static getAlbums<Response>({required int userId, required int limit}) async {
    return await http.get(
      Uri.parse('$url$userId&_start=0&_limit=$limit'),
    );
  }

  /// Отправка запроса на сервер для получение всех альбомов пользователя с пагинацией
  /// Принимает int [userId] - id пользователя, int [start] - стартовая позициязагрузки
  static getAllAlbums<Response>({required int userId, required int start}) async {
    return await http.get(
      Uri.parse('$url$userId&_start=$start&_limit=20'),
    );
  }
}