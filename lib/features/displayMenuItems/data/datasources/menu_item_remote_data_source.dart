import 'package:app/core/constants/constants.dart';
import 'package:app/core/errors/failure.dart';
import 'package:app/features/displayMenuItems/data/models/menu_item_models.dart';
import 'package:dio/dio.dart';
import '../../../../../core/errors/exceptions.dart';

abstract class MenuItemRemoteDataSource {
  Future<MenuItemModel> getMenuItem();
}

class MenuItemRemoteDataSourceImpl
    implements MenuItemRemoteDataSource {
  final Dio dio;

  MenuItemRemoteDataSourceImpl({required this.dio});

  @override
  Future<MenuItemModel> getMenuItem() async {
    try {
      final response = await dio.get(
        '$kBackendUrl/menu_items',
      );

      return MenuItemModel.fromJson(json: response.data);
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
