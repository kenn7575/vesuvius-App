import 'package:app/core/errors/failure.dart';
import 'package:app/features/select_table_for_order/business/entities/table_entiry.dart';
import 'package:app/features/select_table_for_order/presentation/providers/table_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DataTableExample extends StatefulWidget {
  const DataTableExample({super.key});

  @override
  State<DataTableExample> createState() => _DataTableExampleState();
}

class _DataTableExampleState extends State<DataTableExample> {
  static const int numItems = 20;
  List<bool>? selected = List<bool>.generate(numItems, (int index) => false);
  late List<TableEntity>? tables;

  @override
  void initState() {
    super.initState();
    tables = Provider.of<TableProvider>(context, listen: false).tables;
    selected = List<bool>.generate(tables.length, (int index) => false);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: DataTable(
        columns: const <DataColumn>[
          DataColumn(
            label: Text('Number'),
          ),
        ],
        rows: List<DataRow>.generate(
          numItems,
          (int index) => DataRow(
            color: WidgetStateProperty.resolveWith<Color?>(
                (Set<WidgetState> states) {
              // All rows will have the same selected color.
              if (states.contains(WidgetState.selected)) {
                return Theme.of(context).colorScheme.primary.withOpacity(0.08);
              }
              // Even rows will have a grey color.
              if (index.isEven) {
                return Colors.grey.withOpacity(0.3);
              }
              return null; // Use default value for other states and odd rows.
            }),
            cells: <DataCell>[DataCell(Text('Row $index'))],
            selected: selected[index],
            onSelectChanged: (bool? value) {
              setState(() {
                selected[index] = value!;
              });
            },
          ),
        ),
      ),
    );
  }
}
