import 'package:app/features/new_order/business/entities/order_entiry.dart';
import 'package:dartz/dartz.dart';
import '../../../../../core/errors/failure.dart';
import '../../../../../core/params/params.dart';
import '../repositories/new_order_repository.dart';

class CreateNewOrder {
  final NewOrderRepository newOrderRepository;

  CreateNewOrder({required this.newOrderRepository});

  Future<Either<Failure, OrderEntity>> call({
    required CreateOrderParams createOrderParams,
  }) async {
    return await newOrderRepository.createNewOrder(
        createOrderParams: createOrderParams);
  }
}
