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
  final AssetBundle bundle;

  const MenuDataSourceImpl({required this.bundle});

  /// fetch Menu list
  @override
  Future<List<Menu>> fetchMenus() async {
    final data = await bundle.loadString('assets/data/menus.json');
    return (jsonDecode(data) as List).map((dynamic e) => Menu.fromJson(e as Map<String, dynamic>)).toList();
  }
}
