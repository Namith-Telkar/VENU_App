import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:venu/screens/sign_in/sign_in.dart';
import 'package:venu/services/dialog_manager.dart';

import '../../provider/google_sign_in.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffE5E5E5),
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 0.0),
                child: OutlinedButton(
                  onPressed: () async {
                    final provider =
                    Provider.of<GoogleSignInProvider>(
                        context,
                        listen: false);
                    await provider.logout();
                    Navigator.pushReplacementNamed(context, SignIn.routeName);
                  },
                  style: OutlinedButton.styleFrom(
                    shape: const StadiumBorder(),
                    minimumSize:
                    const Size(double.infinity, 56),
                    primary: Colors.white,
                    side: const BorderSide(
                      color: Color(0xffA7D1D7),
                      width: 3.0,
                    ),
                  ),
                  child: const Text(
                    'Sign out',
                    style: TextStyle(
                      fontFamily: "Google-Sans",
                      fontSize: 18.0,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
