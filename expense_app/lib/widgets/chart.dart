import 'package:expense_app/models/transaction.dart';
import 'package:expense_app/widgets/chart_bar.dart';
import 'package:flutter/material.dart';

class Chart extends StatelessWidget {
  final List<Transaction> tnxList;

  Chart(this.tnxList);
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      child: Row(children: [
        ChartBar(label, amount, pct)
      ],),
    );
  }
}
