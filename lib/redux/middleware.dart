import 'package:redux/redux.dart';
import 'package:workshop_redux_test/functions.dart';
import 'package:workshop_redux_test/main.dart';
import 'package:workshop_redux_test/model/user.dart';

import 'action.dart';
import 'state.dart';

void recreationMiddleware(
  Store<AppState> store,
  dynamic action,
  NextDispatcher next,
) {
  if (action is RecreateList) {
    List<User> userList = createUsers(userCount: action.payload);
    store.dispatch(
      SetUsers(userList),
    );
  }
  next(action);
}

void userSelectionMiddleware(
  Store<AppState> store,
  dynamic action,
  NextDispatcher next,
) {
  if (action is SelectUser) {
    int selectedUserIndex = action.payload;
    store.dispatch(
      SetSelectedUser(selectedUserIndex),
    );
  }
  next(action);
}

void userEditMiddleware(
  Store<AppState> store,
  dynamic action,
  NextDispatcher next,
) {
  if (action is EditUser) {
    List<User> userList = store.state.users;

    userList.where((user) => user == store.state.selectedUser).first.name =
        action.updatedName;
    store.dispatch(
      GetEditedUserList(
        userList,
        userList.indexOf(store.state.selectedUser!),
      ),
    );
  }
  next(action);
}
