import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final void Function(String id) deleteTX;

  const TransactionList(
      {super.key, required this.transactions, required this.deleteTX});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: transactions.isEmpty
          ? LayoutBuilder(builder: (ctx, constraint) {
              return Column(
                children: [
                  Text(
                    'No Transaction added yet!',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: constraint.maxHeight * 0.6,
                    child: const Image(
                      image: AssetImage('assets/images/waiting.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              );
            })
          : ListView.builder(
              itemBuilder: (ctx, index) {
                return Card(
                  elevation: 5,
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      child: Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: FittedBox(
                            child: Text('\$${transactions[index].amount}')),
                      ),
                    ),
                    title: Text(
                      transactions[index].title,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    subtitle: Text(
                      DateFormat.yMMMd().format(transactions[index].date),
                    ),
                    trailing: MediaQuery.of(context).size.width > 460
                        ? TextButton.icon(
                            onPressed: () => deleteTX(transactions[index].id),
                            icon: const Icon(Icons.delete, color: Colors.red),
                            label: const Text(
                              'Delete',
                              style: TextStyle(color: Colors.red),
                            ),
                          )
                        : IconButton(
                            icon: const Icon(Icons.delete),
                            color: Colors.red,
                            onPressed: () => deleteTX(transactions[index].id),
                          ),
                  ),
                );
              },
              itemCount: transactions.length,
            ),
    );
  }
}
