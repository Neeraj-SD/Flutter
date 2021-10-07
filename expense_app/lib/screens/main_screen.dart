import 'package:expense_app/models/transaction.dart';
import 'package:expense_app/widgets/chart.dart';
import 'package:expense_app/widgets/new_transaction_modal_sheet.dart';
import 'package:expense_app/widgets/transactions_list.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final List<Transaction> tx = [];

  void addTx(String title, double amount, DateTime selectedDate) {
    setState(() {
      tx.add(Transaction(
        id: DateTime.now().toString(),
        title: title,
        amount: amount,
        date: selectedDate,
      ));
    });
    tx.forEach((element) {
      print(element.id);
      print(element.title);
      print(element.amount);
    });
  }

  void startNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx, builder: (_) => NewTransactionModalSheet(addTx));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Expense App'),
      ),
      body: Column(
        children: [
          Container(
            child: Chart(tx), 
            height: 200,
          ),
          TransactionsList(tx),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => startNewTransaction(context),
        child: Icon(Icons.add),
        backgroundColor: Theme.of(context).accentColor,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
