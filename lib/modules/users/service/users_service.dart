import 'dart:convert';
import 'package:http/http.dart';
import '../models/user_db_model.dart';
import '../models/users_model.dart';
import '../repository/users_repository.dart';

/// Сервис обработки запросов модуля пользователей
class UsersService {
  /// Получение данных о пользователях
  Future<List<UserModel>> getAllUsers() async {
    final Response response = await UsersRepository.getAllUsers();
    if(response.statusCode == 200) {
      try {
        final usersJsonDecodeList = jsonDecode(response.body) as List<dynamic>;
        return usersJsonDecodeList.map((dynamic e) => UserModel.fromJson(e as Map<String, dynamic>)).toList();
      }
      catch(e){
        throw Exception(e);
      }
    }

    throw Exception('неправильный, некорректный запрос');
  }

  /// Получение профиля пользователя
  /// Принимает id пользоватея int [userId]
  Future<UserModel> getUserInfo({required int userId}) async {
    final Response response = await UsersRepository.getUserInfo(userId: userId);
    if(response.statusCode == 200) {
      try {
        final usersJsonDecodeList = jsonDecode(response.body);
        final List<dynamic> data = [
          usersJsonDecodeList
        ];
        final profile = data.map((dynamic e) => UserModel.fromJson(e as Map<String, dynamic>)).toList()[0];
        return profile;
      }
      catch(e) {
        throw Exception(e);
      }
    }

    throw Exception('неправильный, некорректный запрос');
  }

  /// Получение списка пользователей из базы данных
  Future<List<UserDbModel>> getUsersFromDb() async {
    List users = await UsersRepository.getAllUsersFromDb();
    if (users.isNotEmpty) {
      return users.map((e) => UserDbModel.fromJson(e as Map<String, dynamic>)).toList();
    }

    return <UserDbModel>[];
  }

  /// Запись пользователей в базу данных
  /// Принимает экземпляр модели [UserModel]
  Future<bool> insertToDb(List<UserModel> users) async {
    for(int i = 0; i < users.length; i++) {
      await UsersRepository.insertUserToDb(userModel: UserDbModel(
        id: users[i].id,
        name: users[i].name,
        username: users[i].username,
      ));
    }

    return true;
  }

  /// Удаление всех пользователей из базы данных
  Future<bool> deleteAllUsersFromDb() async {
    await UsersRepository.deleteAllUsersFromDb();
    return true;
  }
}
