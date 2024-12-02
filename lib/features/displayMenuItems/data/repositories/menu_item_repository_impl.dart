import 'package:app/core/params/params.dart';
import 'package:app/features/displayMenuItems/business/repositories/menu_item_repositroy.dart';
import 'package:app/features/displayMenuItems/data/models/menu_item_models.dart';
import 'package:dartz/dartz.dart';

import 'package:app/core/connection/network_info.dart';
import 'package:app/core/errors/failure.dart';
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
      {required GetMenuItemsParams params}) async {
    if (await networkInfo.isConnected!) {
      try {
        List<MenuItemModel> remoteMenuItem =
            await remoteDataSource.getMenuItems(params: params);

        return Right(remoteMenuItem);
      } on ServerFailure catch (e) {
        return Left(e);
      } on ValidationFailure catch (e) {
        return Left(e);
      }
    } else {
      return Left(ServerFailure(errorMessage: 'No internet connection'));
    }
  }
}
