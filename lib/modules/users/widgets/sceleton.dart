import 'package:flutter/material.dart';
import 'package:skeletons/skeletons.dart';

/// Виджет скилетона
class SkeletonWidget extends StatelessWidget {
  const SkeletonWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: 100,
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          padding: const EdgeInsets.all(8.0),
          decoration: const BoxDecoration(color: Colors.white),
          child: SkeletonItem(
            child: Column(
              children: [
                Row(
                  children: [
                    const SkeletonAvatar(
                      style: SkeletonAvatarStyle(
                        shape: BoxShape.circle,
                        width: 70,
                        height: 70,
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Expanded(
                      child: SkeletonParagraph(
                        style: SkeletonParagraphStyle(
                            lines: 2,
                            spacing: 6,
                            lineStyle: SkeletonLineStyle(
                              randomLength: true,
                              height: 10,
                              borderRadius: BorderRadius.circular(8),
                              minLength: MediaQuery.of(context).size.width / 6,
                              maxLength: MediaQuery.of(context).size.width / 3,
                            )),
                      ),
                    ),
                    SkeletonLine(
                      style: SkeletonLineStyle(
                          height: 16,
                          width: 40,
                          borderRadius: BorderRadius.circular(8)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
