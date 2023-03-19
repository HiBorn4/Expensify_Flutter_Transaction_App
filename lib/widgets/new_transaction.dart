import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function newTx;
  const NewTransaction(this.newTx, {super.key});

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  DateTime _selectedDate = DateTime.now();

  void _submitData() {
    final enteredTitle = titleController.text;
    final enteredAmount = double.parse(amountController.text);

    // ignore: unnecessary_null_comparison
    if (enteredTitle.isEmpty || enteredAmount <= 0 || _selectedDate == null) {
      return;
    }

    widget.newTx(
      enteredTitle,
      enteredAmount,
      _selectedDate,
    );

    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2022),
      lastDate: DateTime.now(),
    ).then((pickedDate) =>
        pickedDate == null ? null : setState(() => _selectedDate = pickedDate)
    );
    if (kDebugMode) {
      print('...');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Container(
          padding: EdgeInsets.only(
            top: 10,
            left: 10,
            right: 10,
            bottom: MediaQuery.of(context).viewInsets.bottom + 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              TextField(
                decoration: const InputDecoration(labelText: 'Title'),
                controller: titleController,
                keyboardType: TextInputType.text,
                onSubmitted: (_) => _submitData(),
              ),
              TextField(
                decoration: const InputDecoration(labelText: 'Amount'),
                controller: amountController,
                keyboardType: TextInputType.number,
                onSubmitted: (_) => _submitData(),
              ),
              SizedBox(
                height: 70,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        // ignore: unnecessary_null_comparison
                        _selectedDate == null
                        ? 'No Date Choosen !'
                        : 'Picked Date: ${DateFormat.yMd().format(_selectedDate)}'
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        _presentDatePicker();
                      },
                      child: Text(
                        ("Choose Date"),
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  _submitData();
                },
                child: const Text(
                  ('Add Transaction'),
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}