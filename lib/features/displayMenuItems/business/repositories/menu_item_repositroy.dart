import 'package:dartz/dartz.dart';
import '../../../../../core/errors/failure.dart';
import '../entities/menu_item_entity.dart';

abstract class MenuItemRepository {
  Future<Either<Failure, MenuItemEntity>> getMenuItem();
}
