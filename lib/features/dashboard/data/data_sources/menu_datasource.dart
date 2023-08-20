import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';
import 'package:plateron/features/dashboard/data/model/menu.dart';

abstract class MenuDataSource {
  Future<List<Menu>> fetchMenus();
}

/// Manages Menu details
@Injectable(as: MenuDataSource)
class MenuDataSourceImpl implements MenuDataSource {
  const MenuDataSourceImpl();

  /// fetch Menu list
  @override
  Future<List<Menu>> fetchMenus() async {
    final data = await rootBundle.loadString('assets/data/menus.json');
    return (jsonDecode(data) as List).map((dynamic e) => Menu.fromJson(e as Map<String, dynamic>)).toList();
  }
}
