import 'package:injectable/injectable.dart';
import 'package:plateron/core/error/failures.dart';
import 'package:plateron/core/interface/data_response.dart';
import 'package:plateron/features/dashboard/data/data_sources/menu_datasource.dart';
import 'package:plateron/features/dashboard/data/model/menu.dart';
import 'package:plateron/features/dashboard/domain/repositories/menu_repository.dart';

/// Retrieves login status
@Injectable(as: MenuRepository)
class MenuRepositoryImpl implements MenuRepository {
  final MenuDataSource dataSource;

  const MenuRepositoryImpl({required this.dataSource});

  @override
  Future<DataResponse<List<Menu>>> fetchMenus() async {
    try {
      final response = await dataSource.fetchMenus();
      return DataResponse.success(response);
    } on Exception catch (e) {
      return DataResponse<List<Menu>>.failure(ServerFailure());
    }
  }
}
