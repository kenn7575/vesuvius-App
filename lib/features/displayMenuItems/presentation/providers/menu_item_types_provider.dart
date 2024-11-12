import 'package:app/features/displayMenuItems/business/entities/menu_item_types_entity.dart';
import 'package:app/features/displayMenuItems/business/usecases/get_menu_item_types.dart';
import 'package:data_connection_checker_tv/data_connection_checker.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../../../../../core/connection/network_info.dart';
import '../../../../../core/errors/failure.dart';
import '../../data/datasources/menu_item_types_remote_data_source.dart';
import '../../data/repositories/menu_item_types_repository_impl.dart';

class MenuItemTypesProvider extends ChangeNotifier {
  MenuItemTypesEntity? menuItemTypes;
  Failure? failure;

  MenuItemTypesProvider({
    this.menuItemTypes,
    this.failure,
  });
  // create repository
  void getMenuItemTypes() async {
    MenuItemTypesRepositoryImpl repository = MenuItemTypesRepositoryImpl(
      remoteDataSource: MenuItemTypesRemoteDataSourceImpl(
        dio: Dio(),
      ),

      networkInfo: NetworkInfoImpl(
        DataConnectionChecker(),
      ),

    );

    // call usecase that has repository as parameter
    final failureOrMenuItemTypes =
        await GetMenuItemTypes(menuItemTypesRepository: repository).call();

    failureOrMenuItemTypes.fold(
      (Failure newFailure) {
        menuItemTypes = null;
        failure = newFailure;
        notifyListeners();
      },
      // if success, set the menuItemTypes and notify listeners
      (MenuItemTypesEntity newMenuItemTypes) {
        menuItemTypes = newMenuItemTypes;
        failure = null;
        notifyListeners();
      },
    );
  }
}
