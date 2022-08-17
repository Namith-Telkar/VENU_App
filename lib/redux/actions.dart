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
