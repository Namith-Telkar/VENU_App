import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:venu/screens/sign_in/sign_in.dart';
import 'package:venu/services/dialog_manager.dart';
import 'package:venu/redux/store.dart';
import '../../provider/google_sign_in.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  late BuildContext appStateContext;

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState,AppState>(
      converter: (store) => store.state,
      builder: (context,state) {
        appStateContext = context;
          return Scaffold(
            backgroundColor: const Color(0xffE5E5E5),
            resizeToAvoidBottomInset: false,
            body: SafeArea(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const SizedBox(
                      height: 20.0,
                    ),
                    CircleAvatar(
                      radius: 75.0,
                      backgroundImage: NetworkImage(FirebaseAuth.instance.currentUser!.photoURL as String),
                    ),
                    Text(
                      FirebaseAuth.instance.currentUser!.displayName as String,
                      style: const TextStyle(
                        fontFamily: 'Google-Sans',
                        fontSize: 22.0,
                      ),
                    ),
                    Text(
                      'Personality type : ${StoreProvider.of<AppState>(appStateContext).state.user?.personality}',
                      style: const TextStyle(
                        fontFamily: 'Google-Sans',
                        fontSize: 18.0,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 40.0, vertical: 0.0),
                      child:ElevatedButton(
                        onPressed: () async {
                          final provider =
                          Provider.of<GoogleSignInProvider>(
                              context,
                              listen: false);
                          await provider.logout();
                          Navigator.pushReplacementNamed(context, SignIn.routeName);
                        },
                        style: ElevatedButton.styleFrom(
                          shape: const StadiumBorder(),
                          minimumSize:
                          const Size(double.infinity, 56),
                          primary: const Color(0xffA7D1D7),
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
                    SizedBox(
                      height: MediaQuery.of(context).size.height*0.2,
                    ),
                  ],
                ),
              ),
            ),
          );
        }
    );
  }
}
