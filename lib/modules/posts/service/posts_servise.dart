import 'dart:convert';
import 'package:http/http.dart';
import '../model/posts_model.dart';
import '../repository/posts_repository.dart';

/// Сервис обработки запросов модуля постов
class PostsService {
  /// Получение постов по userId с лимитом
  /// Принимает id пользователя int [userId] и кол-во постов int [limit]
  Future getLimitPosts({required int userId, required int limit}) async {
    final Response response =
        await PostsRepository.getLimitPosts(userId: userId, limit: limit);

    if (response.statusCode == 200) {
      try {
        final postsJsonDecodeList = jsonDecode(response.body) as List<dynamic>;
        final postsModel = postsJsonDecodeList
            .map((dynamic e) => PostsModel.fromJson(e as Map<String, dynamic>))
            .toList();
        return postsModel;
      } catch (e) {
        throw Exception(e);
      }
    } else if (response.statusCode == 400) {
      throw Exception('неправильный, некорректный запрос');
    }
  }

  /// Получение всех постов пользователя
  /// Принимает id пользователя int [userId]
  Future getAllPosts({required int userId}) async {
    final Response response = await PostsRepository.getAllPosts(userId: userId);

    if (response.statusCode == 200) {
      try {
        final postsJsonDecodeList = jsonDecode(response.body) as List<dynamic>;
        final postsModel = postsJsonDecodeList
            .map((dynamic e) => PostsModel.fromJson(e as Map<String, dynamic>))
            .toList();
        return postsModel;
      } catch (e) {
        throw Exception(e);
      }
    } else if (response.statusCode == 400) {
      throw Exception('неправильный, некорректный запрос');
    }
  }

  /// Получение детальной информации поста пользователя
  /// Принимает id поста int [postId]
  Future getDetailPosts({required int postId}) async {
    final Response response =
        await PostsRepository.getDetailPost(postId: postId);

    if (response.statusCode == 200) {
      try {
        final postsJsonDecodeList = jsonDecode(response.body);
        List<dynamic> data = [postsJsonDecodeList];
        final postsDetailModel = data
            .map((dynamic e) => PostsModel.fromJson(e as Map<String, dynamic>))
            .toList();
        return postsDetailModel;
      } catch (e) {
        throw Exception(e);
      }
    } else if (response.statusCode == 400) {
      throw Exception('неправильный, некорректный запрос');
    }
  }
}
