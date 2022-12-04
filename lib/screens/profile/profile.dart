import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:venu/screens/profile/profile_settings.dart';
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
                child: Stack(
                  children: [
                    Image.asset(
                        'assets/images/profile_background.png',
                      fit: BoxFit.cover,
                      width: double.infinity,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        const SizedBox(
                          height: 5.0,
                        ),
                        CircleAvatar(
                          radius: 50.0,
                          backgroundImage: NetworkImage(FirebaseAuth.instance.currentUser!.photoURL as String),
                        ),
                        Text(
                          '${StoreProvider.of<AppState>(appStateContext).state.user?.personality}',
                          style: const TextStyle(
                            fontFamily: 'Google-Sans',
                            fontSize: 18.0,
                          ),
                        ),
                        Text(
                          FirebaseAuth.instance.currentUser!.displayName as String,
                          style: const TextStyle(
                            fontFamily: 'Google-Sans',
                            fontSize: 22.0,
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 20.0),
                          child: Text(
                            '${StoreProvider.of<AppState>(appStateContext).state.user?.personalityDescription}',
                            style: const TextStyle(
                              fontFamily: 'Google-Sans',
                              fontSize: 16.0,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height*0.15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const FaIcon(
                              FontAwesomeIcons.coins,
                              size: 18.0,
                            ),
                            Text(
                              ' Credits : ${StoreProvider.of<AppState>(appStateContext).state.user?.credits.toString()}',
                              style: const TextStyle(
                                fontFamily: 'Google-Sans',
                                fontSize: 18.0,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height*0.05,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width*0.35,
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 10.0, vertical: 0.0),
                              child:OutlinedButton(
                                onPressed: () {
                                  Navigator.pushNamed(context, ProfileSettings.routeName);
                                },
                                style: OutlinedButton.styleFrom(
                                  minimumSize: const Size(double.infinity, 50),
                                  primary: Colors.white,
                                  side: const BorderSide(
                                    color: Color(0xffA7D1D7),
                                    width: 3.0,
                                  ),
                                ),
                                child: const Text(
                                  'Edit Profile',
                                  style: TextStyle(
                                    fontFamily: "Google-Sans",
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width*0.35,
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 10.0, vertical: 0.0),
                              child:ElevatedButton(
                                onPressed: () async {
                                  final provider =
                                  Provider.of<GoogleSignInProvider>(
                                      context,
                                      listen: false);
                                  await provider.logout();
                                  DialogManager.showLoadingDialog(context);
                                  Navigator.pushReplacementNamed(context, SignIn.routeName);
                                  DialogManager.hideDialog(context);
                                },
                                style: ElevatedButton.styleFrom(
                                  minimumSize: const Size(double.infinity, 50),
                                  primary: const Color(0xffA7D1D7),
                                ),
                                child: const Text(
                                  'Sign out',
                                  style: TextStyle(
                                    fontFamily: "Google-Sans",
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height*0.05,
                        ),
                      ],
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
