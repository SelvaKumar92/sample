import 'package:freezed_annotation/freezed_annotation.dart';

part 'menu.freezed.dart';

part 'menu.g.dart';

@unfreezed
class Menu with _$Menu {
  factory Menu({
    String? productId,
    String? title,
    String? description,
    String? image,
    double? amount,
    double? quantity,
  }) = _Menu;

  Menu._();

  factory Menu.fromJson(Map<String, dynamic> json) => _$MenuFromJson(json);
}
