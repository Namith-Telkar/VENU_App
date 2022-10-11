import '../models/venuUser.dart';

abstract class Action {}

class ToggleTheme extends Action {
  bool darkTheme;

  ToggleTheme({this.darkTheme = true});
}

class UpdateNewUser extends Action {
  VenuUser newUser;

  UpdateNewUser({required this.newUser});
}

class UpdateRooms extends Action {
  List<dynamic> rooms;
  bool roomsUpdated;

  UpdateRooms({required this.rooms, required this.roomsUpdated});
}
