import 'package:flutter/material.dart';
import '../bloc/users_bloc.dart';
import '../bloc/users_state.dart';
import '../models/users_model.dart';

/// Виджет карточки пользователя
class UserCardInfo extends StatefulWidget {
  const UserCardInfo({Key? key}) : super(key: key);

  @override
  _UserCardInfoState createState() => _UserCardInfoState();
}

class _UserCardInfoState extends State<UserCardInfo> {
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
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        const CircleAvatar(
          backgroundImage: AssetImage('assets/images/user/user.png'),
          radius: 50,
        ),
        StreamBuilder(
          stream: _bloc.usersStreamController,
          builder: (BuildContext context, AsyncSnapshot snapshot) {

            if (snapshot.data is LoadedUsersDataState) {
              final _data = snapshot.data as LoadedUsersDataState;
              List<UserModel> _usersData = _data.usersData;

              return Column(
                children: [
                  Text(_usersData[0].name),
                  Text(_usersData[0].email)
                ],
              );
            }

            return const SizedBox.shrink();
          }
        ),
      ],
    );
  }
}
