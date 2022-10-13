// ignore_for_file: prefer_const_constructors

import '../widget/chart.dart';

import '../widget/transaction_list.dart';
import '../widget/new_transaction.dart';
import 'package:flutter/material.dart';
import 'model/transaction.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations(
  //     [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Personal Expenses',
      theme: ThemeData(
        primarySwatch: Colors.orange,
        accentColor: Colors.purple,
        fontFamily: 'Quicksand',
        errorColor: Colors.red,
        appBarTheme: AppBarTheme(
            titleTextStyle: TextStyle(
          color: Colors.white,
          fontFamily: 'OpenSans',
          fontSize: 20,
          fontWeight: FontWeight.bold,
        )),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  // String titleInput;
  // String amountInput;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _userTransactions = [
    Transaction(
        id: DateTime.now().toString(),
        item: 'Coffee',
        amount: 5.231,
        date: DateTime.now()),
    Transaction(
        id: DateTime.now().toString(),
        item: 'Coffee',
        amount: 5.231,
        date: DateTime.now()),
    Transaction(
        id: DateTime.now().toString(),
        item: 'Coffee',
        amount: 5.231,
        date: DateTime.now()),
    Transaction(
        id: DateTime.now().toString(),
        item: 'Coffee',
        amount: 5.231,
        date: DateTime.now()),
    Transaction(
        id: DateTime.now().toString(),
        item: 'Coffee',
        amount: 5.231,
        date: DateTime.now()),
  ];

  List<Transaction> get recentTransactions {
    return _userTransactions.where((tx) {
      return tx.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  bool _showChart = false;

  void _addNewTransaction(
      String txTitle, double txAmount, DateTime chosenDate) {
    final newTx = Transaction(
      item: txTitle,
      amount: txAmount,
      date: chosenDate,
      id: DateTime.now().toString(),
    );

    setState(() {
      _userTransactions.add(newTx);
    });
  }

  void startNewTransactoin(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return NewTransactions(_addNewTransaction);
      },
    );
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTransactions.removeWhere((element) => element.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuert = MediaQuery.of(context);
    final isLandscape = mediaQuert.orientation == Orientation.landscape;
    final appBar = AppBar(
      title: Text(
        'Personal Expenses',
      ),
      actions: [
        IconButton(
          color: Colors.white,
          onPressed: () => startNewTransactoin(context),
          icon: Icon(
            Icons.add,
          ),
        ),
      ],
    );

    final txListWidget = Container(
      child: TransactionList(_userTransactions, _deleteTransaction),
      height: (mediaQuert.size.height -
              appBar.preferredSize.height -
              mediaQuert.padding.top) *
          0.7,
    );

    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            if (isLandscape)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Show Chart:'),
                  Switch(
                      value: _showChart,
                      onChanged: (val) {
                        setState(() {
                          _showChart = val;
                        });
                      })
                ],
              ),
            if (!isLandscape)
              Container(
                child: Chart(recentTransactions),
                height: (mediaQuert.size.height -
                        appBar.preferredSize.height -
                        mediaQuert.padding.top) *
                    0.3,
              ),
            if (!isLandscape) txListWidget,
            if (isLandscape)
              _showChart
                  ? Container(
                      child: Chart(recentTransactions),
                      height: (mediaQuert.size.height -
                              appBar.preferredSize.height -
                              mediaQuert.padding.top) *
                          0.7,
                    )
                  : txListWidget
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => startNewTransactoin(context),
      ),
    );
  }
}
