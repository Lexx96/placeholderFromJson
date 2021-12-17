import 'package:flutter/material.dart';
import 'widgets/albums_card.dart';
import 'widgets/image_gallery.dart';
import 'bloc/albums_bloc.dart';
import 'bloc/albums_state.dart';
import 'model/albums_model.dart';

/// Экран списка альбомов
class AlbumsScreen extends StatefulWidget {
  const AlbumsScreen({Key? key}) : super(key: key);

  @override
  _AlbumsScreenState createState() => _AlbumsScreenState();
}

class _AlbumsScreenState extends State<AlbumsScreen> {
  late AlbumsBloc _bloc;
  List<AlbumsModel> _albumsData = [];

  @override
  void initState() {
    super.initState();
    _bloc = AlbumsBloc();
    _bloc.getAlbumsScreenBloc(userId: 3);
  }

  @override
  void dispose() {
    super.dispose();
    _bloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: _bloc.albumsScreenStreamController,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.data is LoadedAlbumsState) {
            final _data = snapshot.data as LoadedAlbumsState;
            _albumsData = _data.albumsData;

            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 5.0,
                crossAxisSpacing: 5.0,
              ),
              itemCount: _albumsData.length,
              itemBuilder: (BuildContext context, int index) {

                return InkWell(
                    splashColor: Colors.transparent,
                    onTap: () => _openGallery(index, _albumsData),
                    child: AlbumsCard(albumsData: _albumsData[index]));
              },
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  /// Открытие виджета показа изображений
  void _openGallery(index, List<AlbumsModel> _allImages) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => ImageGalleryWidget(
          images: _allImages,
          index: index,
        ),
      ),
    );
  }
}
