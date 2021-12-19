import 'package:flutter/material.dart';
import '../posts/widgets/post_card.dart';
import 'bloc/posts_bloc.dart';
import 'bloc/posts_state.dart';
import 'model/posts_model.dart';
import 'post_detail_screen.dart';

/// Экран списка постов пользователя
class PostsUserScreen extends StatefulWidget {
  final int userId;

  const PostsUserScreen({Key? key, required this.userId}) : super(key: key);

  @override
  _PostsUserScreenState createState() => _PostsUserScreenState();
}

class _PostsUserScreenState extends State<PostsUserScreen> {
  late PostsBloc _bloc;
  List<PostsModel> _postsData = [];

  @override
  void initState() {
    super.initState();
    _bloc = PostsBloc();
    _bloc.getPostsUserAllScreenBloc(userId: widget.userId);
  }

  @override
  void dispose() {
    super.dispose();
    _bloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: _bloc.postUserScreenStreamController,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.data is LoadedPostsState) {
            final _data = snapshot.data as LoadedPostsState;
            _postsData = _data.postsData;
            return ListView.builder(
              shrinkWrap: true,
              itemCount: _postsData.length,
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => PostDetailScreen(postId: _postsData[index].id,),
                    ),
                  ),
                  child: PostCard(postsData: _postsData[index]),
                );
              },
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
