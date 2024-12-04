import 'package:app/core/security/authenticated_dio_client.dart';
import 'package:app/features/select_table_for_order/business/entities/table_entiry.dart';
import 'package:app/features/select_table_for_order/business/usecases/get_tables.dart';
import 'package:app/features/select_table_for_order/data/datasources/table_remote_data_source.dart';
import 'package:app/features/select_table_for_order/data/repositories/table_repository_impl.dart';
import 'package:data_connection_checker_tv/data_connection_checker.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:app/core/connection/network_info.dart';
import 'package:app/core/errors/failure.dart';

class TableProvider extends ChangeNotifier {
  List<TableEntity>? tables;
  Failure? failure;
  final Set<TableEntity> selectedTables = {};

  TableProvider({
    this.tables,
    this.failure,
  });

  void eitherFailureOrTable() async {
    TableRepositoryImpl repository = TableRepositoryImpl(
      remoteDataSource: TableRemoteDataSourceImpl(
        dioAuth: AuthenticatedDioClient(),
      ),
      networkInfo: NetworkInfoImpl(
        DataConnectionChecker(),
      ),
    );

    final failureOrReservations =
        await GetTables.getTables(tableRepository: repository).call();

    failureOrReservations.fold(
      (Failure newFailure) {
        tables = null;
        failure = newFailure;
        notifyListeners();
      },
      (List<TableEntity> newTables) {
        tables = newTables;
        failure = null;
        notifyListeners();
      },
    );
  }
}
