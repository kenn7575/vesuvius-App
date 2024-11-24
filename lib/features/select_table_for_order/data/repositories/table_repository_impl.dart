import 'package:app/features/select_table_for_order/business/repositories/table_repository.dart';
import 'package:app/features/select_table_for_order/data/datasources/table_remote_data_source.dart';
import 'package:app/features/select_table_for_order/data/models/table_model.dart';
import 'package:dartz/dartz.dart';
import 'package:app/core/connection/network_info.dart';
import 'package:app/core/errors/failure.dart';

class TableRepositoryImpl implements TableRepository {
  final TableRemoteDataSourceImpl remoteDataSource;
  final NetworkInfo networkInfo;

  TableRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<TableModel>>> getTables() async {
    if (await networkInfo.isConnected!) {
      try {
        List<TableModel> tables = await remoteDataSource.getTables();

        return Right(tables);
      } on ServerFailure catch (e) {
        return Left(e);
      } on ValidationFailure catch (e) {
        return Left(e);
      }
    } else {
      // If there is no internet connection, we will try to get the data from the cache
      return Left(
        CacheFailure(errorMessage: 'no internet connection'),
      );
    }
  }
}
