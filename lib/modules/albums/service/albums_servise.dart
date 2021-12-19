import 'dart:convert';
import 'package:http/http.dart';
import '../model/albums_model.dart';
import '../repository/albums_repository.dart';

/// Сервис обработки запросов модуля альбомов
class AlbumsService {
  /// Отправка запроса на сервер для получения списка альбомов с указанным лимитом
  /// Принимает int [userId] - id пользователя, int [limit] - кол-во альбомов
  Future getAlbums({required int userId, required int limit}) async {
    final Response response = await AlbumsRepository.getAlbums(userId: userId, limit: limit);

    if(response.statusCode == 200) {
      try{
        final  albumsJsonDecodeList = jsonDecode(response.body) as List<dynamic>;
        final albumsModel = albumsJsonDecodeList.map((dynamic e) => AlbumsModel.fromJson(e as Map<String, dynamic>)).toList();
        return albumsModel;
      }catch(e){
        throw Exception(e);
      }
    }
    throw Exception('неправильный, некорректный запрос');
  }

  /// Отправка запроса на сервер для получение всех альбомов пользователя с пагинацией
  /// Принимает int [userId] - id пользователя, int [start] - стартовая позициязагрузки
  Future getAllAlbums({required int userId, required int start}) async {
    final Response response = await AlbumsRepository.getAllAlbums(userId: userId, start: start);

    if(response.statusCode == 200) {
      try{
        final  albumsJsonDecodeList = jsonDecode(response.body) as List<dynamic>;
        final albumsModel = albumsJsonDecodeList.map((dynamic e) => AlbumsModel.fromJson(e as Map<String, dynamic>)).toList();
        return albumsModel;
      }catch(e){
        throw Exception(e);
      }
    }
    throw Exception('неправильный, некорректный запрос');
  }
}
