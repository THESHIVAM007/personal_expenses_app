import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:personal_expenses_name/widgets/chart.dart';
import './widgets/chart.dart';
// import 'package:personal_expenses_name/widgets/transaction_list.dart';
// import 'package:personal_expenses_name/widgets/new_transaction.dart';
// import 'package:personal_expenses_name/widgets/user_transaction.dart';
import '../widgets/new_transaction.dart';
import 'widgets/transaction_list.dart';
import '../model/transactions.dart';
// import './widgets/user_transaction.dart

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Personel Expenses App',
      theme: ThemeData(
        primarySwatch: Colors.orange,
        fontFamily: 'Quicksand',
        textTheme: ThemeData.light().textTheme.copyWith(
              titleMedium: TextStyle(
                fontFamily: 'OpenSans',
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
        appBarTheme: AppBarTheme(
          titleTextStyle: ThemeData.light()
              .textTheme
              .copyWith(
                titleMedium: TextStyle(
                  fontFamily: 'Quicksand',
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              )
              .titleMedium,
        ),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // late String textInput;
  final List<Transactions> _userTransactions = [
    // Transactions(
    //   id: 't1',
    //   title: 'Shoes',
    //   amount: 79.99,
    //   date: DateTime.now(),
    // ),
    // Transactions(
    //   id: 't2',
    //   title: 'Clothes',
    //   amount: 50.99,
    //   date: DateTime.now(),
    // ),
    // Transactions(
    //   id: 't3',
    //   title: 'Mobile',
    //   amount: 399.99,
    //   date: DateTime.now(),
    // ),
  ];
  bool _showChart = false;
  List<Transactions> get _recentTrans {
    return _userTransactions.where((tx) {
      return tx.date.isAfter(DateTime.now().subtract(
        Duration(days: 7),
      ));
    }).toList();
  }

  void _addNewTransaction(String title, double amount, DateTime chosenDate) {
    final newTx = Transactions(
        amount: amount,
        date: chosenDate,
        id: DateTime.now().toString(),
        title: title);
    setState(() {
      _userTransactions.add(newTx);
    });
  }

  void _startNewTranx(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return GestureDetector(
          onTap: () {},
          // behavior: op,
          child: NewTransaction(_addNewTransaction),
        );
      },
    );
  }

  void _deleteTranx(String id) {
    setState(() {
      _userTransactions.removeWhere((element) => element.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final isLandscape = mediaQuery.orientation == Orientation.landscape;
    final appbar = Platform.isIOS? CupertinoNavigationBar(middle: Text('Personal Expenses'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                GestureDetector(
                    child: Icon(CupertinoIcons.add),
                    onTap: () => _startNewTranx(context))
              ],
            )) :AppBar(
      title: Text('Personal Expenses '),
      actions: <Widget>[
        IconButton(
          onPressed: () => _startNewTranx(context),
          icon: Icon(
            Icons.add,
          ),
        )
      ],
    )as PreferredSizeWidget ;
    final txwidget = Container(
                height: (mediaQuery.size.height -
                        appbar.preferredSize.height -
                        mediaQuery.padding.top) *
                    .7,
                child: TransactionList(_userTransactions, _deleteTranx),);
       final appBody = SafeArea(
         child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              if(isLandscape) Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('Show Chart',
                  style: Theme.of(context).textTheme.titleMedium,),
                  Switch.adaptive(
                      value: _showChart,
                      onChanged: (val) {
                        setState(() {
                          _showChart = val;
                        });
                      }),
                ],
              ),
             if(!isLandscape) Container(
                  height: (mediaQuery.size.height -
                          appbar.preferredSize.height -
                          mediaQuery.padding.top) *
                      .3,
                  child: Chart(_recentTrans)),
                 if(!isLandscape)txwidget, 
              if(isLandscape) _showChart ?
              Container(
                  height: (mediaQuery.size.height -
                          appbar.preferredSize.height -
                          mediaQuery.padding.top) *
                      .7,
                  child: Chart(_recentTrans))
               : txwidget,
            ],
          ),
             ),
       );         
    return Platform.isIOS? CupertinoPageScaffold(child: appBody,navigationBar: appbar as ObstructingPreferredSizeWidget,) :Scaffold(
      appBar: appbar,
      body: appBody,
      floatingActionButton: Platform.isIOS? Container() :FloatingActionButton(
        onPressed: () => _startNewTranx(context),
        child: Icon(Icons.add),
      ),
    );
  }
}
