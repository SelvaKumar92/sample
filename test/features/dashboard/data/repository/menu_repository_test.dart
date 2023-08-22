import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:plateron/core/interface/data_response.dart';
import 'package:plateron/features/dashboard/data/data_sources/menu_datasource.dart';
import 'package:plateron/features/dashboard/data/model/menu.dart';
import 'package:plateron/features/dashboard/data/repositories/menu_repository_impl.dart';
import 'package:plateron/features/dashboard/domain/repositories/menu_repository.dart';

class MockMenuDataSource extends Mock implements MenuDataSource {}

Future<void> main() async {
  MockMenuDataSource mockMenuDataSource = MockMenuDataSource();
  MenuRepository menuDataSource = MenuRepositoryImpl(dataSource: mockMenuDataSource);
  final data = [Menu(productId: '1')];

  test('should verify asset', () async {
    when(() => mockMenuDataSource.fetchMenus()).thenAnswer((realInvocation) async => Future.value(data));
    final result = await menuDataSource.fetchMenus();
    // assert
    expect(result, DataResponse<List<Menu>>.success(data));
    verify(() => mockMenuDataSource.fetchMenus());
    verifyNoMoreInteractions(mockMenuDataSource);
  });
}
