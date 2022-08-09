import 'package:flutter/material.dart';
import 'package:venu/screens/intro_screen/intro_screen.dart';

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
        Navigator.pushReplacementNamed(context, IntroScreen.routeName)
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset('assets/images/logo.png',),
                const SizedBox(height: 20.0),
                const Text('venU',style: TextStyle(fontFamily: 'Google-Sans',fontSize: 24.0,letterSpacing: 6.0),),
              ],
            ),
          ),
      ),
    );
  }
}
