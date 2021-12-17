import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../model/posts_model.dart';

/// Карточка поста
class PostCard extends StatelessWidget {
  final PostsModel postsData;
  const PostCard({Key? key, required this.postsData}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Column(
      children: [
        Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        postsData.title,
                        style: const TextStyle(
                            fontSize: 16.0, fontWeight: FontWeight.bold),
                        maxLines: 1,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(postsData.body),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 10.0,
        )
      ],
    );
  }
}
