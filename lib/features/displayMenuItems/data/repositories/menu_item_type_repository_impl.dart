import 'package:app/features/displayMenuItems/business/repositories/menu_item_type_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../../core/connection/network_info.dart';
import '../../../../../core/errors/exceptions.dart';
import '../../../../../core/errors/failure.dart';
import '../datasources/menu_item_type_remote_data_source.dart';
import '../models/menu_item_type_model.dart';

class MenuItemTypeRepositoryImpl implements MenuItemTypeRepository {
  final MenuItemTypeRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  MenuItemTypeRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<MenuItemTypeModel>>> getMenuItemTypes() async {
    if (await networkInfo.isConnected!) {
      try {
        List<MenuItemTypeModel> remoteMenuItemTypes =
            await remoteDataSource.getMenuItemTypes();

        return Right(remoteMenuItemTypes);
      } on ServerException {
        return Left(ServerFailure(errorMessage: 'This is a server exception'));
      }
    } else {
      return Left(ServerFailure(errorMessage: 'No internet connection'));
    }
  }
}
