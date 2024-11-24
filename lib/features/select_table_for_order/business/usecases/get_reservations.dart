import 'package:app/core/errors/failure.dart';
import 'package:app/features/select_table_for_order/business/entities/reservation_entity.dart';
import 'package:dartz/dartz.dart';
import '../repositories/reservation_repository.dart';

class GetReservations {
  final ReservationRepository reservationRepository;

  GetReservations.getReservations({required this.reservationRepository});

  Future<Either<Failure, List<ReservationEntity>>> call() async {
    return await reservationRepository.getReservations();
  }
}
