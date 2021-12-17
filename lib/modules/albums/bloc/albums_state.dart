import '../model/albums_model.dart';

/// Состояния модуля альбомов
class AlbumsState {
  AlbumsState();
  factory AlbumsState.loadedAlbumsState(List<AlbumsModel> albumsData) = LoadedAlbumsState;
}

/// Состояние успешной загрузки
class LoadedAlbumsState extends AlbumsState {
  List<AlbumsModel> albumsData;
  LoadedAlbumsState(this.albumsData);
}