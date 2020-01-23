import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

typedef void TransactionDeleteFunction(String id);

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final TransactionDeleteFunction onDeleted;

  TransactionList(this.transactions, this.onDeleted);

  @override
  Widget build(BuildContext context) {
    return this.transactions.isEmpty
        ? LayoutBuilder(builder: (ctx, constraints) {
          return Column(
            children: <Widget>[
              Text(
                'No transactions added yet!',
                style: Theme.of(context).textTheme.title,
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                height: constraints.maxHeight * 0.5,
                child:
                    Image.asset('assets/images/waiting.png', fit: BoxFit.cover),
              ),
            ],
          );
        }) 
        : ListView.builder(
            itemCount: this.transactions.length,
            itemBuilder: (ctx, idx) {
              final tx = this.transactions[idx];
              return Card(
                margin: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                elevation: 5,
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 30,
                    child: Padding(
                      padding: const EdgeInsets.all(6),
                      child: FittedBox(
                        child: Text('\$${tx.amount.toStringAsFixed(2)}'),
                      ),
                    ),
                  ),
                  title:
                      Text(tx.title, style: Theme.of(context).textTheme.title),
                  subtitle: Text(DateFormat.yMMMd().format(tx.date)),
                  trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () => this.onDeleted(tx.id),
                      color: Theme.of(context).errorColor),
                ),
              );
            },
          );
  }
}
