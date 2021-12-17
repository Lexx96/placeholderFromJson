import 'package:flutter/material.dart';
import '../bloc/comments_bloc.dart';
import '../bloc/comments_state.dart';
import '../model/comments_model.dart';

/// Виджета блока с комментариями к посту
class CommentsBlock extends StatefulWidget {
  final int postId;
  const CommentsBlock({Key? key, required this.postId}) : super(key: key);

  @override
  _CommentsBlocState createState() => _CommentsBlocState();
}

class _CommentsBlocState extends State<CommentsBlock> {
  late final CommentsBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = CommentsBloc();
    _bloc.getCommentsForPostBloc(postId: widget.postId);
  }

  @override
  void dispose() {
    super.dispose();
    _bloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Комментарии:', style: TextStyle(fontWeight: FontWeight.bold)),
        StreamBuilder(
            stream: _bloc.postStreamController,
            builder: (BuildContext context, AsyncSnapshot snapshot) {

              if (snapshot.data is LoadedCommentsState) {
                final _data = snapshot.data as LoadedCommentsState;
                List<CommentsModel> _commentsData = _data.commentsData;

                return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: _commentsData.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(_commentsData[index].email, style: const TextStyle(fontStyle: FontStyle.italic)),
                            Text(_commentsData[index].name, style: TextStyle(fontWeight: FontWeight.bold)),
                            Text(_commentsData[index].body),
                          ],
                        ),
                      );
                    }
                );
              }

              return const SizedBox.shrink();
            }
        )
      ],
    );
  }
}
