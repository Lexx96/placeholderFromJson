import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../bloc/posts_bloc.dart';
import '../bloc/posts_state.dart';
import '../model/posts_model.dart';
import '../widgets/post_card.dart';
import '../posts_user_screen.dart';

/// Посты пользователя
class PostsUser extends StatefulWidget {
  final int userId;

  const PostsUser({Key? key, required this.userId}) : super(key: key);

  @override
  _PostsUserState createState() => _PostsUserState();
}

class _PostsUserState extends State<PostsUser> {
  late PostsBloc _bloc;
  List<PostsModel> _postsData = [];

  @override
  void initState() {
    super.initState();
    _bloc = PostsBloc();
    _bloc.getPostsUserLimitBloc(userId: widget.userId, limit: 3);
  }

  @override
  void dispose() {
    super.dispose();
    _bloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _bloc.postStreamController,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.data is LoadedPostsState) {
          final _data = snapshot.data as LoadedPostsState;
          _postsData = _data.postsData;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _postsData.length,
                itemBuilder: (BuildContext context, int index) {
                  return PostCard(postsData: _postsData[index]);
                },
              ),
              TextButton(
                onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => PostsUserScreen(userId: widget.userId),
                  ),
                ),
                child: const Text('Подробнее'),
              )
            ],
          );
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
