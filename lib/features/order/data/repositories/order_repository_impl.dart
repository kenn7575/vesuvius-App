import 'package:app/features/order/business/repositories/order_repository.dart';
import 'package:app/features/order/data/models/order_model.dart';
import 'package:app/features/order/data/models/params/create_order_params_model.dart';
import 'package:dartz/dartz.dart';
import 'package:app/core/connection/network_info.dart';
import 'package:app/core/errors/exceptions.dart';
import 'package:app/core/errors/failure.dart';
import 'package:app/core/params/params.dart';
import '../datasources/order_remote_data_source.dart';

class OrderRepositoryImpl implements OrderRepository {
  final OrderRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  OrderRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, OrderModel>> createNewOrder(
      {required CreateOrderParamsModel createOrderParams}) async {
    if (await networkInfo.isConnected!) {
      try {
        OrderModel createdOrder = await remoteDataSource.createNewOrder(
            createOrderParams: createOrderParams);

        return Right(createdOrder);
      } on ServerException {
        return Left(ServerFailure(errorMessage: 'This is a server exception'));
      }
    } else {
      // no internet
      return Left(CacheFailure(errorMessage: 'No internet connection.'));
    }
  }

  @override
  Future<Either<Failure, OrderModel>> getOrder(
      {required GetOrderParams getOrderParams}) async {
    if (await networkInfo.isConnected!) {
      try {
        OrderModel order =
            await remoteDataSource.getOrder(getOrderParams: getOrderParams);
        return Right(order);
      } on ServerException {
        return Left(ServerFailure(errorMessage: 'This is a server exception'));
      }
    } else {
      return Left(CacheFailure(errorMessage: 'No internet connection.'));
    }
  }
}
