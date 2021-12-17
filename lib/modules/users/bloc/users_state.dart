import '../models/user_db_model.dart';
import '../models/users_model.dart';

/// Состояние модуля пользователей
class UsersState {
  UsersState();
  factory UsersState.loadedUsersDataState(List<UserModel> usersData) = LoadedUsersDataState;
  factory UsersState.loadedUserProfileDataState(UserModel usersData) = LoadedUserProfileDataState;
  factory UsersState.loadedUsersDataFromDbState(List<UserDbModel> usersData) = LoadedUsersDataFromDbState;
}

/// Состояние загруки данных с сервера
class LoadedUsersDataState extends UsersState {
  List<UserModel> usersData;
  LoadedUsersDataState(this.usersData);
}

/// Состояние загруки профиля пользователя
class LoadedUserProfileDataState extends UsersState {
  UserModel userData;
  LoadedUserProfileDataState(this.userData);
}

/// Состояние получения данных из базы
class LoadedUsersDataFromDbState extends UsersState {
  List<UserDbModel> usersData;
  LoadedUsersDataFromDbState(this.usersData);
}
