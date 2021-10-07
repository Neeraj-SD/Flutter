import 'package:flutter/material.dart';

import '../models/transaction.dart';

class ChartBar extends StatelessWidget {
  final label;
  final amount;
  final pct;

  ChartBar(this.label, this.amount, this.pct);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (ctx, constraints) => Column(
        children: [
          Text(amount),
          SizedBox(height: 5),
          //
          Stack(children: [
                       Container(
              height: constraints.maxHeight * 0.6,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              color: Color.fromRGBO(220, 220, 220, 1),
              
            ),
            FractionallySizedBox(),
          ],
          ),
          SizedBox(height: 5),
          Text(label),
        ],
      ),
    );
  }
}
