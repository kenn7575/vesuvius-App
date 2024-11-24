import 'package:app/features/order/presentation/providers/new_order_provider.dart';
import 'package:app/features/select_table_for_order/presentation/providers/table_provider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class SelectTables extends StatefulWidget {
  const SelectTables({super.key});

  @override
  State<SelectTables> createState() => _SelectTablesState();
}

class _SelectTablesState extends State<SelectTables> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Consumer2<TableProvider, OrderProvider>(
                builder: (context, tableProvider, orderProvider, child) {
                  final tables = tableProvider.tables;

                  if (tables == null || tables.isEmpty) {
                    return const Center(
                      child: Text('No tables available'),
                    );
                  }

                  return Column(
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: SingleChildScrollView(
                            child: DataTable(
                              showCheckboxColumn: false,
                              columns: const [
                                DataColumn(label: Text('Select')),
                                DataColumn(label: Text('Table Number')),
                                DataColumn(label: Text('Capacity')),
                              ],
                              rows: List<DataRow>.generate(
                                tables.length,
                                (index) => DataRow(
                                  cells: [
                                    DataCell(
                                      Checkbox(
                                        value: orderProvider.selectedTables.any(
                                            (element) =>
                                                element.tableId ==
                                                tables[index].id),
                                        onChanged: (bool? value) {
                                          if (value == true) {
                                            orderProvider.selectTable(
                                                table: tables[index]);
                                          } else {
                                            orderProvider
                                                .deselectTable(tables[index]);
                                          }
                                        },
                                      ),
                                    ),
                                    DataCell(Text(tables[index].nr.toString())),
                                    DataCell(Text(
                                        tables[index].capacity.toString())),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            Positioned(
              bottom: 16.0,
              left: 0,
              right: 0,
              child: Center(
                child: FilledButton(
                  onPressed: Provider.of<OrderProvider>(context, listen: true)
                          .selectedTables
                          .isEmpty
                      ? null
                      : () {
                          context.push('/orders/itemTypes');
                        },
                  child: const Text('Next'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
