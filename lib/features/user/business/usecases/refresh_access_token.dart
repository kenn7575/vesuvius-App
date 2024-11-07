import 'package:app/features/user/business/repositories/token_repository.dart';
import 'package:app/core/errors/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

class RefreshAccessToken {
  final TokenRepository tokenRepository;
  final ValueNotifier<bool> isAuthenticated = ValueNotifier(true);

  RefreshAccessToken({required this.tokenRepository});

  Future<Either<Failure, Null>> call() async {
    Either<Failure, Null> response = await tokenRepository.refreshAccessToken();
    if (response is Left) {
      isAuthenticated.value = false; // Trigger logout
    }
    return response;
  }
}
