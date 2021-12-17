import 'package:flutter/material.dart';
import 'utils/main_navigation.dart';
import 'utils/db.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final Db _db = Db();

  /// Создание базы данных
  _db.database();

  runApp(const Home());
}

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: MainNavigation().routes,
      initialRoute: MainNavigation().initialRouteMain,
    );
  }
}