import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:plateron/features/dashboard/data/model/menu.dart';

part 'cart_bloc.freezed.dart';

@freezed
class CartEvent with _$CartEvent {
  const factory CartEvent.addItem(Menu menu) = _AddItem;

  const factory CartEvent.deleteItem(Menu menu) = _DeleteItem;
}

@freezed
class CartState with _$CartState {
  const factory CartState(List<Menu> menuItems, double? price) = _Loaded;
}

@singleton
class CartBloc extends Bloc<CartEvent, CartState> {
  List<Menu> cartItems = [];
  double price = 0;

  CartBloc() : super(const CartState([], 0)) {
    on<CartEvent>(
      (event, emit) async {
        await event.when<FutureOr<void>>(addItem: (menu) async {
          final index = cartItems.indexWhere((element) => element.productId == menu.productId);
          if (index == -1) {
            price = price + (menu.amount ?? 0);
            cartItems.add(menu);
          } else {
            menu.quantity = 1.0 + (cartItems[index].quantity ?? 0);
            price = price + (cartItems[index].amount ?? 0);
            cartItems[index] = menu;
          }
          emit(CartState(List.from(cartItems), price));
        }, deleteItem: (menu) async {
          final index = cartItems.indexWhere((element) => element.productId == menu.productId);
          if (index == -1) {
            //Item not found
          } else if (cartItems[index].quantity == 1) {
            price = price - (cartItems[index].amount ?? 0);
            cartItems.removeAt(index);
          } else {
            price = price - (cartItems[index].amount ?? 0);
            menu.quantity = (cartItems[index].quantity ?? 0) - 1.0;
            cartItems[index] = menu;
          }
          emit(CartState(List.from(cartItems), price));
        });
      },
    );
  }
}
