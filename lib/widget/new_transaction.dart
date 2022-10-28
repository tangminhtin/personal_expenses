import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTransaction;

  const NewTransaction({
    super.key,
    required this.addTransaction,
  });

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  DateTime? _selectedDate;

  void _submitData() {
    if (_amountController.text.isEmpty) {
      return;
    }

    final enteredTitle = _titleController.text;
    final enteredAmount = double.parse(_amountController.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0 || _selectedDate == null) {
      return;
    }

    widget.addTransaction(
      enteredTitle,
      enteredAmount,
      _selectedDate,
    );

    Navigator.of(context).pop();
  }

  void _startDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        margin: const EdgeInsets.all(0),
        elevation: 15,
        child: Padding(
          padding: EdgeInsets.only(
            left: 15,
            right: 15,
            top: 15,
            bottom: MediaQuery.of(context).viewInsets.bottom + 30,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextField(
                controller: _titleController,
                decoration: InputDecoration(
                  label: const Text('Title'),
                  hintText: 'Hotel payment',
                  helperText: 'Name of expenses',
                  icon: const Icon(
                    Icons.title,
                    color: Colors.yellow,
                  ),
                  labelStyle: TextStyle(
                    color: Theme.of(context).textTheme.bodyText1?.color,
                  ),
                  helperStyle: TextStyle(
                    color: Theme.of(context).textTheme.overline?.color,
                  ),
                  hintStyle: const TextStyle(
                    color: Colors.purple,
                  ),
                ),
                style: const TextStyle(
                  color: Colors.white,
                ),
                cursorColor: Colors.yellow,
                onSubmitted: (_) => _submitData,
                keyboardType: TextInputType.text,
              ),
              TextField(
                controller: _amountController,
                decoration: InputDecoration(
                  label: const Text('Amount'),
                  hintText: '\$1000',
                  helperText: 'Number of money',
                  icon: const Icon(
                    Icons.money,
                    color: Colors.yellow,
                  ),
                  labelStyle: TextStyle(
                    color: Theme.of(context).textTheme.bodyText1?.color,
                  ),
                  helperStyle: TextStyle(
                    color: Theme.of(context).textTheme.overline?.color,
                  ),
                  hintStyle: const TextStyle(
                    color: Colors.purple,
                  ),
                ),
                style: const TextStyle(
                  color: Colors.white,
                ),
                cursorColor: Colors.yellow,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                onSubmitted: (_) => _submitData,
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      _selectedDate != null
                          ? 'Picked date: ${DateFormat.yMd().format(_selectedDate!)}'
                          : 'No date chosen!',
                      style: TextStyle(
                        color: Theme.of(context).textTheme.bodyText1?.color,
                      ),
                    ),
                    TextButton(
                      onPressed: _startDatePicker,
                      child: const Text(
                        'Choose date',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              ElevatedButton.icon(
                onPressed: _submitData,
                icon: const Icon(Icons.post_add),
                label: const Text('Add new transaction'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
