import 'package:flutter/material.dart';
import '../modules/comments/comments_add_form_screen.dart';
import '../modules/users/user_list_screen.dart';

/// Класс параметров навигации
abstract class MainNavigationRouteName {
  static const usersScreen = 'usersScreen';
  static const addCommentPage = 'addCommentPage';
}

/// Класс навигации
class MainNavigation {
  final initialRouteMain = MainNavigationRouteName.usersScreen;

  final routes = <String, Widget Function(BuildContext)>{
    MainNavigationRouteName.usersScreen: (context) => const UsersScreen(),
    MainNavigationRouteName.addCommentPage: (context) => const CommentsAddFormScreen(),
  };
}