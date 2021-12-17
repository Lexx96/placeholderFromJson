/// Модель пользователя для сохранения в базу данных
class UserDbModel {
  int id;
  String name;
  String username;

  UserDbModel({
    required this.id,
    required this.name,
    required this.username
  });

  factory UserDbModel.fromJson(Map<String, dynamic> usersJson){
    return UserDbModel(
        id: usersJson['id'] as int,
        name: usersJson['name'] as String,
        username: usersJson['username'] as String
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "username": username,
    };
  }
}