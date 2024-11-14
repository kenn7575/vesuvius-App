import 'package:app/core/params/params.dart';
import 'package:app/features/displayMenuItems/business/entities/menu_item_entity.dart';
import 'package:app/features/displayMenuItems/business/repositories/menu_item_repositroy.dart';
import 'package:dartz/dartz.dart';
import '../../../../../core/errors/failure.dart';


class GetMenuItem {
  final MenuItemRepository menuItemRepository;

  GetMenuItem({required this.menuItemRepository});

  Future<Either<Failure, List<MenuItemEntity>>> call({required MenuItemsParams params}) async {
    return await menuItemRepository.getMenuItem(params: params);
  }
}
