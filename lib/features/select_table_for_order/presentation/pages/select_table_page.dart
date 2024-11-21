import 'package:app/features/select_table_for_order/business/entities/reservation_entity.dart';
import 'package:app/features/select_table_for_order/presentation/providers/reservation_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SelectTablePage extends StatefulWidget {
  const SelectTablePage({super.key});

  @override
  State<SelectTablePage> createState() => _SelectTablePageState();
}

class _SelectTablePageState extends State<SelectTablePage> {
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
        body: reservations != null
            ? Center(child: Text(reservations[0].customerPhoneNumber))
            : const Center(child: Text("No reservations found")));
  }
}
