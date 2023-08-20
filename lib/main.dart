import 'package:flutter/material.dart';
import 'package:plateron/core/injection/injection.dart';
import 'package:plateron/features/dashboard/presentaion/pages/menu_list_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureInjection();
  runApp(const MaterialApp(home: MenuListPage()));
}
