import 'package:app/core/errors/failure.dart';
import 'package:app/features/select_table_for_order/business/entities/table_entiry.dart';
import 'package:app/features/select_table_for_order/business/repositories/table_repository.dart';
import 'package:app/features/select_table_for_order/presentation/providers/table_provider.dart';
import 'package:app/features/select_table_for_order/presentation/widgets/table_data_table.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
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
    return const Scaffold(body: DataTableExample());
  }
}
