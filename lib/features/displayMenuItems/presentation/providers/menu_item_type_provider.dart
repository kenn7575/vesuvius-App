import 'package:app/features/displayMenuItems/business/entities/menu_item_entity.dart';
import 'package:app/features/displayMenuItems/business/entities/menu_item_types_entity.dart';
import 'package:app/features/displayMenuItems/business/usecases/get_menu_item.dart';
import 'package:app/features/displayMenuItems/business/usecases/get_menu_item_types.dart';
import 'package:app/features/displayMenuItems/data/datasources/menu_item_remote_data_source.dart';
import 'package:app/features/displayMenuItems/data/repositories/menu_item_repository_impl.dart';
import 'package:data_connection_checker_tv/data_connection_checker.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:app/core/connection/network_info.dart';
import 'package:app/core/errors/failure.dart';
import 'package:app/core/params/params.dart';
import '../../data/datasources/menu_item_type_remote_data_source.dart';
import '../../data/repositories/menu_item_type_repository_impl.dart';

class MenuItemTypesProvider extends ChangeNotifier {
  List<MenuItemEntity>? menuItems;
  List<MenuItemTypeEntity>? menuItemTypes;
  int? selectedTypeId;
  String? selectedTypeName;
  Failure? failure;

  MenuItemTypesProvider({
    this.menuItemTypes,
    this.failure,
  });

  void setSelectedType({required int typeId, String? typeName}) {
    selectedTypeId = typeId;
    if (typeName != null) {
      selectedTypeName = typeName;
    }
    notifyListeners();
  }

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

  void getMenuItems({required int typeId}) async {
    MenuItemRepositoryImpl repository = MenuItemRepositoryImpl(
      remoteDataSource: MenuItemRemoteDataSourceImpl(
        dio: Dio(),
      ),
      networkInfo: NetworkInfoImpl(
        DataConnectionChecker(),
      ),
    );

    // call usecase that has repository as parameter
    final failureOrMenuItem = await GetMenuItem(menuItemRepository: repository)
        .call(params: GetMenuItemsParams(typeId));

    failureOrMenuItem.fold(
      (Failure newFailure) {
        menuItems = null;
        failure = newFailure;
        notifyListeners();
      },
      // if success, set the menuItem and notify listeners
      (List<MenuItemEntity> newMenuItem) {
        menuItems = newMenuItem;
        failure = null;
        notifyListeners();
      },
    );
  }
}
