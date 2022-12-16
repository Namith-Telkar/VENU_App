import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:provider/provider.dart';
import 'package:rive/rive.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:venu/models/AppConfigs.dart';
import 'package:venu/screens/intro_screen/intro_screen.dart';
import 'package:venu/screens/landing/landing.dart';
import 'package:venu/services/network_helper.dart';

import '../../models/venuUser.dart';
import '../../provider/google_sign_in.dart';
import '../../redux/actions.dart';
import '../../redux/store.dart';
import '../../services/dialog_manager.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);
  static const routeName = '/';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late AppState _appState;
  static const int APP_VERSION = 3;

  void showUpdateAppDialog(Uri url) {
    DialogManager.showErrorDialog(
      'A new version of venU is available. Please update the app to continue.',
      context,
      false,
      () async {
        await launchUrl(
          url,
          mode: LaunchMode.externalApplication,
        );
      },
    );
  }

  Future<void> getAllDetailsAndRedirect() async {
    Map<String, Future> futures = {};

    futures['appConfigsResult'] = NetworkHelper.getAppConfigs();

    if (FirebaseAuth.instance.currentUser != null) {
      String googleToken =
          await FirebaseAuth.instance.currentUser!.getIdToken();
      futures['userResult'] = NetworkHelper.getUser(googleToken);
    }

    // wait for app config to arrive
    Map<String, dynamic> appConfigsResult = await futures['appConfigsResult'];
    AppConfigs appConfigs = appConfigsResult['appConfigs'];
    if (!mounted) return;
    StoreProvider.of<AppState>(context).dispatch(
      UpdateAppConfigs(
        appConfigs: appConfigs,
      ),
    );

    if (appConfigs.appVersion > APP_VERSION) {
      showUpdateAppDialog(appConfigs.appLink);
      return;
    }

    if (FirebaseAuth.instance.currentUser != null) {
      // wait for firebase user to arrive
      Map<String, dynamic> userResult = await futures['userResult'];
      if (!mounted) return;

      if (userResult['success']) {
        VenuUser user = userResult['user'] as VenuUser;
        StoreProvider.of<AppState>(context).dispatch(
          UpdateNewUser(
            newUser: user,
          ),
        );
        Navigator.pushReplacementNamed(context, Landing.routeName);
      } else {
        final provider = Provider.of<GoogleSignInProvider>(
          context,
          listen: false,
        );
        await provider.logout();
        if (!mounted) return;
        Navigator.pushReplacementNamed(context, IntroScreen.routeName);
      }
    } else {
      if (!mounted) return;
      Navigator.pushReplacementNamed(context, IntroScreen.routeName);
    }
  }

  // Future<void> getAndRedirect() async {
  //   if (FirebaseAuth.instance.currentUser != null) {
  //     String googleToken =
  //         await FirebaseAuth.instance.currentUser!.getIdToken();
  //     Map<String, dynamic> result = await NetworkHelper.getUser(googleToken);
  //     if (!mounted) return;
  //     if (result['success']) {
  //       VenuUser user = VenuUser.fromNetworkMap(result['user']);
  //       StoreProvider.of<AppState>(context)
  //           .dispatch(UpdateNewUser(newUser: user));
  //       Navigator.pushReplacementNamed(context, Landing.routeName);
  //     } else {
  //       final provider =
  //           Provider.of<GoogleSignInProvider>(context, listen: false);
  //       await provider.logout();
  //       if (!mounted) return;
  //       Navigator.pushReplacementNamed(context, IntroScreen.routeName);
  //     }
  //   } else {
  //     Map<String, dynamic> result = await NetworkHelper.getUser('token');
  //     if (!mounted) return;
  //     // StoreProvider.of<AppState>(context).dispatch(
  //     //   UpdateVenueTypes(venueTypes: result['venueTypes']),
  //     // );
  //     Navigator.pushReplacementNamed(context, IntroScreen.routeName);
  //   }
  // }

  @override
  void initState() {
    super.initState();
    // Future.delayed(
    //   const Duration(seconds: 1),
    //   getAndRedirect,
    // );
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getAllDetailsAndRedirect();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffE5E5E5),
      resizeToAvoidBottomInset: false,
      body: StoreConnector<AppState, AppState>(
        converter: (store) => store.state,
        builder: (context, state) {
          _appState = state;
          return SafeArea(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  SizedBox(
                    width: 150.0,
                    height: 50.0,
                    child: RiveAnimation.asset('assets/images/venu-logo.riv'),
                  ),
                  SizedBox(height: 20.0),
                  Text(
                    'venU',
                    style: TextStyle(
                      fontFamily: 'Google-Sans',
                      fontSize: 24.0,
                      letterSpacing: 6.0,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
