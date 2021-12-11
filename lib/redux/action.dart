import 'package:workshop_redux_test/model/user.dart';

abstract class AppAction {}

class ClearList extends AppAction {}

class RecreateList extends AppAction {
  int payload;
  RecreateList(this.payload);
}

class SetUsers extends AppAction {
  List<User> payload;
  SetUsers(this.payload);
}

class SelectUser extends AppAction {
  int payload;
  SelectUser(this.payload);
}

class SetSelectedUser extends AppAction {
  int payload;
  SetSelectedUser(this.payload);
}

class EditUser extends AppAction {
  User user;
  String updatedName;
  EditUser(this.user, this.updatedName);
}

class GetEditedUserList extends AppAction {
  List<User> users;
  int selectedIndex;
  GetEditedUserList(this.users, this.selectedIndex);
}
