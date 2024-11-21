import 'package:app/features/select_table_for_order/data/models/reservation_model.dart';
import 'package:dartz/dartz.dart';
import 'package:app/core/connection/network_info.dart';
import 'package:app/core/errors/failure.dart';
import '../../business/repositories/reservation_repository.dart';
import '../datasources/reservation_remote_data_source.dart';

class ReservationRepositoryImpl implements ReservationRepository {
  final ReservationRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  ReservationRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<ReservationModel>>> getReservations() async {
    if (await networkInfo.isConnected!) {
      try {
        List<ReservationModel> reservations =
            await remoteDataSource.getReservations();

        return Right(reservations);
      } on ServerFailure catch (e) {
        return Left(e);
      } on ValidationFailure catch (e) {
        return Left(e);
      }
    } else {
      // If there is no internet connection, we will try to get the data from the cache
      return Left(CacheFailure(errorMessage: 'no internet connection'));
    }
  }
}
