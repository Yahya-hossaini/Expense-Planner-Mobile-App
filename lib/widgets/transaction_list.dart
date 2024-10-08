import '../widgets/transaction_item.dart';
import 'package:flutter/material.dart';
import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final void Function(String id) deleteTX;

  const TransactionList(
      {super.key, required this.transactions, required this.deleteTX});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,

      //deciding for show an empty list or list with transactions
      child: transactions.isEmpty
          ? LayoutBuilder(builder: (ctx, constraint) {

              //Empty part
              return Column(
                children: [
                  Text(
                    'No Transaction added yet!',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),

                  const SizedBox(
                    height: 10,
                  ),

                  SizedBox(
                    height: constraint.maxHeight * 0.6,
                    child: const Image(
                      image: AssetImage('assets/images/waiting.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              );
            },)

          // List with transaction part
          : ListView(
              children: transactions
                  .map(
                    (tx) => TransactionItem(
                        key: ValueKey(tx.id),
                        transaction: tx,
                        deleteTX: deleteTX),
                  )
                  .toList(),
            ),
    );
  }
}
