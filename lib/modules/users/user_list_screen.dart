import 'package:flutter/material.dart';
import 'user_profile_screen.dart';
import 'widgets/sceleton.dart';
import 'bloc/users_bloc.dart';
import 'bloc/users_state.dart';

/// Экран вывода списка пользователей
class UsersScreen extends StatefulWidget {
  const UsersScreen({Key? key}) : super(key: key);

  @override
  _UsersScreenState createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  late final UsersBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = UsersBloc();
    _bloc.getAllUsersBloc();
  }

  @override
  void dispose() {
    super.dispose();
    _bloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Test App For Eclipse DS'),
      ),
      body: StreamBuilder(
          stream: _bloc.usersStreamController,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.data is LoadedUsersDataState ||
                snapshot.data is LoadedUsersDataFromDbState) {
              dynamic _data;

              if (snapshot.data is LoadedUsersDataState) {
                _data = snapshot.data as LoadedUsersDataState;
              } else {
                _data = snapshot.data as LoadedUsersDataFromDbState;
              }

              return ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: _data.usersData.length,
                itemBuilder: (BuildContext context, int index) {
                  return _cardProfile(_data.usersData[index]);
                },
              );
            }

            return const SkeletonWidget();
          }),
    );
  }

  /// Карточка пользователя
  _cardProfile(user) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          splashColor: Colors.blue,
          borderRadius: const BorderRadius.all(Radius.circular(25)),
          onTap: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (_) => UserProfileScreen(userId: user.id),
            )
          ),
          child: Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(25)),
            ),
            child: Row(
              children: [
                const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: CircleAvatar(
                    backgroundImage: AssetImage('assets/images/user/user.png'),
                    radius: 32,
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(user.username,
                          style: const TextStyle(
                              fontSize: 18.0, fontWeight: FontWeight.bold),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1),
                      Text(user.name),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
