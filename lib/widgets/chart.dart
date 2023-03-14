import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:personal_expenses_name/widgets/chart_bar.dart';
// import 'package:personal_expenses_name/model/transactions.dart';
import '../model/transactions.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter/src/widgets/placeholder.dart';

class Chart extends StatelessWidget {
  final List<Transactions> recentTrans;

  Chart(this.recentTrans);

  List<Map<String, Object>> get groupedTransactionVal {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(
        Duration(days: index),
      );
      var totalSum = 0.0;
      for (var i = 0; i < recentTrans.length; i++) {
        if (recentTrans[i].date.day == weekDay.day &&
            recentTrans[i].date.month == weekDay.month &&
            recentTrans[i].date.year == weekDay.year) {
          totalSum += recentTrans[i].amount;
        }
      }
      // print( DateFormat.E().format(weekDay));
      // print( totalSum);
      return {
        "day": DateFormat.E().format(weekDay).substring(0, 1),
        'amount': totalSum,
      };
    }).reversed.toList();
  }

  double get maxSpending {
    return groupedTransactionVal.fold(0.0, (sum, item) {
      return sum + (item['amount'] as double);
    });
  }

  @override
  Widget build(BuildContext context) {
    // print(groupedTransactionVal);
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedTransactionVal.map((data) {
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar((data['day'] as String), (data['amount'] as double),
                maxSpending==0.0?0.0:  (data['amount'] as double) / maxSpending),
            );
          }).toList(),
        ),
      ),
    );
  }
}
