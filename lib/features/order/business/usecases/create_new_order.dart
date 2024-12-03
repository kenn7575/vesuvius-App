import 'package:app/features/order/business/entities/order_entiry.dart';
import 'package:app/features/order/business/repositories/order_repository.dart';
import 'package:app/features/order/data/models/params/create_order_params_model.dart';
import 'package:dartz/dartz.dart';
import 'package:app/core/errors/failure.dart';

class CreateNewOrder {
  final OrderRepository newOrderRepository;

  CreateNewOrder({required this.newOrderRepository});

  Future<Either<Failure, OrderEntity>> call({
    required CreateOrderParamsModel createOrderParams,
  }) async {
    return await newOrderRepository.createNewOrder(
        createOrderParams: createOrderParams);
  }
}
