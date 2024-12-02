import 'package:app/core/constants/constants.dart';
import 'package:app/core/errors/failure.dart';
import 'package:app/core/params/params.dart';
import 'package:app/features/displayMenuItems/data/models/menu_item_models.dart';
import 'package:dio/dio.dart';
import 'package:app/core/errors/exceptions.dart';

abstract class MenuItemRemoteDataSource {
  Future<List<MenuItemModel>> getMenuItems(
      {required GetMenuItemsParams params});
}

class MenuItemRemoteDataSourceImpl implements MenuItemRemoteDataSource {
  final Dio dio;

  MenuItemRemoteDataSourceImpl({required this.dio});

  @override
  Future<List<MenuItemModel>> getMenuItems(
      {required GetMenuItemsParams params}) async {
    try {
      final response = await dio.get(
        '$kBackendUrl/menu_items?item_type_id=${params.typeId}',
      );

      return MenuItemModel.fromJsonList(response.data);
    } on DioException catch (e) {
      final message =
          e.response?.data is Map ? e.response?.data['message'] : null;
      if (e.response != null) {
        throw ServerFailure(
            errorMessage: message ?? "An error occurred",
            statusCode: e.response?.statusCode);
      } else {
        throw ServerException();
      }
    } catch (e) {
      throw ServerException();
    }
  }
}
