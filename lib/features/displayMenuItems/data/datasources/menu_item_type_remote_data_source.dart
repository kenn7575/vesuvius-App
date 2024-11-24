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

      if (e.response != null) {
        final message =
            e.response?.data is Map ? e.response?.data['message'] : null;
        final fieldErrors =
            e.response?.data is Map ? e.response?.data['fieldErrors'] : null;

        if (fieldErrors != null) {
          //there was a validation error
          throw ValidationFailure(
            fieldErrors: (fieldErrors as Map<String, dynamic>).map(
              (key, value) => MapEntry(
                key,
                (value as List).map((e) => e.toString()).toList(),
              ),
            ),
            errorMessage: message ?? 'A validation error occurred',
          );
        } else {
          // there was an error message
          throw ServerFailure(
            errorMessage: message ?? 'An error occurred',
            statusCode: e.response?.statusCode,
          );
        }
      }
      throw ServerFailure(
        errorMessage: 'An error occurred',
        statusCode: null,
      );
    } catch (e) {
      //something else went wrong
      throw ServerException();
    }
  }
}
