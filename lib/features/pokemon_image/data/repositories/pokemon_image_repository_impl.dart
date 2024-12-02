import 'package:dartz/dartz.dart';

import 'package:app/core/connection/network_info.dart';
import 'package:app/core/errors/exceptions.dart';
import 'package:app/core/errors/failure.dart';
import 'package:app/core/params/params.dart';
import '../../business/repositories/pokemon_image_repository.dart';
import '../datasources/pokemon_image_local_data_source.dart';
import '../datasources/pokemon_image_remote_data_source.dart';
import '../models/pokemon_image_model.dart';

class PokemonImageRepositoryImpl implements PokemonImageRepository {
  final PokemonImageRemoteDataSource remoteDataSource;
  final PokemonImageLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  PokemonImageRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, PokemonImageModel>> getPokemonImage(
      {required PokemonImageParams pokemonImageParams}) async {
    if (await networkInfo.isConnected!) {
      try {
        PokemonImageModel remotePokemonImage = await remoteDataSource
            .getPokemonImage(pokemonImageParams: pokemonImageParams);

        localDataSource.cachePokemonImage(
            pokemonImageToCache: remotePokemonImage);

        return Right(remotePokemonImage);
      } on ServerException {
        return Left(ServerFailure(errorMessage: 'This is a server exception'));
      }
    } else {
      try {
        PokemonImageModel localPokemonImage =
            await localDataSource.getLastPokemonImage();
        return Right(localPokemonImage);
      } on CacheException {
        return Left(CacheFailure(errorMessage: 'This is a cache exception'));
      }
    }
  }
}
