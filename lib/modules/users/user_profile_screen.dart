import 'package:flutter/material.dart';
import '../albums/widgets/albums_user.dart';
import '../posts/widgets/posts_user.dart';
import 'bloc/users_bloc.dart';
import 'bloc/users_state.dart';

/// Экран профиля пользователя
class UserProfileScreen extends StatefulWidget {
  final int userId;

  const UserProfileScreen({Key? key, required this.userId}) : super(key: key);

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  late final UsersBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = UsersBloc();
    _bloc.getUserProfile(userId: widget.userId);
  }

  @override
  void dispose() {
    super.dispose();
    _bloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _bloc.userProfileStreamController,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.data is LoadedUserProfileDataState) {
          LoadedUserProfileDataState data =
              snapshot.data as LoadedUserProfileDataState;

          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text(data.userData.username),
            ),
            body: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Container(
                        height: 160,
                        width: 160,
                        decoration: BoxDecoration(
                          border:
                              Border.all(color: Colors.black.withOpacity(0.2)),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(90)),
                          boxShadow: const [
                            BoxShadow(
                                color: Colors.black,
                                blurRadius: 8,
                                offset: Offset(0, 2))
                          ],
                        ),
                        clipBehavior: Clip.hardEdge,
                        child: Stack(
                          children: [
                            const CircleAvatar(
                              backgroundImage:
                                  AssetImage('assets/images/user/user.png'),
                              radius: 80.0,
                            ),
                            Material(
                              color: Colors.transparent,
                              child: InkWell(
                                splashColor: Colors.grey[1],
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(90),
                                ),
                                onTap: () {},
                              ),
                            )
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(top: 25.0, bottom: 20.0),
                            child: Text(
                              'Основная информация',
                              style: TextStyle(fontSize: 18.0),
                            ),
                          ),
                          _userInformationWidget(
                              field: 'Имя:', information: data.userData.name),
                          const Divider(),
                          _userInformationWidget(
                              field: 'Почта:',
                              information: data.userData.email),
                          const Divider(),
                          _userInformationWidget(
                              field: 'Телефон:',
                              information: data.userData.phone),
                          const Divider(),
                          _userInformationWidget(
                              field: 'Сайт:',
                              information: data.userData.website),
                          const Divider(),
                          const Padding(
                            padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                            child: Text(
                              'Информация о работе',
                              style: TextStyle(fontSize: 18.0),
                            ),
                          ),
                          const Divider(),
                          _userInformationWidget(
                              field: 'Название:',
                              information: data.userData.company['name']),
                          const Divider(),
                          _userInformationWidget(
                              field: 'Направление:',
                              information: data.userData.company['bs']),
                          const Divider(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              const Expanded(child: Text('Лозунг:')),
                              Expanded(
                                  child: Text(
                                '"${data.userData.company['catchPhrase']}"',
                                style: const TextStyle(
                                    fontWeight: FontWeight.w800,
                                    fontStyle: FontStyle.italic),
                              )),
                            ],
                          ),
                          const Divider(),
                          const Padding(
                            padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                            child: Text(
                              'Адрес',
                              style: TextStyle(fontSize: 18.0),
                            ),
                          ),
                          _userInformationWidget(
                              field: 'Город:',
                              information: data.userData.address['city']),
                          const Divider(),
                          _userInformationWidget(
                              field: 'Улица:',
                              information: data.userData.address['street']),
                          const Divider(),
                          _userInformationWidget(
                              field: 'Дом:',
                              information: data.userData.address['suite']),
                          const Divider(),
                          _userInformationWidget(
                              field: 'Почтовый индекс:',
                              information: data.userData.address['zipcode']),
                          const Divider(),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                            child: AlbumsUser(userId: data.userData.id),
                          ),
                          const Divider(),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                            child: PostsUser(userId: data.userData.id),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }

        return const Scaffold(
          body: SizedBox.shrink(),
        );
      },
    );
  }

  /// Вывод информации о пользователе
  Row _userInformationWidget(
      {required String information, required String field}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
            child: Text(
          field,
        )),
        Expanded(child: Text(information)),
      ],
    );
  }
}
