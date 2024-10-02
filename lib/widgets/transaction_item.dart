import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';

class TransactionItem extends StatelessWidget {
  const TransactionItem({
    super.key,
    required this.transaction,
    required this.deleteTX,
  });

  final Transaction transaction;
  final void Function(String id) deleteTX;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
      child: ListTile(
        leading: CircleAvatar(
          radius: 30,
          child: Padding(
            padding: const EdgeInsets.all(6.0),
            child: FittedBox(
                child: Text('\$${transaction.amount}')),
          ),
        ),
        title: Text(
          transaction.title,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        subtitle: Text(
          DateFormat.yMMMd().format(transaction.date),
        ),
        trailing: MediaQuery.of(context).size.width > 460
            ? TextButton.icon(
          onPressed: () => deleteTX(transaction.id),
          icon: const Icon(Icons.delete, color: Colors.red),
          label: const Text(
            'Delete',
            style: TextStyle(color: Colors.red),
          ),
        )
            : IconButton(
          icon: const Icon(Icons.delete),
          color: Colors.red,
          onPressed: () => deleteTX(transaction.id),
        ),
      ),
    );
  }
}