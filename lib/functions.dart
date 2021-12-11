import 'dart:math';

import 'package:mock_data/mock_data.dart';

import 'model/user.dart';

List<User> createUsers({int? userCount}) {
  List<User> userList = [];
  int randomCount = Random().nextInt(9) + 1;
  for (var i = 0; i < (userCount ?? randomCount); i++) {
    userList.add(
      User(mockName()),
    );
  }
  return userList;
}
