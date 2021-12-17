import 'package:flutter/material.dart';
import '../../../utils/main_navigation.dart';

/// Виджет кнопки открытия окна с формой заполнения комментария
class CommentsAddButton extends StatelessWidget {
  const CommentsAddButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () {
          Navigator.of(context).pushNamed(MainNavigationRouteName.addCommentPage);
        },
        child: const Text('Добавить комментарий')
    );
  }
}