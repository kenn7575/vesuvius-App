import 'package:app/core/errors/failure.dart';
import 'package:app/features/select_table_for_order/business/entities/table_entiry.dart';
import 'package:dartz/dartz.dart';

abstract class TableRepository {
  Future<Either<Failure, List<TableEntity>>> getTables();
}
