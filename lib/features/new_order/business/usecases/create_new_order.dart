import 'package:app/features/new_order/business/entities/order_entiry.dart';
import 'package:app/features/new_order/business/repositories/order_repository.dart';
import 'package:dartz/dartz.dart';
import '../../../../../core/errors/failure.dart';
import '../../../../../core/params/params.dart';

class CreateNewOrder {
  final OrderRepository newOrderRepository;

  CreateNewOrder({required this.newOrderRepository});

  Future<Either<Failure, OrderEntity>> call({
    required CreateOrderParams createOrderParams,
  }) async {
    return await newOrderRepository.createNewOrder(
        createOrderParams: createOrderParams);
  }
}
