import 'package:flutter/material.dart';
import 'widgets/albums_card.dart';
import 'widgets/image_gallery.dart';
import 'bloc/albums_bloc.dart';
import 'bloc/albums_state.dart';
import 'model/albums_model.dart';

/// Экран списка альбомов
class AlbumsScreen extends StatefulWidget {
  final int userId;

  const AlbumsScreen({Key? key, required this.userId}) : super(key: key);

  @override
  _AlbumsScreenState createState() => _AlbumsScreenState();
}

class _AlbumsScreenState extends State<AlbumsScreen> {
  late AlbumsBloc _bloc;
  final List<AlbumsModel> _allAlbumsData = [];

  @override
  void initState() {
    super.initState();
    _bloc = AlbumsBloc();
    _bloc.getAlbumsScreenBloc(userId: widget.userId, start: 0);
  }

  @override
  void dispose() {
    super.dispose();
    _bloc.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final _isTurn = MediaQuery.of(context).orientation == Orientation.portrait;

    return Scaffold(
      body: StreamBuilder(
        stream: _bloc.albumsScreenStreamController,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.data is LoadedAlbumsState) {
            final _data = snapshot.data as LoadedAlbumsState;
            _allAlbumsData.addAll(_data.albumsData);

            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: _isTurn ? 2 : 3,
                mainAxisSpacing: 5.0,
                crossAxisSpacing: 5.0,
              ),
              itemCount: _allAlbumsData.length,
              itemBuilder: (BuildContext context, int index) {
                if (index == (_allAlbumsData.length - 2)) {
                  _bloc.getAlbumsScreenBloc(
                      userId: widget.userId,
                      start: _allAlbumsData.length,
                  );
                }

                return InkWell(
                    splashColor: Colors.transparent,
                    onTap: () => _openGallery(index, _allAlbumsData),
                    child: AlbumsCard(albumsData: _allAlbumsData[index]));
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
