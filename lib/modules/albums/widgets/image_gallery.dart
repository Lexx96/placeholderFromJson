import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import '../model/albums_model.dart';

/// Виджет full screen image
class ImageGalleryWidget extends StatefulWidget {
  PageController pageController = PageController();
  final List<AlbumsModel> images;
  final int index;
  ImageGalleryWidget({Key? key, required this.images, this.index = 0}) : pageController = PageController(initialPage: index);

  @override
  _ImageGalleryWidgetState createState() => _ImageGalleryWidgetState();
}

class _ImageGalleryWidgetState extends State<ImageGalleryWidget> {
  @override
  Widget build(BuildContext context) {
    return PhotoViewGallery.builder(
      scrollPhysics: const BouncingScrollPhysics(),
      pageController: widget.pageController,
      itemCount: widget.images.length,
      builder: (context, index) {
        final images = widget.images[index];
        return PhotoViewGalleryPageOptions(
            imageProvider: NetworkImage(images.url),
          minScale: PhotoViewComputedScale.contained,
          maxScale: PhotoViewComputedScale.contained * 4,
        );
      },
      loadingBuilder: (context, event) => Center(
        child: SizedBox(
          width: 30.0,
          height: 30.0,
          child: CircularProgressIndicator(
            value: event == null
                ? 0
                : event.cumulativeBytesLoaded / event.expectedTotalBytes!.toInt(),
          ),
        ),
      ),
    );
  }
}
