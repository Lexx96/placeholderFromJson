import 'package:flutter/material.dart';
import '../../utils/main_navigation.dart';
import 'bloc/comments_bloc.dart';
import 'bloc/comments_state.dart';

/// Экран с формой создания поста
class CommentsAddFormScreen extends StatefulWidget {
  const CommentsAddFormScreen({Key? key}) : super(key: key);

  @override
  _CommentsAddFormScreenState createState() => _CommentsAddFormScreenState();
}

class _CommentsAddFormScreenState extends State<CommentsAddFormScreen> {
  final _emailTextController = TextEditingController();
  final _bodyTextController = TextEditingController();
  late CommentsBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = CommentsBloc();
    _bloc.addCommentsStreamController.listen((status) {
      final _data = status as CreateCommentsState;
      if (_data.isCreate) {
        _dialogConfirm();
      }
      else {
        _dialogError();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _bloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Новый комментарий'),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                const Text(
                  'Добавить комментарий',
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                ),
                TextField(
                  decoration: const InputDecoration(
                    hintText: 'Имя',
                  ),
                  controller: _emailTextController,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: TextField(
                    decoration: const InputDecoration(
                      hintText: 'Email',
                    ),
                    controller: _emailTextController,
                  ),
                ),
                TextField(
                  maxLines: DefaultTextStyle.of(context).maxLines,
                  minLines: 10,
                  decoration: const InputDecoration(
                    hintText: 'Описание',
                  ),
                  controller: _bodyTextController,
                ),
                ElevatedButton(
                    onPressed: () => _bloc.postCommentsPostBloc(
                        name: _emailTextController.text,
                        email: _emailTextController.text,
                        body: _bodyTextController.text,
                    ), child: const Text('Добавить комментарий'))
              ],
            ),
          )
        ],
      ),
    );
  }

  /// Диалоговое окно успешного размещения поста
  _dialogConfirm() {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          content: const Text('Комментарий добавлен!'),
          actions: [
            TextButton(
                onPressed: () => Navigator.of(context)
                    .pushNamed(MainNavigationRouteName.usersScreen),
                child: const Text('ОК'))
          ],
        );
      }
    );
  }

  /// Диалоговое окно ошибки
  _dialogError() {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          content: const Text('Ошибка при добавлении комментария'),
          actions: [
            TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('ОК'))
          ],
        );
      }
    );
  }
}
