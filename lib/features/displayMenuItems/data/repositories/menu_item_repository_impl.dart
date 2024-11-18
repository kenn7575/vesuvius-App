import 'package:app/core/params/params.dart';
import 'package:app/features/displayMenuItems/business/repositories/menu_item_repositroy.dart';
import 'package:app/features/displayMenuItems/data/models/menu_item_models.dart';
import 'package:dartz/dartz.dart';

import '../../../../../core/connection/network_info.dart';
import '../../../../../core/errors/exceptions.dart';
import '../../../../../core/errors/failure.dart';
import '../datasources/menu_item_remote_data_source.dart';

class MenuItemRepositoryImpl implements MenuItemRepository {
  final MenuItemRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  MenuItemRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<MenuItemModel>>> getMenuItem(
      {required MenuItemsParams params}) async {
    if (await networkInfo.isConnected!) {
      try {
        List<MenuItemModel> remoteMenuItem =
            await remoteDataSource.getMenuItem(params: params);

        return Right(remoteMenuItem);
      } on ServerException {
        return Left(ServerFailure(errorMessage: 'This is a server exception'));
      }
    } else {
      return Left(ServerFailure(errorMessage: 'No internet connection'));
    }
  }
}
