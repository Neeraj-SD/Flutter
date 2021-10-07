import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransactionModalSheet extends StatefulWidget {
  final Function addTx;

  NewTransactionModalSheet(this.addTx);
  @override
  _NewTransactionModalSheetState createState() =>
      _NewTransactionModalSheetState();
}

class _NewTransactionModalSheetState extends State<NewTransactionModalSheet> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  var selectedDate;

  void datePicker() async {
    var datePicked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2021),
        lastDate: DateTime.now());

    if (datePicked == null) return;
    setState(() {
      selectedDate = datePicked;
    });
  }

  void submitData() {
    final enteredTitle = _titleController.text;
    final enteredAmount = double.parse(_amountController.text);
    print(enteredTitle);
    print(enteredAmount);

    if (enteredTitle.isEmpty || enteredAmount <= 0 || selectedDate == null)
      return;
    widget.addTx(enteredTitle, enteredAmount, selectedDate);

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                decoration: InputDecoration(labelText: 'Title'),
                controller: _titleController,
                keyboardType: TextInputType.name,
                // onSubmitted: (_) => submitData(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                decoration: InputDecoration(labelText: 'Amount'),
                controller: _amountController,
                keyboardType: TextInputType.number,
                onSubmitted: (_) => submitData(),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(selectedDate == null
                    ? 'No date selected'
                    : 'selectd date : ${DateFormat.yMMMd().format(selectedDate)}'),
                FlatButton(
                  onPressed: datePicker,
                  child: Text(
                    'Choose Date',
                    style: TextStyle(color: Theme.of(context).primaryColor),
                  ),
                ),
              ],
            ),
            RaisedButton(
              color: Theme.of(context).primaryColor,
              onPressed: () {},
              child: Text('Add Transaction'),
            ),
          ],
        ),
      ),
    );
  }
}
