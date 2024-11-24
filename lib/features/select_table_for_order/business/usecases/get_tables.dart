import 'package:app/core/errors/failure.dart';
import 'package:app/features/select_table_for_order/business/entities/table_entiry.dart';
import 'package:app/features/select_table_for_order/business/repositories/table_repository.dart';
import 'package:dartz/dartz.dart';

class GetTables {
  final TableRepository tableRepository;

  GetTables.getTables({required this.tableRepository});

  Future<Either<Failure, List<TableEntity>>> call() async {
    return await tableRepository.getTables();
  }
}
