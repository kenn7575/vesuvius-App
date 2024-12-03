import 'package:app/core/constants/constants.dart';
import 'package:app/core/errors/failure.dart';
import 'package:app/core/security/authenticated_dio_client.dart';
import 'package:app/features/order/data/models/order_model.dart';
import 'package:app/core/errors/exceptions.dart';
import 'package:app/core/params/params.dart';
import 'package:app/features/order/data/models/params/create_order_params_model.dart';
import 'package:dio/dio.dart';

abstract class OrderRemoteDataSource {
  Future<OrderModel> createNewOrder(
      {required CreateOrderParamsModel createOrderParams});
}

class OrderRemoteDataSourceImpl implements OrderRemoteDataSource {
  final AuthenticatedDioClient dioWithAuth;

  OrderRemoteDataSourceImpl({required this.dioWithAuth});

  @override
  Future<OrderModel> createNewOrder(
      {required CreateOrderParamsModel createOrderParams}) async {
    try {
      final response = await dioWithAuth.client.post(
        '$kBackendUrl/orders',
        data: createOrderParams.toJson(),
      );
      return OrderModel.fromJson(json: response.data);
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
