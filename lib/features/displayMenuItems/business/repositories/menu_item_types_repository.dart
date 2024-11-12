import 'package:dartz/dartz.dart';
import '../../../../../core/errors/failure.dart';
import '../entities/menu_item_types_entity.dart';


abstract class MenuItemTypesRepository {
  Future<Either<Failure, MenuItemTypesEntity>> getMenuItemTypes();
}
