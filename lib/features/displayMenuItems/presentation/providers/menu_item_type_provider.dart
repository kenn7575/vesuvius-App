import 'package:app/features/displayMenuItems/business/entities/menu_item_types_entity.dart';
import 'package:app/features/displayMenuItems/business/usecases/get_menu_item_types.dart';
import 'package:data_connection_checker_tv/data_connection_checker.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../../../../../core/connection/network_info.dart';
import '../../../../../core/errors/failure.dart';
import '../../data/datasources/menu_item_type_remote_data_source.dart';
import '../../data/repositories/menu_item_type_repository_impl.dart';

class MenuItemTypesProvider extends ChangeNotifier {
  List<MenuItemTypeEntity>? menuItemTypes;
  Failure? failure;

  MenuItemTypesProvider({
    this.menuItemTypes,
    this.failure,
  });
  // create repository
  void getMenuItemTypes() async {
    MenuItemTypeRepositoryImpl repository = MenuItemTypeRepositoryImpl(
      remoteDataSource: MenuItemTypeRemoteDataSourceImpl(
        dio: Dio(),
      ),
      networkInfo: NetworkInfoImpl(
        DataConnectionChecker(),
      ),
    );

    // call usecase that has repository as parameter
    final failureOrMenuItemTypes =
        await GetMenuItemTypes(menuItemTypeRepository: repository).call();

    failureOrMenuItemTypes.fold(
      (Failure newFailure) {
        menuItemTypes = null;
        failure = newFailure;
        notifyListeners();
      },
      // if success, set the menuItemTypes and notify listeners
      (List<MenuItemTypeEntity> newMenuItemTypes) {
        menuItemTypes = newMenuItemTypes;
        failure = null;
        notifyListeners();
      },
    );
  }
}
