import '../models/venuUser.dart';

class AppState {
  bool darkTheme = true;
  VenuUser? user;
  List<dynamic>? rooms;
  List<dynamic>? userSuggestions;
  bool? roomsUpdated;
  Map venueTypes = {};

  AppState({this.user});

  AppState.copyWith({
    required AppState prev,
    VenuUser? user,
    bool? darkTheme,
    List<dynamic>? rooms,
    bool? roomsUpdated,
    List<dynamic>? userSuggestions,
    Map? venueTypes,
  }) {
    this.user = user ?? prev.user;
    this.darkTheme = darkTheme ?? prev.darkTheme;
    this.rooms = rooms ?? prev.rooms;
    this.roomsUpdated = roomsUpdated ?? prev.roomsUpdated;
    this.userSuggestions = userSuggestions ?? prev.userSuggestions;
    this.venueTypes = venueTypes ?? prev.venueTypes;
  }

  AppState.initial() {
    user = null;
    rooms = null;
    roomsUpdated = true;
    userSuggestions = null;
    venueTypes = {};
  }
}
