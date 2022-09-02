import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:rive/rive.dart';
import 'package:venu/provider/google_sign_in.dart';
import 'package:venu/redux/store.dart';
import 'package:venu/screens/landing/landing.dart';
import 'package:venu/screens/preferences/preferences.dart';
import 'package:location/location.dart';
import 'package:venu/services/dialog_manager.dart';
import 'package:venu/services/network_helper.dart';

import '../../models/venuUser.dart';
import '../../redux/actions.dart';

class SignIn extends StatelessWidget {
  const SignIn({Key? key}) : super(key: key);
  static const routeName = '/sign_in';

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double containerHeight = MediaQuery.of(context).size.height * 0.55;
    final double imageHeight = MediaQuery.of(context).size.height * 0.50;
    late BuildContext appStateContext;


    Future<Map<String,dynamic>> checkUserExists() async{
      String token = await FirebaseAuth.instance.currentUser!.getIdToken();
      return NetworkHelper.getUser(token);
    }

    return StoreConnector<AppState,AppState>(
        converter: (store) => store.state,
        builder: (context, state) {
          appStateContext = context;
          return Scaffold(
            backgroundColor: const Color(0xffE5E5E5),
            resizeToAvoidBottomInset: false,
            body:SafeArea(
                    child: Container(
                      color: const Color(0xffE5E5E5),
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          Positioned(
                            top: -30,
                            width: screenWidth,
                            child: Hero(
                              tag: " ",
                              child: SizedBox(
                                width: screenWidth,
                                height: imageHeight,
                                child: const RiveAnimation.asset(
                                  'assets/images/login-page.riv',
                                ),
                              ),
                            ),
                          ),
                          AnimatedPositioned(
                            bottom: 0,
                            curve: Curves.easeOutCubic,
                            duration: const Duration(milliseconds: 400),
                            child: Container(
                              width: screenWidth,
                              height: containerHeight,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(45.0),
                                  bottomRight: Radius.zero,
                                  topLeft: Radius.circular(45.0),
                                  bottomLeft: Radius.zero,
                                ),
                              ),
                              padding: const EdgeInsets.symmetric(
                                vertical: 10.0,
                                horizontal: 10.0,
                              ),
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    Column(
                                      children: const [
                                        SizedBox(
                                          width: 140.0,
                                          height: 50.0,
                                          child: RiveAnimation.asset('assets/images/venu-logo.riv'),
                                        ),
                                        Text(
                                          'VenU',
                                          style: TextStyle(
                                              fontFamily: "Google-Sans",
                                              fontSize: 22.0,
                                              fontWeight: FontWeight.w500,
                                              letterSpacing: 6.0),
                                        ),
                                      ],
                                    ),
                                    Container(
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 0.0, horizontal: 40.0),
                                      child: const Text(
                                        'Take your first step to finding the perfect meeting venue',
                                        style: TextStyle(
                                          fontFamily: "Google-Sans",
                                          fontSize: 16.0,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 20.0, vertical: 0.0),
                                      child: ElevatedButton.icon(
                                        onPressed: () async {
                                          final provider =
                                              Provider.of<GoogleSignInProvider>(
                                                  context,
                                                  listen: false);
                                          DialogManager.showLoadingDialog(context);
                                          await provider.googleLogin();
                                          if(FirebaseAuth.instance.currentUser!=null){
                                            Map<String,dynamic> temp = await checkUserExists();
                                            if(temp['success']){
                                              // print('token tokken token');
                                              // String token = await FirebaseAuth.instance.currentUser!.getIdToken();
                                              // while (token.length > 0) {
                                              //   int initLength = (token.length >= 500 ? 500 : token.length);
                                              //   print(token.substring(0, initLength));
                                              //   int endLength = token.length;
                                              //   token = token.substring(initLength, endLength);
                                              // }
                                              VenuUser user = VenuUser.fromNetworkMap(temp['user']);
                                              StoreProvider.of<AppState>(context).dispatch(
                                                  UpdateNewUser(newUser: user)
                                              );
                                              DialogManager.hideDialog(context);
                                              Navigator.pushReplacementNamed(context, Landing.routeName);
                                            }
                                            else{
                                              await provider.logout();
                                              DialogManager.hideDialog(context);
                                              DialogManager.showErrorDialog('User does not exist please sign up', context, true, (){Navigator.pop(context);});
                                            }
                                          }
                                        },
                                        style: ElevatedButton.styleFrom(
                                          shape: const StadiumBorder(),
                                          minimumSize:
                                              const Size(double.infinity, 56),
                                          primary: const Color(0xffA7D1D7),
                                        ),
                                        icon: const FaIcon(
                                          FontAwesomeIcons.google,
                                          color: Colors.black,
                                        ),
                                        label: const Text(
                                          'Sign in with Google',
                                          style: TextStyle(
                                            fontFamily: "Google-Sans",
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20.0, vertical: 0.0),
                                      child: OutlinedButton.icon(
                                        onPressed: () async {
                                          final provider =
                                              Provider.of<GoogleSignInProvider>(
                                                  context,
                                                  listen: false);
                                          DialogManager.showLoadingDialog(context);
                                          await provider.googleLogin();
                                          if(FirebaseAuth.instance.currentUser!=null){
                                            Map<String,dynamic> temp = await checkUserExists();
                                            if(temp['success']){
                                              await provider.logout();
                                              DialogManager.hideDialog(context);
                                              DialogManager.showErrorDialog('User already exists please sign in', context, true, (){Navigator.pop(context);});
                                            }
                                            else{
                                              DialogManager.hideDialog(context);
                                              Navigator.pushReplacementNamed(context, Preferences.routeName);
                                            }
                                          }
                                          //await provider.logout();
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
                                        icon: const FaIcon(
                                          FontAwesomeIcons.google,
                                          color: Colors.black,
                                        ),
                                        label: const Text(
                                          'Sign Up with Google',
                                          style: TextStyle(
                                            fontFamily: "Google-Sans",
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10.0,
                                    )
                                  ],
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
      );
  }
}
