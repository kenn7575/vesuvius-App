import 'package:dartz/dartz.dart';
import 'package:app/core/errors/failure.dart';
import 'package:app/core/params/params.dart';
import '../entities/pokemon_image_entity.dart';

abstract class PokemonImageRepository {
  Future<Either<Failure, PokemonImageEntity>> getPokemonImage({
    required PokemonImageParams pokemonImageParams,
  });
}
