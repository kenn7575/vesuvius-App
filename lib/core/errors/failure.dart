import 'package:app/core/params/params.dart';

abstract class Failure {
  final String errorMessage;
  const Failure({required this.errorMessage});
}

class ServerFailure extends Failure {
  final int? statusCode;
  ServerFailure({required super.errorMessage, this.statusCode});
}

class CacheFailure extends Failure {
  CacheFailure({required super.errorMessage});
}

class ValidationFailure<T> extends Failure {
  final Map<String, List<String>> fieldErrors;

  ValidationFailure({
    required super.errorMessage,
    required this.fieldErrors,
  });

  List<String>? getFieldError(String fieldName) {
    return fieldErrors[fieldName];
  }
}
