import 'package:flutter_test/flutter_test.dart';
import 'package:plateron/features/checkout/presentation/bloc/cart_bloc.dart';
import 'package:plateron/features/dashboard/data/model/menu.dart';

void main() {
  final data = [Menu(quantity: 1.0, title: '', productId: '1', amount: 12)];
  final updatedData = [Menu(quantity: 2.0, title: '', productId: '1', amount: 12)];
  final finalData = [Menu(quantity: 3.0, title: '', productId: '1', amount: 12)];

  group('menu list bloc', () {
    test('addItem', () async {
      final bloc = CartBloc();
      final expected = [
        CartState(data, 12),
      ];
      expectLater(bloc.stream, emitsInOrder(expected));
      // act
      bloc.add(CartEvent.addItem(data.first)); // act
    });
    test('addItem & update', () async {
      final bloc = CartBloc();
      final expected = [
        CartState(data, 12),
        CartState(updatedData, 24),
      ];
      expectLater(bloc.stream, emitsInOrder(expected));
      // act
      bloc.add(CartEvent.addItem(data.first)); // act
      bloc.add(CartEvent.addItem(updatedData.first)); // act
    });
    test('addItem & delete', () async {
      final bloc = CartBloc();
      final expected = [
        CartState(data, 12),
        CartState([], 0),
      ];
      expectLater(bloc.stream, emitsInOrder(expected));
      // act
      bloc.add(CartEvent.addItem(data.first)); // act
      bloc.add(CartEvent.deleteItem(updatedData.first));
    });
    test('addItem, update & delete', () async {
      final bloc = CartBloc();
      final expected = [
        CartState(data, 12),
        CartState(updatedData, 24),
        CartState(finalData, 12),
      ];
      expectLater(bloc.stream, emitsInOrder(expected));
      // act
      bloc.add(CartEvent.addItem(data.first));
      bloc.add(CartEvent.addItem(updatedData.first)); // act
      bloc.add(CartEvent.deleteItem(finalData.first));
    });
  });
}
