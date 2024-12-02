import 'package:app/core/params/params.dart';
import 'package:dartz/dartz.dart';
import 'package:app/core/errors/failure.dart';
import '../entities/menu_item_entity.dart';

abstract class MenuItemRepository {
  Future<Either<Failure, List<MenuItemEntity>>> getMenuItem(
      {required GetMenuItemsParams params});
}
