import 'dart:async';
import '../model/comments_model.dart';
import '../service/comments_servise.dart';
import 'comments_state.dart';

/// Управление состояниями модуля комментариев
class CommentsBloc {
  final _commentsStreamController = StreamController<CommentsState>();
  Stream<CommentsState> get postStreamController => _commentsStreamController.stream;

  final _addCommentsStreamController = StreamController<CommentsState>();
  Stream<CommentsState> get addCommentsStreamController => _addCommentsStreamController.stream;

  /// Получение коментариев поста
  /// Принимает id поста int [postId]
  void getCommentsForPostBloc ({required int postId}) async {
    List<CommentsModel> commentsData = await CommentsService().getCommentsForPost(postId: postId);
    _commentsStreamController.sink.add(CommentsState.loadedPostsState(commentsData));
  }

  /// Создание комментария
  /// Принимает String [name] - Имя пользователя, String [email] - Адрес электронной почты, String [body] - Комментарий
  void postCommentsPostBloc ({required String name, required String email, required String body}) async {
    final _isCreate = await CommentsService().postCommentsPost(name: name, email: email, body: body);
    _addCommentsStreamController.sink.add(CommentsState.createCommentsState(_isCreate));
  }

  void dispose () {
    _commentsStreamController.close();
    _addCommentsStreamController.close();
  }
}