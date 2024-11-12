import 'package:app/core/constants/constants.dart';
import 'package:app/core/errors/failure.dart';
import 'package:dio/dio.dart';
import '../../../../../core/errors/exceptions.dart';
import '../models/menu_item_types_model.dart';

abstract class MenuItemTypesRemoteDataSource {
  Future<MenuItemTypesModel> getMenuItemTypes();
}

class MenuItemTypesRemoteDataSourceImpl
    implements MenuItemTypesRemoteDataSource {
  final Dio dio;

  MenuItemTypesRemoteDataSourceImpl({required this.dio});

  @override
  Future<MenuItemTypesModel> getMenuItemTypes() async {
    try {
      final response = await dio.get(
        '$kBackendUrl/menu_item_types',
      );

      return MenuItemTypesModel.fromJson(json: response.data);
    } on DioException catch (e) {
      if (e.response != null) {
        throw ServerFailure(
            errorMessage: e.response?.data['message'] ?? "",
            statusCode: e.response?.statusCode);
      } else {
        throw ServerException();
      }
    } catch (e) {
      throw ServerException();
    }
  }
}
