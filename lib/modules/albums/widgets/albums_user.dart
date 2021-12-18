import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../bloc/albums_bloc.dart';
import '../bloc/albums_state.dart';
import '../model/albums_model.dart';
import '../widgets/image_gallery.dart';
import '../albums_screen.dart';
import 'albums_card.dart';


/// Виджет списка альбомов пользователя
class AlbumsUser extends StatefulWidget {
  final int userId;

  const AlbumsUser({Key? key, required this.userId}) : super(key: key);

  @override
  _AlbumsUserState createState() => _AlbumsUserState();
}

class _AlbumsUserState extends State<AlbumsUser> {
  late AlbumsBloc _bloc;
  List<AlbumsModel> _albumsData = [];

  @override
  void initState() {
    super.initState();
    _bloc = AlbumsBloc();
    _bloc.getAlbumsUserBloc(userId: widget.userId, limit: 3);
  }

  @override
  void dispose() {
    super.dispose();
    _bloc.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final _isTurn = MediaQuery.of(context).orientation == Orientation.portrait;

    return StreamBuilder(
      stream: _bloc.albumsUserStreamController,
      builder: (BuildContext context, AsyncSnapshot snapshot) {

        if (snapshot.data is LoadedAlbumsState) {
          final _data = snapshot.data as LoadedAlbumsState;
          _albumsData = _data.albumsData;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: _isTurn ? MediaQuery.of(context).size.height * 0.2 : MediaQuery.of(context).size.height * 0.65,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: _albumsData.length,
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      splashColor: Colors.transparent,
                      onTap: () => _openGallery(index, _albumsData),
                      child: AlbumsCard(albumsData: _albumsData[index]),
                    );
                  },
                ),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (_) => AlbumsScreen(userId: widget.userId,),
                )),
                child: const Text('Подробнее'),
              )
            ],
          );
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
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
