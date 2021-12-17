import 'package:http/http.dart' as http;
import '../models/user_db_model.dart';
import '../../../utils/db.dart';

/// Класс управления запросами модуля пользователей
class UsersRepository {
  /// Основной URL модуля
  static String url = 'https://jsonplaceholder.typicode.com/users';

  /// Получение списка пользователей
  static getAllUsers<Response>() async {
    return await http.get(
      Uri.parse(url),
    );
  }

  /// Получение профиля пользователя по ID
  static getUserInfo({required int userId}) async {
    return await http.get(
      Uri.parse('$url/$userId'),
    );
  }

  /// Получение пользователей из базы данных
  static getAllUsersFromDb() async {
    final Db _db = Db();
    return await _db.readAll('users');
  }

  /// Запись списка пользователей в базу данных
  static insertUserToDb({required UserDbModel userModel}) async {
    final Db _db = Db();
    await _db.insertRow('users', userModel);
  }

  /// Удаление всех пользователей из базы данных
  static deleteAllUsersFromDb() async {
    final Db _db = Db();
    await _db.deleteAllFromTable('users');
  }
}



