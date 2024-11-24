import 'package:app/features/order/presentation/providers/new_order_provider.dart';
import 'package:app/features/select_table_for_order/presentation/providers/reservation_provider.dart';
import 'package:app/features/select_table_for_order/presentation/providers/table_provider.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class SelectReservation extends StatefulWidget {
  const SelectReservation({super.key});

  @override
  State<SelectReservation> createState() => _SelectReservationState();
}

class _SelectReservationState extends State<SelectReservation> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: SingleChildScrollView(
        child: Consumer2<ReservationProvider, OrderProvider>(
          builder: (context, reservationProvider, orderProvider, child) {
            final reservations = reservationProvider.reservations;

            if (reservations == null || reservations.isEmpty) {
              return const Center(
                child: Text('No reservations available'),
              );
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DataTable(
                  showCheckboxColumn: false,
                  columns: const [
                    DataColumn(label: Text('Time')),
                    DataColumn(label: Text('Table Number')),
                    DataColumn(label: Text('Capacity')),
                    DataColumn(label: Text('Status')),
                  ],
                  rows: List<DataRow>.generate(
                    reservations.length,
                    (index) => DataRow(
                      onSelectChanged: (
                        value,
                      ) {
                        orderProvider.selectTable(
                            reservation: reservations[index]);
                        context.push('/orders/itemTypes');
                      },
                      cells: [
                        DataCell(Text(reservations[index]
                            .time
                            .toLocal()
                            .toString()
                            .substring(10, 20))),
                        DataCell(Text(reservations[index].customerName)),
                        DataCell(Text(reservations[index].customerPhoneNumber)),
                        DataCell(Text(reservations[index].status)),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
