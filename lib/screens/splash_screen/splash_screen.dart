import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:provider/provider.dart';
import 'package:rive/rive.dart';
import 'package:venu/screens/intro_screen/intro_screen.dart';
import 'package:venu/screens/landing/landing.dart';
import 'package:venu/services/network_helper.dart';

import '../../models/venuUser.dart';
import '../../provider/google_sign_in.dart';
import '../../redux/actions.dart';
import '../../redux/store.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);
  static const routeName = '/';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(
      const Duration(seconds: 3),
      () async {
        if (FirebaseAuth.instance.currentUser != null)
          {
            String googleToken = await FirebaseAuth.instance.currentUser!.getIdToken();
            Map<String,dynamic> result = await NetworkHelper.getUser(googleToken);
            if(result['success']){
              VenuUser user = VenuUser.fromNetworkMap(result['user']);
              StoreProvider.of<AppState>(context).dispatch(
                  UpdateNewUser(newUser: user)
              );
              Navigator.pushReplacementNamed(context, Landing.routeName);
            }
            else{
              final provider = Provider.of<GoogleSignInProvider>(context, listen: false);
              await provider.logout();
              Navigator.pushReplacementNamed(context, IntroScreen.routeName);
            }
          }
        else
          {
            Navigator.pushReplacementNamed(context, IntroScreen.routeName);
          }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffE5E5E5),
      resizeToAvoidBottomInset: false,
      body: SafeArea(
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
                'VenU',
                style: TextStyle(
                    fontFamily: 'Google-Sans',
                    fontSize: 24.0,
                    letterSpacing: 6.0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
