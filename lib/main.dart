// Import the Flutter Material Design package
import 'package:flutter/material.dart';

// import 'package:flutter/services.dart';

// Import the custom widgets for the app
import './widgets/new_transaction.dart';
import './widgets/transaction_list.dart';
import './widgets/charts.dart';

// Import the Transaction model
import './models/transaction.dart';

// The entry point of the app
void main() {
  // NO LANDSCAPE MODE
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitUp,
  //   DeviceOrientation.portraitDown,
  // ]);
  runApp(const MyApp());
}

// Ihe top-level widget for the app
class MyApp extends StatelessWidget {
  const MyApp({
    super.key
  });

  // the method that builds the widget tree
  @override
  Widget build(BuildContext context) {
    // the main MaterialApp widget that configures the app's theme and routes
    return MaterialApp(
      title: 'Personal Expenses',
      theme: ThemeData(
        fontFamily: 'Quicksand',
        // configure the text theme for the app
        textTheme: ThemeData.light().textTheme.copyWith(
          titleMedium: const TextStyle(
              fontFamily: 'OpenSans',
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
            labelLarge: const TextStyle(
              color: Colors.white,
            ),
        ),
        // configure the app bar theme
        appBarTheme: AppBarTheme(
          // configure the app bar title text style
          titleTextStyle: ThemeData.light().textTheme.copyWith(
            titleMedium: const TextStyle(
              fontFamily: 'OpenSans',
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ).titleLarge,
          // configure the app bar toolbar text style
          toolbarTextStyle: ThemeData.light().textTheme.copyWith(
            titleMedium: const TextStyle(
              fontFamily: 'OpenSans',
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ).bodyMedium,
        ),
        // configure the color scheme for the app
        colorScheme:
        ColorScheme.fromSwatch(primarySwatch: Colors.purple).copyWith(
          secondary: Colors.amber,
        ),
      ),
      // set the home page to be MyHomePage widget
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key
  });

  // A stateful widget that creates a new instance of `_MyHomePageState`.
  @override
  // ignore:, library_private_types_in_public_api
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State < MyHomePage > {
  // A list of `Transaction` objects.
  final List < Transaction > _userTransactions = [];
  // ignore: unused_field
  bool _showChart = false;

  // A method that returns a list of recent transactions within the last 7 days.
  List < Transaction > get _recentTransactions {
    return _userTransactions.where((tx) {
      return tx.date.isAfter(
        DateTime.now().subtract(
          const Duration(days: 7),
        ),
      );
    }).toList();
  }

  // A method that adds a new transaction to the list of `_userTransactions`.
  void _addNewTransaction(String txTitle, double txAmount, DateTime choosenDate) {
    final newTx = Transaction(
      title: txTitle,
      amount: txAmount,
      date: choosenDate,
      id: DateTime.now().toString(),
    );

    setState(() {
      _userTransactions.add(newTx);
    });
  }

  // A method that shows the modal bottom sheet to add a new transaction.
  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return GestureDetector(
          onTap: () {},
          behavior: HitTestBehavior.opaque,
          child: NewTransaction(_addNewTransaction),
        );
      },
    );
  }

  // A method that deletes a transaction from the list of `_userTransactions`.
  void _deleteTransaction(String id) {
    setState(() {
      _userTransactions.removeWhere((tx) => tx.id == id);
    });
  }
  // Override the build method from the StatefulWidget to build the UI
  // of the application based on the state of the widget.
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final isLandscape = mediaQuery.orientation == Orientation.landscape;
    // Define the app bar widget.
    final appBar = AppBar(
      title: const Text(
          'Personal Expenses',
        ),
        actions: < Widget > [
          IconButton(
            icon: const Icon(Icons.add),
              onPressed: () => _startAddNewTransaction(context),
          ),
        ],
    );
    // Define the transaction list widget.
    final txListWidget = SizedBox(
      height: (mediaQuery.size.height - appBar.preferredSize.height) * 0.7,
      child: TransactionList(_userTransactions, _deleteTransaction));
    // Define the page body widget.
    final pageBody = SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: < Widget > [
            if (isLandscape) Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: < Widget > [
                  Text("Show Chart", style: Theme.of(context).textTheme.titleMedium, ),
                  Switch.adaptive(
                    activeColor: Colors.amber[700],
                    value: _showChart,
                    onChanged: (val) {
                      setState(() {
                        _showChart = val;
                      });
                    })
                ],
              ),
              if (!isLandscape)
                // A chart that displays the recent transactions.
                SizedBox(
                  height: (mediaQuery.size.height - appBar.preferredSize.height -
                    mediaQuery.padding.top) * 0.25,
                  child: Chart(_recentTransactions)
                ),
                if (!isLandscape) txListWidget,
                  if (isLandscape) _showChart ?
                    SizedBox(
                      height: (mediaQuery.size.height - appBar.preferredSize.height -
                        mediaQuery.padding.top) * 0.7,
                      child: Chart(_recentTransactions)
                    ) : txListWidget
          ],
        ),
      ),
    );
    // Define the page body widget.
    return Scaffold(
      appBar: appBar,
      body: pageBody,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
          onPressed: () => _startAddNewTransaction(context),
      ),
    );
  }
}