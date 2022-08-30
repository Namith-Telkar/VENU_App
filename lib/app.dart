import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:provider/provider.dart';
import 'package:redux/redux.dart';
import 'package:venu/provider/google_sign_in.dart';
import 'package:venu/redux/actions.dart';
import 'package:venu/redux/reducers.dart';
import 'package:venu/redux/store.dart';
import 'package:venu/screens/home/home.dart';
import 'package:venu/screens/inside_room/inside_room.dart';
import 'package:venu/screens/intro_screen/intro_screen.dart';
import 'package:venu/screens/landing/landing.dart';
import 'package:venu/screens/preferences/preferences.dart';
import 'package:venu/screens/room/room.dart';
import 'package:venu/screens/room_settings/room_settings.dart';
import 'package:venu/screens/sign_in/sign_in.dart';
import 'package:venu/screens/splash_screen/splash_screen.dart';
import 'package:venu/services/dart_theme_preferences.dart';
import 'package:venu/utilities/styles.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  late BuildContext appStateContext;
  final Store<AppState> _store =
      Store(reducers, initialState: AppState.initial());

  @override
  void initState() {
    super.initState();
  }

  void getCurrentAppTheme(appStateContext) async {
    DarkThemePreference darkThemePreference = DarkThemePreference();
    bool isDarkTheme = await darkThemePreference.getTheme();
    StoreProvider.of<AppState>(appStateContext)
        .dispatch(ToggleTheme(darkTheme: isDarkTheme));
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => GoogleSignInProvider(),
      child: StoreProvider<AppState>(
        store: _store,
        child: StoreConnector<AppState, AppState>(
            converter: (store) => store.state,
            builder: (context, state) {
              appStateContext = context;
              getCurrentAppTheme(appStateContext);
              return MaterialApp(
                theme: Styles.themeData(state.darkTheme),
                debugShowCheckedModeBanner: false,
                //initialRoute: '/inside_room',
                routes: {
                  SplashScreen.routeName: (context) => const SplashScreen(),
                  IntroScreen.routeName: (context) => IntroScreen(),
                  SignIn.routeName: (context) => const SignIn(),
                  Preferences.routeName: (context) => const Preferences(),
                  Room.routeName: (context) => const Room(),
                  Home.routeName: (context) => const Home(),
                  Landing.routeName: (context) => const Landing(),
                  RoomSettings.routeName: (context) => const RoomSettings(),
                },
              );
            }
            ),
      ),
    );
  }
}

// MaterialApp(
// theme: ThemeData(
// fontFamily: 'Manrope',
// scaffoldBackgroundColor: const Color(0xff202020),
// ),
// debugShowCheckedModeBanner: false,
// routes: {
// SplashScreen.routeName: (context) => SplashScreen(),
// LoginPage.routeName: (context) => LoginPage(),
// Home.routeName: (context) => Home(),
// },
// );

// StoreConnector<AppState, AppState>(
// converter: (store) => store.state,
// builder: (context, state) => Text('hi'))
