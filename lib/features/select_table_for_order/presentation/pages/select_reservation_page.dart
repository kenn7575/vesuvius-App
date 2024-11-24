import 'package:app/features/select_table_for_order/business/entities/reservation_entity.dart';
import 'package:app/features/select_table_for_order/presentation/providers/reservation_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SelectReservationPage extends StatefulWidget {
  const SelectReservationPage({super.key});

  @override
  State<SelectReservationPage> createState() => _SelectReservationPageState();
}

class _SelectReservationPageState extends State<SelectReservationPage> {
  @override
  void initState() {
    Provider.of<ReservationProvider>(context, listen: false)
        .eitherFailureOrReservation();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final List<ReservationEntity>? reservations =
        Provider.of<ReservationProvider>(context).reservations;

    // Widget layout = screenSize > phoneWidth ? :
    return Scaffold(
      body: reservations != null && reservations.isNotEmpty
          ? Center(child: Text(reservations[0].customerPhoneNumber))
          : const Center(
              child: Text("No reservations found"),
            ),
    );
  }
}
