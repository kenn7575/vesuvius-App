import 'package:app/features/order/business/entities/order_entiry.dart';
import 'package:dartz/dartz.dart';
import 'package:app/core/errors/failure.dart';
import 'package:app/core/params/params.dart';

abstract class OrderRepository {
  Future<Either<Failure, OrderEntity>> createNewOrder({
    required CreateOrderParams createOrderParams,
  });
}
