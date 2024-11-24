import 'package:app/features/select_table_for_order/business/entities/table_entiry.dart';

class TableModel extends TableEntity {
  const TableModel({
    required super.id,
    required super.capacity,
    required super.nr,
  });

  factory TableModel.fromJson({required Map<String, dynamic> json}) {
    return TableModel(
      id: json[kId],
      capacity: json[kCapacity],
      nr: json[kNr],
    );
  }
  static List<TableModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => TableModel.fromJson(json: json)).toList();
  }

  static List<Map<String, dynamic>> toJsonList(List<TableModel> models) {
    return models.map((model) => model.toJson()).toList();
  }

  Map<String, dynamic> toJson() {
    return {
      kId: id,
      kCapacity: capacity,
      kNr: nr,
    };
  }
}

const String kId = 'id';
const String kCapacity = 'capacity';
const String kNr = 'nr';
