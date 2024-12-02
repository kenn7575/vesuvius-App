import 'package:dartz/dartz.dart';
import 'package:app/core/errors/failure.dart';
import 'package:app/core/params/params.dart';
import '../entities/template_entity.dart';

abstract class TemplateRepository {
  Future<Either<Failure, TemplateEntity>> getTemplate({
    required TemplateParams templateParams,
  });
}
