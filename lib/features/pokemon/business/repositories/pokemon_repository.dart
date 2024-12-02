import 'package:dartz/dartz.dart';
import 'package:app/core/errors/failure.dart';
import 'package:app/core/params/params.dart';
import '../entities/pokemon_entity.dart';

abstract class PokemonRepository {
  Future<Either<Failure, PokemonEntity>> getPokemon(
      {required PokemonParams params});
}
