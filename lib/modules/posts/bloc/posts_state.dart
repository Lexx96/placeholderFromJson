import '../model/posts_model.dart';

/// Состояния модуля постов
class PostsState {
  PostsState();
  factory PostsState.loadedPostsState(List<PostsModel> postsData) = LoadedPostsState;
}

/// Состояние успешной загрузки
class LoadedPostsState extends PostsState {
  List<PostsModel> postsData;
  LoadedPostsState(this.postsData);
}