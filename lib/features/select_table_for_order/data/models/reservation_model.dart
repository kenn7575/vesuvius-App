import 'package:app/features/new_order/data/models/order_table_model.dart';
import 'package:app/features/select_table_for_order/business/entities/reservation_entity.dart';

class ReservationModel extends ReservationEntity {
  const ReservationModel({
    required super.id,
    required super.createdAt,
    required super.updatedAt,
    required super.time,
    required super.durationInMinutes,
    required super.numberOfPeople,
    super.waiterId,
    required super.status,
    super.comment,
    required super.customerName,
    required super.customerPhoneNumber,
    super.reservationTables,
  });

  factory ReservationModel.fromJson({required Map<String, dynamic> json}) {
    return ReservationModel(
      id: json[kId],
      comment: json[kComment],
      waiterId: json[kWaiterId],
      createdAt: DateTime.parse(json[kCreatedAt]),
      updatedAt: DateTime.parse(json[kUpdatedAt]),
      status: json[kStatus],
      time: DateTime.parse(json[kTime]),
      durationInMinutes: json[kDurationInMinutes],
      numberOfPeople: json[kNumberOfPeople],
      customerName: json['customer_name'],
      customerPhoneNumber: json['customer_phone_number'],
    );
  }
  static List<ReservationModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList
        .map((json) => ReservationModel.fromJson(json: json))
        .toList();
  }

  static List<Map<String, dynamic>> toJsonList(List<ReservationModel> models) {
    return models.map((model) => model.toJson()).toList();
  }

  Map<String, dynamic> toJson() {
    return {
      kId: id,
      kComment: comment,
      kWaiterId: waiterId,
      kCreatedAt: createdAt.toIso8601String(),
      kUpdatedAt: updatedAt.toIso8601String(),
      kStatus: status,
      kTime: time.toIso8601String(),
      kDurationInMinutes: durationInMinutes,
      kNumberOfPeople: numberOfPeople,
      kCustomerName: customerName,
      kSustomerPhoneNumber: customerPhoneNumber,
      kOrderTables: OrderTableModel.toJsonList(
          reservationTables?.cast<OrderTableModel>() ?? []),
    };
  }
}

const String kId = 'id';
const String kTime = 'time';
const String kDurationInMinutes = 'duration_in_minutes';
const String kNumberOfPeople = 'number_of_people';
const String kWaiterId = 'waiter_id';
const String kStatus = 'status';
const String kComment = 'comment';
const String kCustomerName = 'customer_name';
const String kSustomerPhoneNumber = 'customer_phone_number';
const String kCreatedAt = 'created_at';
const String kUpdatedAt = 'updated_at';
const String kOrderTables = 'tables_in_orders_and_reservations';
