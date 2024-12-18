import 'package:app/core/params/params.dart';
import 'package:app/features/order/business/entities/order_entiry.dart';
import 'package:app/features/order/data/models/params/create_order_params_model.dart';
import 'package:dartz/dartz.dart';
import 'package:app/core/errors/failure.dart';

abstract class OrderRepository {
  Future<Either<Failure, OrderEntity>> createNewOrder({
    required CreateOrderParamsModel createOrderParams,
  });
  Future<Either<Failure, OrderEntity>> getOrder(
      {required GetOrderParams getOrderParams});
}
