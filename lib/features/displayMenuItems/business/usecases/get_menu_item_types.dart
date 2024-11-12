import 'package:app/features/displayMenuItems/business/entities/menu_item_types_entity.dart';
import 'package:dartz/dartz.dart';
import '../../../../../core/errors/failure.dart';
import '../repositories/menu_item_types_repository.dart';


class GetMenuItemTypes {
  final MenuItemTypesRepository menuItemTypesRepository;

  GetMenuItemTypes({required this.menuItemTypesRepository});

  Future<Either<Failure, MenuItemTypesEntity>> call() async {
    return await menuItemTypesRepository.getMenuItemTypes();
  }
}
