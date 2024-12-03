import 'package:app/features/order/business/entities/params/create_order_table_params_entiry.dart';

class CreateOrderTableParamsModel extends CreateOrderTableParamsEntiry {
  CreateOrderTableParamsModel({
    required super.tableId,
  });

  factory CreateOrderTableParamsModel.fromJson(
      {required Map<String, dynamic> json}) {
    return CreateOrderTableParamsModel(
      tableId: json[kTableId],
    );
  }

  static List<CreateOrderTableParamsModel> fromJsonList(
      List<dynamic> jsonList) {
    return jsonList
        .map((json) => CreateOrderTableParamsModel.fromJson(json: json))
        .toList();
  }

  static List<Map<String, dynamic>> toJsonList(
      List<CreateOrderTableParamsModel> models) {
    return models.map((model) => model.toJson()).toList();
  }

  Map<String, dynamic> toJson() {
    return {
      kTableId: tableId,
    };
  }
}

const String kTableId = 'table_id';
