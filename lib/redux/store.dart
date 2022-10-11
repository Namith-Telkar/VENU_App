import '../models/venuUser.dart';

class AppState {
  bool darkTheme = true;
  VenuUser? user;
  List<dynamic>? rooms;
  bool? roomsUpdated;

  AppState({this.user});

  AppState.copyWith({
    required AppState prev,
    VenuUser? user,
    bool? darkTheme,
    List<dynamic>? rooms,
    bool? roomsUpdated,
  }) {
    this.user = user ?? prev.user;
    this.darkTheme = darkTheme ?? prev.darkTheme;
    this.rooms = rooms ?? prev.rooms;
    this.roomsUpdated = roomsUpdated ?? prev.roomsUpdated;
  }

  AppState.initial() {
    user = null;
    rooms = null;
    roomsUpdated = true;
  }
}
