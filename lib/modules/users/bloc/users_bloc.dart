import 'dart:async';
import 'users_state.dart';
import '../models/user_db_model.dart';
import '../models/users_model.dart';
import '../service/users_service.dart';

/// Управление состояниями модуля пользователей
class UsersBloc {
  final _usersStreamController = StreamController<UsersState>();
  Stream<UsersState> get usersStreamController => _usersStreamController.stream;

  final _userProfileStreamController = StreamController<UsersState>();
  Stream<UsersState> get userProfileStreamController => _userProfileStreamController.stream;

  /// Получение данных о пользователях
  void getAllUsersBloc () async {
    List<UserDbModel> usersFromDb = await UsersService().getUsersFromDb();
    if (usersFromDb.isNotEmpty) {
      _usersStreamController.sink.add(UsersState.loadedUsersDataFromDbState(usersFromDb));
    }

    List<UserModel> usersData =  await UsersService().getAllUsers();
    _usersStreamController.sink.add(UsersState.loadedUsersDataState(usersData));

    await UsersService().deleteAllUsersFromDb();
    await UsersService().insertToDb(usersData);
  }

  /// Получение профиля пользователя
  void getUserProfile({required int userId}) async {
    UserModel usersData =  await UsersService().getUserInfo(userId: userId);
    _userProfileStreamController.sink.add(UsersState.loadedUserProfileDataState(usersData));
  }

  void dispose () {
    _usersStreamController.close();
    _userProfileStreamController.close();
  }
}
