import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:plateron/features/dashboard/data/data_sources/menu_datasource.dart';
import 'package:plateron/presentation/presentation.dart';

const data = """[
  {
    "title": "1",
    "description": "",
    "image": "",
    "amount": 12.0,
    "quantity": 1.0,
    "productId": "1"
  }
]""";

class MockAssetBundle extends Mock implements AssetBundle {}

Future<void> main() async {
  MockAssetBundle mockAssetBundle = MockAssetBundle();
  MenuDataSource menuDataSource = MenuDataSourceImpl(bundle: mockAssetBundle);

  test('should verify asset', () async {
    when(() => mockAssetBundle.loadString(any())).thenAnswer((realInvocation) async => Future.value(data));
    await menuDataSource.fetchMenus();
    // assert
    verify(() => mockAssetBundle.loadString(any()));
  });
}
