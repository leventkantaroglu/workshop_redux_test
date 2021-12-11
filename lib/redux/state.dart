import 'package:workshop_redux_test/model/user.dart';

class AppState {
  List<User> users;
  int? selectedUserIndex;
  AppState(this.users, [this.selectedUserIndex]);

  User? get selectedUser =>
      selectedUserIndex != null ? users[selectedUserIndex!] : null;
}
