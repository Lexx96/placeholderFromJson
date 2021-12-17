import 'dart:async';
import 'posts_state.dart';
import '../model/posts_model.dart';
import '../service/posts_servise.dart';

/// Управление состояниями модуля постов
class PostsBloc {
  final _postsUserStreamController = StreamController<PostsState>();
  Stream<PostsState> get postStreamController => _postsUserStreamController.stream;

  final _postsUserScreenStreamController = StreamController<PostsState>();
  Stream<PostsState> get postUserScreenStreamController => _postsUserScreenStreamController.stream;

  final _postsUserDetailStreamController = StreamController<PostsState>();
  Stream<PostsState> get postUserDetailStreamController => _postsUserDetailStreamController.stream;

  /// Получение постов по userId с лимитом
  /// Принимает id пользователя int [userId] и кол-во постов int [limit]
  void getPostsUserLimitBloc ({required int userId, required int limit}) async {
    List<PostsModel> postsData = await PostsService().getLimitPosts(userId: userId, limit: limit);
    _postsUserStreamController.sink.add(PostsState.loadedPostsState(postsData));
  }

  /// Получение всех постов пользователя
  /// Принимает id пользователя int [userId]
  void getPostsUserAllScreenBloc ({required int userId}) async {
    List<PostsModel> postsData = await PostsService().getAllPosts(userId: userId);
    _postsUserScreenStreamController.sink.add(PostsState.loadedPostsState(postsData));
  }

  /// Получение детальной информации поста пользователя
  /// Принимает id поста int [postId]
  void getPostsUserDetailScreenBloc ({required int postId}) async {
    List<PostsModel> detailPostData = await PostsService().getDetailPosts(postId: postId);
    _postsUserDetailStreamController.sink.add(PostsState.loadedPostsState(detailPostData));
  }

  void dispose () {
    _postsUserStreamController.close();
    _postsUserScreenStreamController.close();
  }
}