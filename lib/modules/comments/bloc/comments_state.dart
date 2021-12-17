import '../model/comments_model.dart';

/// Состояния модуля комментариев
class CommentsState {
  CommentsState();
  factory CommentsState.loadedPostsState(List<CommentsModel> postsData) = LoadedCommentsState;
  factory CommentsState.createCommentsState(bool isCreate) = CreateCommentsState;
}

/// Состояние успешной загрузки комментариев
class LoadedCommentsState extends CommentsState {
  List<CommentsModel> commentsData;
  LoadedCommentsState(this.commentsData);
}

/// Состаяние статуса размещения нового поста
class CreateCommentsState extends CommentsState {
  bool isCreate;
  CreateCommentsState(this.isCreate);
}