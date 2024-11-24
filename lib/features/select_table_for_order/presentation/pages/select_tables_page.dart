import 'package:app/features/select_table_for_order/presentation/providers/table_provider.dart';
import 'package:app/features/select_table_for_order/presentation/widgets/select_tables.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SelectTablesPage extends StatefulWidget {
  const SelectTablesPage({super.key});

  @override
  State<SelectTablesPage> createState() => _SelectTablesPageState();
}

class _SelectTablesPageState extends State<SelectTablesPage> {
  @override
  void initState() {
    Provider.of<TableProvider>(context, listen: false).eitherFailureOrTable();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: SelectTables());
  }
}
