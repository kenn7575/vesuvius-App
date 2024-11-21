import 'package:app/core/errors/failure.dart';
import 'package:app/features/select_table_for_order/business/entities/reservation_entity.dart';
import 'package:dartz/dartz.dart';

abstract class ReservationRepository {
  Future<Either<Failure, List<ReservationEntity>>> getReservations();
}
