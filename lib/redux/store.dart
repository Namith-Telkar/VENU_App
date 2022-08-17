import '../models/venuUser.dart';

class AppState {
  bool darkTheme = true;
  VenuUser? user;

  AppState({this.user});

  AppState.copyWith({
    required AppState prev,
    VenuUser? user,
    bool? darkTheme,
  }) {
    this.user = user ?? prev.user;
    this.darkTheme = darkTheme ?? prev.darkTheme;
  }

  AppState.initial() {
    user = null;
  }
}
