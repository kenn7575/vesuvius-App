import 'package:app/core/constants/constants.dart';
import 'package:app/core/errors/failure.dart';
import 'package:dio/dio.dart';
import '../../../../../core/errors/exceptions.dart';
import '../models/menu_item_type_model.dart';

abstract class MenuItemTypeRemoteDataSource {
  Future<List<MenuItemTypeModel>> getMenuItemTypes();
}

class MenuItemTypeRemoteDataSourceImpl implements MenuItemTypeRemoteDataSource {
  final Dio dio;

  MenuItemTypeRemoteDataSourceImpl({required this.dio});

  @override
  Future<List<MenuItemTypeModel>> getMenuItemTypes() async {
    try {
      final response = await dio.get(
        '$kBackendUrl/menu_item_types',
      );

      return MenuItemTypeModel.fromJsonList(response.data);
    } on DioException catch (e) {
      // something went wrong with the request
      final response = e.response?.data;
      if (response != null && response['fieldErrors'] != null) {
        //there was a validation error
        throw ValidationFailure(
          fieldErrors: response['fieldErrors'],
          errorMessage: response['message']?.toString() ?? '',
        );
      }
      // the request did not go through
      throw ServerFailure(
        errorMessage:
            response?['message']?.toString() ?? 'Network error occurred',
        statusCode: e.response?.statusCode,
      );
    } catch (e) {
      //something else went wrong
      throw ServerException();
    }
  }
}
