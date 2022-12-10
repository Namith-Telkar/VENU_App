import 'package:venu/redux/store.dart';
import '../services/dart_theme_preferences.dart';
import 'actions.dart';

AppState reducers(AppState prevState, dynamic action) {
  AppState newState;
  if (action is ToggleTheme) {
    DarkThemePreference darkThemePreference = DarkThemePreference();
    darkThemePreference.setDarkTheme(action.darkTheme);
    newState = AppState.copyWith(prev: prevState, darkTheme: action.darkTheme);
  } else if (action is UpdateNewUser) {
    newState = AppState.copyWith(prev: prevState, user: action.newUser);
  } else if (action is UpdateRooms) {
    newState = AppState.copyWith(
      prev: prevState,
      rooms: action.rooms,
      roomsUpdated: action.roomsUpdated,
    );
  } else if (action is UpdateUserSuggestions) {
    newState = AppState.copyWith(
      prev: prevState,
      userSuggestions: action.userSuggestions,
    );
  } else if (action is UpdateVenueTypes) {
    newState = AppState.copyWith(
      prev: prevState,
      venueTypes: action.venueTypes,
    );
  } else {
    newState = AppState.copyWith(prev: prevState);
  }
  return newState;
}
