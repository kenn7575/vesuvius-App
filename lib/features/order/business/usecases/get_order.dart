import 'package:app/core/params/params.dart';
import 'package:app/features/order/business/entities/order_entiry.dart';
import 'package:app/features/order/business/repositories/order_repository.dart';
import 'package:app/features/order/data/models/params/create_order_params_model.dart';
import 'package:dartz/dartz.dart';
import 'package:app/core/errors/failure.dart';

class GetOrder {
  final OrderRepository orderRepository;

  GetOrder({required this.orderRepository});

  Future<Either<Failure, OrderEntity>> call({
    required GetOrderParams getOrderParams,
  }) async {
    return await orderRepository.getOrder(getOrderParams: getOrderParams);
  }
}
