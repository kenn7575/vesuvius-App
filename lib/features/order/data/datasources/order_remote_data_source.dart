import 'package:app/features/order/data/models/order_model.dart';
import 'package:dio/dio.dart';
import '../../../../../core/errors/exceptions.dart';
import '../../../../../core/params/params.dart';
import '../models/order_item_model.dart';

abstract class OrderRemoteDataSource {
  Future<OrderModel> createNewOrder(
      {required CreateOrderParams createOrderParams});
}

class OrderRemoteDataSourceImpl implements OrderRemoteDataSource {
  final Dio dio;

  OrderRemoteDataSourceImpl({required this.dio});

  @override
  Future<OrderModel> createNewOrder(
      {required CreateOrderParams createOrderParams}) async {
    final response = await dio.get(
      'https://pokeapi.co/api/v2/pokemon/',
      queryParameters: {
        'api_key': 'if needed',
      },
    );
    // TODO: add create logic

    if (response.statusCode == 200) {
      return OrderModel.fromJson(json: response.data);
    } else {
      throw ServerException();
    }
  }
}
