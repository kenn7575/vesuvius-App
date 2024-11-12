import 'package:app/features/displayMenuItems/business/entities/menu_item_types_entity.dart';
import 'package:dartz/dartz.dart';
import '../../../../../core/errors/failure.dart';
import '../repositories/menu_item_type_repository.dart';

class GetMenuItemTypes {
  final MenuItemTypeRepository menuItemTypeRepository;

  GetMenuItemTypes({required this.menuItemTypeRepository});

  Future<Either<Failure, List<MenuItemTypeEntity>>> call() async {
    return await menuItemTypeRepository.getMenuItemTypes();
  }
}
