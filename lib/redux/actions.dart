import '../models/user.dart';

abstract class Action {}

class ToggleTheme extends Action {
  bool darkTheme;

  ToggleTheme({this.darkTheme = true});
}

class UpdateNewUser extends Action {
  User newUser;

  UpdateNewUser({required this.newUser});
}
