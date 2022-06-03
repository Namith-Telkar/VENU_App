import '../models/user.dart';

class AppState {
  bool darkTheme = true;
  User? user;

  AppState({this.user});

  AppState.copyWith({
    required AppState prev,
    User? user,
    bool? darkTheme,
  }) {
    this.user = user ?? prev.user;
    this.darkTheme = darkTheme ?? prev.darkTheme;
  }

  AppState.initial() {
    user = null;
  }
}
