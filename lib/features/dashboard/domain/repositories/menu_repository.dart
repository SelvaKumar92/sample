import 'package:plateron/core/interface/data_response.dart';
import 'package:plateron/features/dashboard/data/model/menu.dart';

abstract class MenuRepository {
  Future<DataResponse<List<Menu>>> fetchMenus();
}
