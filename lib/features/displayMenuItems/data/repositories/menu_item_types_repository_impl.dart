import 'package:app/features/displayMenuItems/business/repositories/menu_item_types_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../../core/connection/network_info.dart';
import '../../../../../core/errors/exceptions.dart';
import '../../../../../core/errors/failure.dart';
import '../datasources/menu_item_types_remote_data_source.dart';
import '../models/menu_item_types_model.dart';

class MenuItemTypesRepositoryImpl implements MenuItemTypesRepository {
  final MenuItemTypesRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  MenuItemTypesRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, MenuItemTypesModel>> getMenuItemTypes() async {
    if (await networkInfo.isConnected!) {
      try {
        MenuItemTypesModel remoteTemplate =
            await remoteDataSource.getMenuItemTypes();

        return Right(remoteTemplate);
      } on ServerException {
        return Left(ServerFailure(errorMessage: 'This is a server exception'));
      }
    } else {
      return Left(ServerFailure(errorMessage: 'No internet connection'));
    }
  }
}
