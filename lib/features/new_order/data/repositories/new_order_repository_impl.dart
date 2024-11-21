import 'package:app/features/new_order/data/models/order_model.dart';
import 'package:dartz/dartz.dart';
import 'package:app/core/connection/network_info.dart';
import 'package:app/core/errors/exceptions.dart';
import 'package:app/core/errors/failure.dart';
import 'package:app/core/params/params.dart';
import '../../business/repositories/new_order_repository.dart';
import '../datasources/new_order_remote_data_source.dart';

class NewOrderRepositoryImpl implements NewOrderRepository {
  final OrderRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  NewOrderRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, OrderModel>> createNewOrder(
      {required CreateOrderParams createOrderParams}) async {
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
}
