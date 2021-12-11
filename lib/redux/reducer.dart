import 'action.dart';
import 'state.dart';

AppState appReducer(AppState prevState, dynamic action) {
  if (action is ClearList) {
    return AppState([]);
  } else if (action is SetUsers) {
    return AppState(action.payload);
  } else if (action is SetSelectedUser) {
    return AppState(prevState.users, action.payload);
  } else if (action is GetEditedUserList) {
    return AppState(action.users, action.selectedIndex);
  }
  return prevState;
}
