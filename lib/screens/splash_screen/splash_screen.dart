import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'package:venu/screens/intro_screen/intro_screen.dart';
import 'package:venu/screens/landing/landing.dart';

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
      () => {
        if (FirebaseAuth.instance.currentUser != null)
          {Navigator.pushReplacementNamed(context, Landing.routeName)}
        else
          {Navigator.pushReplacementNamed(context, IntroScreen.routeName)}
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
