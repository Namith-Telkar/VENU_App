import '../models/AppConfigs.dart';
import '../models/venuUser.dart';

class AppState {
  bool darkTheme = true;
  VenuUser? user;
  List<dynamic>? rooms;
  List<dynamic>? userSuggestions;
  bool? roomsUpdated;
  AppConfigs? appConfigs;

  AppState({this.user});

  AppState.copyWith({
    required AppState prev,
    VenuUser? user,
    bool? darkTheme,
    List<dynamic>? rooms,
    bool? roomsUpdated,
    List<dynamic>? userSuggestions,
    AppConfigs? appConfigs,
  }) {
    this.user = user ?? prev.user;
    this.darkTheme = darkTheme ?? prev.darkTheme;
    this.rooms = rooms ?? prev.rooms;
    this.roomsUpdated = roomsUpdated ?? prev.roomsUpdated;
    this.userSuggestions = userSuggestions ?? prev.userSuggestions;
    this.appConfigs = appConfigs ?? prev.appConfigs;
  }

  AppState.newUserAppState({
    required AppState prev,
  }) {
    darkTheme = prev.darkTheme;
    user = null;
    rooms = null;
    userSuggestions = null;
    roomsUpdated = true;
    appConfigs = prev.appConfigs;
  }

  AppState.initial() {
    user = null;
    rooms = null;
    roomsUpdated = true;
    userSuggestions = null;
    appConfigs = null;
  }
}
