import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import '../model/albums_model.dart';

/// Виджет full screen image
class ImageGalleryWidget extends StatefulWidget {
  final List<AlbumsModel> images;
  final int index;

  const ImageGalleryWidget({Key? key, required this.images, this.index = 0})
      : super(key: key);

  @override
  _ImageGalleryWidgetState createState() => _ImageGalleryWidgetState();
}

class _ImageGalleryWidgetState extends State<ImageGalleryWidget> {
  final ValueNotifier _data = ValueNotifier('');
  PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: widget.index);
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          PhotoViewGallery.builder(
            scrollPhysics: const BouncingScrollPhysics(),
            pageController: _pageController,
            itemCount: widget.images.length,
            builder: (context, index) {
              final images = widget.images[index];
              _updateTitle(images.title);

              return PhotoViewGalleryPageOptions.customChild(
                minScale: PhotoViewComputedScale.contained,
                maxScale: PhotoViewComputedScale.contained * 4,
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(images.url),
                    ),
                  ),
                ),
              );
            },
            loadingBuilder: (context, event) {
              return Center(
                child: SizedBox(
                  width: 30.0,
                  height: 30.0,
                  child: CircularProgressIndicator(
                    value: event == null
                        ? 0
                        : event.cumulativeBytesLoaded /
                            event.expectedTotalBytes!.toInt(),
                  ),
                ),
              );
            },
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: ValueListenableBuilder(
                  valueListenable: _data,
                  builder: (context, title, _) {
                    return Text(
                      _data.value.toString(),
                      style:
                          const TextStyle(color: Colors.white, fontSize: 24.0),
                      maxLines: DefaultTextStyle.of(context).maxLines,
                      overflow: TextOverflow.fade,
                    );
                  },
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  /// Обновление описания изображения
  /// Принимает String [title]
  void _updateTitle(String title) async {
    await Future.delayed(
      const Duration(microseconds: 1),
    );
    _data.value = title;
  }
}
