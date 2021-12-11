import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:redux_logging/redux_logging.dart';
import 'package:workshop_redux_test/redux/state.dart';
import 'package:logging/logging.dart';

import 'edit_page.dart';
import 'functions.dart';
import 'redux/action.dart';
import 'redux/middleware.dart';
import 'redux/reducer.dart';

void main() {
  Store<AppState> store = Store<AppState>(
    appReducer,
    initialState: AppState(createUsers()),
    middleware: [
      recreationMiddleware,
      userSelectionMiddleware,
      userEditMiddleware,
      LoggingMiddleware.printer(
        level: Level.WARNING,
      )
    ],
  );
  runApp(MyApp(store));
}

class MyApp extends StatelessWidget {
  final Store<AppState> store;
  const MyApp(this.store, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: store,
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const MyHomePage(title: 'Flutter Demo Home Page'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<String> items = [];

  @override
  void initState() {
    createUsers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [],
      ),
      body: Center(
        child: StoreConnector<AppState, AppState>(
            converter: (store) => store.state,
            builder: (context, state) {
              return SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    TextButton(
                      child: const Text("Clear List"),
                      onPressed: () {
                        StoreProvider.of<AppState>(context)
                            .dispatch(ClearList());
                      },
                    ),
                    TextButton(
                      child: const Text("Recreate List with 2 users"),
                      onPressed: () {
                        StoreProvider.of<AppState>(context)
                            .dispatch(RecreateList(2));
                      },
                    ),
                    TextButton(
                      child: const Text("Recreate List with 10 users"),
                      onPressed: () {
                        StoreProvider.of<AppState>(context)
                            .dispatch(RecreateList(10));
                      },
                    ),
                    const Divider(),
                    for (var item in state.users)
                      ListTile(
                        title: Text(item.name),
                        trailing: IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () {
                            StoreProvider.of<AppState>(context).dispatch(
                              SelectUser(state.users.indexOf(item)),
                            );
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const EditPage(),
                              ),
                            );
                          },
                        ),
                      ),
                  ],
                ),
              );
            }),
      ),
    );
  }
}
