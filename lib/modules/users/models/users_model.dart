/// Модель пользователя для получения данных с сервера
class UserModel {
  int id;
  String name;
  String username;
  String email;
  String phone;
  String website;
  Map<String, dynamic> address;
  Map<String, dynamic> company;

  UserModel({
    required this.id,
    required this.name,
    required this.username,
    required this.email,
    required this.phone,
    required this.website,
    required this.address,
    required this.company
  });

  factory UserModel.fromJson(Map<String, dynamic> usersJson){
    return UserModel(
        id: usersJson['id'] as int,
        name: usersJson['name'] as String,
        username: usersJson['username'] as String,
        email: usersJson['email'] as String,
        phone: usersJson['phone'] as String,
        website: usersJson['website'] as String,
        address: usersJson['address'] as Map<String, dynamic>,
        company: usersJson['company'] as Map<String, dynamic>,
    );
  }
}