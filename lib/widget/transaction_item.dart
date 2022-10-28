import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:personal_expenses/model/transaction.dart';

class TransactionItem extends StatelessWidget {
  final Transaction transaction;
  final Function deleteTransaction;

  const TransactionItem({
    super.key,
    required this.transaction,
    required this.deleteTransaction,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 15,
      ),
      color: Colors.blueGrey.shade100,
      child: ListTile(
        leading: ClipPath(
          clipper: const ShapeBorderClipper(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(15),
                bottomRight: Radius.circular(15),
              ),
            ),
          ),
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.green,
              boxShadow: [
                BoxShadow(
                  color: Colors.blueAccent,
                  offset: Offset(0, 1),
                  spreadRadius: 0.2,
                  blurRadius: 0.2,
                ),
              ],
              border: Border(
                left: BorderSide(
                  color: Colors.red,
                  width: 5,
                ),
              ),
            ),
            height: 50,
            width: 80,
            alignment: Alignment.center,
            child: FittedBox(
              child: Text(
                '\$${transaction.amount.toStringAsFixed(2)}',
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ),
          ),
        ),
        title: Text(
          transaction.title,
          style: Theme.of(context).textTheme.headline6,
        ),
        subtitle: Text(
          DateFormat.yMMMd().format(transaction.date),
          style: Theme.of(context).textTheme.bodyText2,
        ),
        trailing: IconButton(
          icon: Icon(
            Icons.delete_forever,
            color: Theme.of(context).errorColor,
          ),
          onPressed: () => deleteTransaction(transaction.id),
        ),
      ),
    );
    ;
  }
}
