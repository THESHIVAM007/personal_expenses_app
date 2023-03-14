import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../model/transactions.dart';

class TransactionList extends StatelessWidget {
  final List<Transactions> transactions;
  final Function deleteTranx;
  TransactionList(this.transactions,this.deleteTranx);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: transactions.isEmpty
          ? Column(
              children: <Widget>[
                Text(
                  'No transaction added yet',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 200,
                  child: Image.asset(
                    'assests/image/waiting.png',
                    fit: BoxFit.cover,
                  ),
                )
              ],
            )
          : ListView.builder(
              itemBuilder: (ctx, index) {
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                  elevation: 6,
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      child: Padding(
                        padding: EdgeInsets.all(6.0),
                        child: FittedBox(
                            child: Text('\$${transactions[index].amount}')),
                      ),
                    ),
                    title: Text(transactions[index].title,
                        style: Theme.of(context).textTheme.titleMedium),
                    subtitle: Text(
                      DateFormat.yMMMd().format(transactions[index].date),
                    ),
                    trailing: IconButton(
                      onPressed: () =>deleteTranx(transactions[index].id),
                      icon: Icon(Icons.delete),
                      color: Theme.of(context).colorScheme.error,),
                  ),
                );
              },
              itemCount: transactions.length,
            ),
    );
  }
}
