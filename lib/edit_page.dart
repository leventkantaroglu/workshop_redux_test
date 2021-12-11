import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'model/user.dart';
import 'redux/action.dart';
import 'redux/state.dart';

class EditPage extends StatelessWidget {
  const EditPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          StoreConnector<AppState, AppState>(
              converter: (store) => store.state,
              builder: (context, state) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    initialValue: state.selectedUser!.name,
                    onChanged: (value) {
                      StoreProvider.of<AppState>(context).dispatch(
                        EditUser(state.selectedUser!, value),
                      );
                    },
                  ),
                );
              }),
        ],
      ),
    );
  }
}
