import 'package:flutter/material.dart';
import '../comments/widgets/comments_add_button.dart';
import '../comments/widgets/comments_block.dart';
import '../users/widgets/user_card_info.dart';
import 'bloc/posts_bloc.dart';
import 'bloc/posts_state.dart';
import 'model/posts_model.dart';

/// Экран вывода подробной информации о посте
class PostDetailScreen extends StatefulWidget {
  final int postId;
  const PostDetailScreen({Key? key, required this.postId}) : super(key: key);

  @override
  State<PostDetailScreen> createState() => _PostDetailScreenState();
}

class _PostDetailScreenState extends State<PostDetailScreen> {
  late PostsBloc _bloc;
  List<PostsModel> _detailPostsData = [];

  @override
  void initState() {
    super.initState();
    _bloc = PostsBloc();
    _bloc.getPostsUserDetailScreenBloc(postId: widget.postId);
  }

  @override
  void dispose() {
    super.dispose();
    _bloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          const SizedBox(height: 50.0),
          const UserCardInfo(),
          StreamBuilder(
            stream: _bloc.postUserDetailStreamController,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.data is LoadedPostsState) {
                final _data = snapshot.data as LoadedPostsState;
                _detailPostsData = _data.postsData;

                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: _detailPostsData.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(_detailPostsData[index].title, style: const TextStyle(fontWeight: FontWeight.bold)),
                                const SizedBox(height: 10.0),
                                Text(_detailPostsData[index].body)
                              ],
                            ),
                          );
                        }
                      ),
                      const Divider(),
                      const Padding(
                        padding: EdgeInsets.all(15.0),
                        child: CommentsBlock(postId: 1),
                      ),
                      const CommentsAddButton()
                    ],
                  ),
                );
              }

              return const SizedBox.shrink();
            },
          ),
        ],
      ),
    );
  }
}