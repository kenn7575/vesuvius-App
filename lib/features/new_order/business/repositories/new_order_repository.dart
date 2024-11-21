import 'package:app/features/new_order/business/entities/order_entiry.dart';
import 'package:dartz/dartz.dart';
import '../../../../../core/errors/failure.dart';
import '../../../../../core/params/params.dart';
import '../entities/order_item_entity.dart';

abstract class NewOrderRepository {
  Future<Either<Failure, OrderEntity>> createNewOrder({
    required CreateOrderParams createOrderParams,
  });
}
