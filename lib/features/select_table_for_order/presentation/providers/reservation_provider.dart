import 'package:app/features/select_table_for_order/business/entities/reservation_entity.dart';
import 'package:data_connection_checker_tv/data_connection_checker.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:app/core/connection/network_info.dart';
import 'package:app/core/errors/failure.dart';
import '../../business/usecases/get_reservations.dart';
import '../../data/datasources/reservation_remote_data_source.dart';
import '../../data/repositories/reservation_repository_impl.dart';

class ReservationProvider extends ChangeNotifier {
  List<ReservationEntity>? reservations;
  Failure? failure;

  ReservationProvider({
    this.reservations,
    this.failure,
  });

  void eitherFailureOrReservation() async {
    ReservationRepositoryImpl repository = ReservationRepositoryImpl(
      remoteDataSource: ReservationRemoteDataSourceImpl(
        dio: Dio(),
      ),
      networkInfo: NetworkInfoImpl(
        DataConnectionChecker(),
      ),
    );

    final failureOrReservations =
        await GetReservations.getReservations(reservationRepository: repository)
            .call();

    failureOrReservations.fold(
      (Failure newFailure) {
        reservations = null;
        failure = newFailure;
        notifyListeners();
      },
      (List<ReservationEntity> newReservations) {
        reservations = newReservations;
        failure = null;
        notifyListeners();
      },
    );
  }
}
