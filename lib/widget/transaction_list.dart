// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import '../model/transaction.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deletion;

  TransactionList(this.transactions, this.deletion);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 430,
      child: transactions.isEmpty
          ? LayoutBuilder(builder: (ctx, constraints) {
              return Column(
                children: [
                  Text('No transactions added yet!'),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                      height: constraints.maxHeight * 0.7,
                      child: Image.asset(
                        'assets/images/waiting.png',
                        fit: BoxFit.cover,
                      )),
                ],
              );
            })
          : ListView.builder(
              itemBuilder: (context, index) {
                return Card(
                  elevation: 5,
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 6),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.deepOrange,
                      child: Padding(
                        padding: const EdgeInsets.all(4),
                        child: FittedBox(
                            child: Text('\$${transactions[index].amount}',
                                style: TextStyle(
                                  color: Colors.white,
                                ))),
                      ),
                    ),
                    title: Text(
                      transactions[index].item,
                      style: TextStyle(
                          color: Colors.orange,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                    subtitle: Text(
                        DateFormat.yMMMd().format((transactions[index].date))),
                    trailing: MediaQuery.of(context).size.width > 450
                        ? FlatButton.icon(
                            onPressed: () => deletion(transactions[index].id),
                            textColor: Theme.of(context).errorColor,
                            icon: Icon(Icons.delete_rounded),
                            label: Text('Delete'))
                        : IconButton(
                            icon: Icon(Icons.delete_rounded),
                            color: Theme.of(context).errorColor,
                            iconSize: 35,
                            onPressed: () => deletion(transactions[index].id),
                          ),
                  ),
                );
              },
              itemCount: transactions.length,
            ),
    );
  }
}
