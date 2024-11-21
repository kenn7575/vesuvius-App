import 'package:app/core/constants/constants.dart';
import 'package:app/core/errors/failure.dart';
import 'package:app/features/select_table_for_order/data/models/reservation_model.dart';
import 'package:dio/dio.dart';
import 'package:app/core/errors/exceptions.dart';

abstract class ReservationRemoteDataSource {
  Future<List<ReservationModel>> getReservations();
}

class TemplateRemoteDataSourceImpl implements ReservationRemoteDataSource {
  final Dio dio;

  TemplateRemoteDataSourceImpl({required this.dio});

  @override
  Future<List<ReservationModel>> getReservations() async {
    try {
      final response = await dio.get(
        '$kBackendUrl/reservations',
      );
      //TODO : add access control here

      return ReservationModel.fromJsonList(response.data);
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
