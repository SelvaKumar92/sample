import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:plateron/core/error/failures.dart';
import 'package:plateron/core/interface/data_response.dart';
import 'package:plateron/features/dashboard/data/model/menu.dart';
import 'package:plateron/features/dashboard/domain/repositories/menu_repository.dart';
import 'package:plateron/features/dashboard/presentaion/bloc/menu_list_bloc.dart';

class MockMenuRepositoryRepository extends Mock implements MenuRepository {}

//modified
void main() {
  MockMenuRepositoryRepository mockMenuRepositoryRepository = MockMenuRepositoryRepository();
  final bloc = MenuListBloc(mockMenuRepositoryRepository);
  final data = [Menu(quantity: 1.0, title: '', productId: '1')];

  group('menu list bloc', () {
    test('should emit [ MenuListState.loading()] for [MenuListState.loaded([Menu])]', () async {
      when(() => mockMenuRepositoryRepository.fetchMenus())
          .thenAnswer((realInvocation) async => DataResponse.success(data));

      // assert later
      final expected = [
        const MenuListState.loading(),
        MenuListState.loaded(data),
      ];
      expectLater(bloc.stream, emitsInOrder(expected));
      // act
      bloc.add(const MenuListEvent.fetchMenuItems());
    });

    test('should emit [ MenuListState.loading()] for [MenuListState.loaded([Menu])]', () async {
      when(() => mockMenuRepositoryRepository.fetchMenus())
          .thenAnswer((realInvocation) async => DataResponse.failure(ServerFailure()));

      // assert later
      final expected = [
        const MenuListState.loading(),
        const MenuListState.error(),
      ];
      expectLater(bloc.stream, emitsInOrder(expected));
      // act
      bloc.add(const MenuListEvent.fetchMenuItems());
    });
  });
}
