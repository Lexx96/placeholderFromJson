import 'dart:convert';
import 'package:http/http.dart';
import '../model/comments_model.dart';
import '../repository/comments_repository.dart';

/// Сервис обработки запросов модуля комментариев
class CommentsService {
  /// Получение комментариев поста
  /// Принимает int [postId] - id поста
  Future getCommentsForPost({required int postId}) async {
    final Response response =
        await CommentsRepository.getCommentsForPost(postId: postId);

    if (response.statusCode == 200) {
      try {
        final postsJsonDecodeList = jsonDecode(response.body) as List<dynamic>;
        final commentsModel = postsJsonDecodeList
            .map((dynamic e) => CommentsModel.fromJson(e as Map<String, dynamic>))
            .toList();
        return commentsModel;
      } catch (e) {
        throw Exception(e);
      }
    } else if (response.statusCode == 400) {
      throw Exception('неправильный, некорректный запрос');
    }
  }

  /// Создание комментария
  /// Принимает String [name] - Имя пользователя, String [email] - Адрес электронной почты, String [body] - Комментарий
  Future postCommentsPost({required String name, required String email, required String body}) async {
    final Map<String, dynamic> model = CommentsModel(name: name, email: email, body: body).toJson();

    final Response response = await CommentsRepository.postCommentsPost(model: model);
    if (response.statusCode == 201) {
      return true;
    }

    return false;
  }
}
