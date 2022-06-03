import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:venu/redux/actions.dart';
import 'package:venu/redux/reducers.dart';
import 'package:venu/redux/store.dart';
import 'package:venu/screens/home/home.dart';
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
    return StoreProvider<AppState>(
      store: _store,
      child: StoreConnector<AppState, AppState>(
          converter: (store) => store.state,
          builder: (context, state) {
            appStateContext = context;
            getCurrentAppTheme(appStateContext);
            return MaterialApp(
              theme: Styles.themeData(state.darkTheme),
              debugShowCheckedModeBanner: false,
              routes: {
                // SplashScreen.routeName: (context) => SplashScreen(),
                // LoginPage.routeName: (context) => LoginPage(),
                Home.routeName: (context) => const Home(),
              },
            );
          }),
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
