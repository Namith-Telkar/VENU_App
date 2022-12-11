import '../models/AppConfigs.dart';
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

class UpdateUserSuggestions extends Action {
  List<dynamic> userSuggestions;

  UpdateUserSuggestions({required this.userSuggestions});
}

class SignOutUser extends Action {}

class UpdateAppConfigs extends Action {
  AppConfigs appConfigs;

  UpdateAppConfigs({required this.appConfigs});
}
