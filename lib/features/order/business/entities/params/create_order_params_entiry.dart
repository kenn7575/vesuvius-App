import 'package:app/features/order/data/models/params/create_order_item_params_model.dart';
import 'package:app/features/order/data/models/params/create_order_table_params_model.dart';

class CreateOrderParamsEntiry {
  int? waiterId;
  String? comment;
  final List<CreateOrderItemParamsModel> orderItems;
  final List<CreateOrderTableParamsModel> orderTables;
  CreateOrderParamsEntiry({
    this.waiterId,
    required this.orderItems,
    required this.orderTables,
    this.comment,
  });
}
