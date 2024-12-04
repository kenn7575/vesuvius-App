import 'package:app/core/constants/constants.dart';
import 'package:app/core/errors/failure.dart';
import 'package:app/core/security/authenticated_dio_client.dart';
import 'package:app/features/select_table_for_order/data/models/table_model.dart';
import 'package:dio/dio.dart';
import 'package:app/core/errors/exceptions.dart';

abstract class TableRemoteDataSource {
  Future<List<TableModel>> getTables();
}

class TableRemoteDataSourceImpl implements TableRemoteDataSource {
  final AuthenticatedDioClient dioAuth;

  TableRemoteDataSourceImpl({required this.dioAuth});

  @override
  Future<List<TableModel>> getTables() async {
    try {
      final response = await dioAuth.client.get(
        '$kBackendUrl/tables',
      );

      return TableModel.fromJsonList(response.data);
    } on DioException catch (e) {
      if (e.response != null) {
        final message =
            e.response?.data is Map ? e.response?.data['message'] : null;
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
