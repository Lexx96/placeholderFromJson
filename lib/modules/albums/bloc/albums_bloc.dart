import 'dart:async';
import 'albums_state.dart';
import '../model/albums_model.dart';
import '../service/albums_servise.dart';

/// Управления состояниями модуля альбомов
class AlbumsBloc {
  final _albumsUserStreamController = StreamController<AlbumsState>();
  Stream<AlbumsState> get albumsUserStreamController => _albumsUserStreamController.stream;

  final _albumsScreenStreamController = StreamController<AlbumsState>();
  Stream<AlbumsState> get albumsScreenStreamController => _albumsScreenStreamController.stream;

  /// Получение альбомов с сервера с указанием лимита
  /// Принимает int [userId] - id пользователя, int [limit] - кол-во записей
  void getAlbumsUserBloc ({required int userId, required int limit}) async {
    List<AlbumsModel> _albumsData = await AlbumsService().getAlbums(userId: userId, limit: limit);
    _albumsUserStreamController.sink.add(AlbumsState.loadedAlbumsState(_albumsData));
  }

  /// Получение всех альбомов пользователя с пагинацией
  /// Принимает int [userId] - id пользователя, int [start] - стартовая позициязагрузки
  void getAlbumsScreenBloc ({required int userId, required int start}) async {
    List<AlbumsModel> _albumsData = await AlbumsService().getAllAlbums(userId: userId, start: start);
    _albumsScreenStreamController.sink.add(AlbumsState.loadedAlbumsState(_albumsData));
  }

  void dispose () {
    _albumsUserStreamController.close();
    _albumsScreenStreamController.close();
  }
}