import 'dart:io';
import 'package:expense_planner_mobile_app/widgets/chart.dart';
import 'package:flutter/cupertino.dart';
import './widgets/transaction_list.dart';
import './widgets/new_transaction.dart';
import 'package:flutter/material.dart';
import './models/transaction.dart';
import 'constants_and_styles.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      debugShowCheckedModeBanner: false,
      title: 'Personal Expenses',

      theme: ThemeData(
        primarySwatch: Colors.green,
        primaryColor: Colors.purple,

        fontFamily: 'Quicksand',
        textTheme: ThemeData.light().textTheme.copyWith(
              titleMedium: kTitleMediumTextStyle,
            ),

        //AppBar Theme style
        appBarTheme: const AppBarTheme(
          titleTextStyle: kAppBarTextStyle,
        ),
      ),

      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with WidgetsBindingObserver {
  //The main transaction list
  final List<Transaction> _userTransaction = [];

  bool _showChart = false;

  //===============================================================================================
  //Checking App life cycle part
  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // print(state);
  }

  @override
  dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  //===============================================================================================
  //Taking the last 7 days transactions
  List<Transaction> get _recentTransactions {
    return _userTransaction.where((tx) {
      return tx.date.isAfter(
        DateTime.now().subtract(
          const Duration(days: 7),
        ),
      );
    }).toList();
  }

  //===============================================================================================
  //Adding new transaction to list
  void _addNewTransaction(
      String txTitle, double txAmount, DateTime chosenDate) {
    final newTx = Transaction(
      id: DateTime.now().toString(),
      title: txTitle,
      amount: txAmount,
      date: chosenDate,
    );
    setState(() {
      _userTransaction.add(newTx);
    });
  }

  //===============================================================================================
  //For showing text filed using bottom sheet
  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (context) {
        return GestureDetector(
          onTap: () {},
          behavior: HitTestBehavior.opaque,
          child: NewTransaction(addTx: _addNewTransaction),
        );
      },
    );
  }

  //===============================================================================================
  //For deleting Transaction from the list
  void _deleteTransaction(String id) {
    setState(() {
      _userTransaction.removeWhere((tx) => tx.id == id);
    });
  }

  //===============================================================================================
  //A builder for Landscape device mode
  List<Widget> _buildLandscapeContent(
      BuildContext context, PreferredSizeWidget appBar, Widget txListWidget) {
    final MediaQueryData mediaQuery = MediaQuery.of(context);

    return [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Show Chart',
            style: kTitleMediumTextStyle,
          ),
          Switch.adaptive(
            activeColor: Colors.yellow,
            value: _showChart,
            onChanged: (bool value) {
              setState(() {
                _showChart = value;
              });
            },
          )
        ],
      ),
      _showChart
          ? SizedBox(
              height: (mediaQuery.size.height -
                      appBar.preferredSize.height -
                      mediaQuery.padding.top) *
                  0.7,
              child: Chart(recentTransactions: _recentTransactions),
            )
          : txListWidget
    ];
  }

  //===============================================================================================
  //A builder for portrait device mode
  List<Widget> _buildPortraitContent(
      BuildContext context, PreferredSizeWidget appBar, Widget txListWidget) {
    final MediaQueryData mediaQuery = MediaQuery.of(context);

    return [
      SizedBox(
        height: (mediaQuery.size.height -
                appBar.preferredSize.height -
                mediaQuery.padding.top) *
            0.3,
        child: Chart(recentTransactions: _recentTransactions),
      ),
      txListWidget
    ];
  }


  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    final isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;

    //Appbar selector for IOS and Android platform
    final PreferredSizeWidget appBar = Platform.isIOS //For IOS part
        ? CupertinoNavigationBar(
            middle: const Text('Personal Expense'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,

              children: [
                GestureDetector(
                  child: const Icon(CupertinoIcons.add, color: Colors.white,),
                  onTap: () => _startAddNewTransaction(context),
                ),
              ],
            ),
          )

        //For Android part
        : AppBar(
            title: const Text('Personal Expenses'),
            backgroundColor: Theme.of(context).primaryColor,
            actions: [
              IconButton(
                onPressed: () => _startAddNewTransaction(context),
                icon: const Icon(Icons.add, color: Colors.white,),
              ),
            ],
          ) as PreferredSizeWidget;

    //Transaction list, stored in variable
    final txListWidget = SizedBox(
      height: (mediaQuery.size.height -
              appBar.preferredSize.height -
              mediaQuery.padding.top) *
          0.7,
      child: TransactionList(
        transactions: _userTransaction,
        deleteTX: _deleteTransaction,
      ),
    );

    //The whole page body, stored in variable
    final pageBody = SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (isLandscape)
              ..._buildLandscapeContent(context, appBar, txListWidget),
            if (!isLandscape)
              ..._buildPortraitContent(context, appBar, txListWidget),
          ],
        ),
      ),
    );

    //Choosing the scaffold type for different platform
    return Platform.isIOS
        ? CupertinoPageScaffold(
            navigationBar: appBar as ObstructingPreferredSizeWidget,
            child: pageBody,
          )
        : Scaffold(
            appBar: appBar,
            body: pageBody,
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton: Platform.isIOS
                ? Container()
                : FloatingActionButton(
                    elevation: 10,
                    backgroundColor: Theme.of(context).primaryColor,

                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),

                    onPressed: () => _startAddNewTransaction(context),
                    child: const Icon(Icons.add, color: Colors.white,),
                  ),
          );
  }
}
