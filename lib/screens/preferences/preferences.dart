import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:location/location.dart';
import 'package:rive/rive.dart';
import 'package:venu/models/venuUser.dart';
import 'package:venu/redux/actions.dart';
import 'package:venu/redux/store.dart';
import 'package:venu/screens/landing/landing.dart';
import 'package:venu/screens/preferences/manual_preferences.dart';
import 'package:venu/services/dialog_manager.dart';
import 'package:venu/services/network_helper.dart';

class Preferences extends StatefulWidget {
  const Preferences({Key? key}) : super(key: key);
  static const routeName = '/preferences';

  @override
  State<Preferences> createState() => _PreferencesState();
}

class _PreferencesState extends State<Preferences> {
  late BuildContext appStateContext;

  bool isChecked = false;

  Map<String, dynamic> userDetails = {};

  Location location = Location();

  late bool serviceEnabled;
  late PermissionStatus permissionGranted;
  late LocationData locationData;

  Future<LocationData> getLocation() async {
    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
    }

    if (!serviceEnabled || permissionGranted != PermissionStatus.granted) {
      //show error
    }
    locationData = await location.getLocation();
    return locationData;
  }

  Future<void> submitTwitter() async {
    if (isChecked) {
      DialogManager.showLoadingDialog(context);
      await getLocation();
      userDetails['latitude'] = locationData.latitude;
      userDetails['longitude'] = locationData.longitude;
      userDetails['googleToken'] =
          await FirebaseAuth.instance.currentUser!.getIdToken();
      Map<String, dynamic> response = await NetworkHelper.addUser(userDetails);
      if (response['success']) {
        VenuUser user = VenuUser.fromNetworkMap(response['userDetails']);
        StoreProvider.of<AppState>(context).dispatch(
          UpdateNewUser(
            newUser: user,
          ),
        );
        DialogManager.hideDialog(context);
        Navigator.pushNamedAndRemoveUntil(
          context,
          Landing.routeName,
          (Route<dynamic> route) => false,
        );
      } else {
        DialogManager.hideDialog(context);
        DialogManager.showErrorDialog(
          'Error setting twitter handle',
          context,
          true,
          () {
            DialogManager.hideDialog(context);
          },
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AppState>(
      converter: (store) => store.state,
      builder: (context, state) {
        appStateContext = context;
        return Scaffold(
          resizeToAvoidBottomInset: false,
          body: SafeArea(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const SizedBox(
                    height: 20.0,
                  ),
                  const SizedBox(
                    width: 75.0,
                    height: 25.0,
                    child: RiveAnimation.asset('assets/images/venu-logo.riv'),
                  ),
                  const Text(
                    'Tell us about you',
                    style: TextStyle(
                      fontFamily: "Google-Sans",
                      fontSize: 20.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(
                      vertical: 0.0,
                      horizontal: 40.0,
                    ),
                    child: const Text(
                      'Enter your Twitter ID to help us get to know your preferences',
                      style: TextStyle(
                        fontFamily: "Google-Sans",
                        fontSize: 16.0,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(
                      vertical: 0.0,
                      horizontal: 40.0,
                    ),
                    child: TextField(
                      onChanged: (val) {
                        setState(() {
                          userDetails['twitterHandle'] = val;
                        });
                      },
                      style: const TextStyle(
                        fontFamily: 'Google-Sans',
                        fontSize: 18,
                        color: Colors.black,
                      ),
                      decoration: const InputDecoration(
                        hintText: 'Twitter ID',
                        hintStyle: TextStyle(
                          fontFamily: 'Raleway',
                          fontSize: 18.0,
                          color: Colors.black45,
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black,
                          ),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Checkbox(
                        checkColor: const Color(0xffA7D1D7),
                        activeColor: Colors.transparent,
                        value: isChecked,
                        onChanged: (bool? value) {
                          setState(() {
                            isChecked = value!;
                          });
                        },
                      ),
                      Center(
                        child: RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            children: [
                              const TextSpan(
                                text: 'I agree to the ',
                                style: TextStyle(
                                  fontFamily: "Google-Sans",
                                  fontSize: 16.0,
                                  color: Colors.black,
                                ),
                              ),
                              TextSpan(
                                  text: 'terms and conditions',
                                  style: const TextStyle(
                                    fontFamily: "Google-Sans",
                                    fontSize: 16.0,
                                    decoration: TextDecoration.underline,
                                    color: Colors.blue,
                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () async {}),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40.0, vertical: 0.0),
                    child: ElevatedButton(
                      onPressed: submitTwitter,
                      style: ElevatedButton.styleFrom(
                        shape: const StadiumBorder(),
                        backgroundColor: const Color(0xffA7D1D7),
                        minimumSize: const Size(double.infinity, 56),
                      ),
                      child: const Text(
                        'Submit',
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
                    height: 20.0,
                  ),
                  Row(
                    children: const [
                      Expanded(
                        child: Divider(
                          thickness: 3.0,
                          color: Color(0xff8A8A8E),
                          endIndent: 10.0,
                          indent: 10.0,
                        ),
                      ),
                      Text(
                        'or',
                        style: TextStyle(
                          fontFamily: 'Google-Sans',
                          fontSize: 18.0,
                          color: Color(0xff8A8A8E),
                        ),
                      ),
                      Expanded(
                          child: Divider(
                        thickness: 3.0,
                        color: Color(0xff8A8A8E),
                        endIndent: 10.0,
                        indent: 10.0,
                      )),
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(
                        vertical: 0.0, horizontal: 40.0),
                    child: const Text(
                      'Don\'t have a Twitter account? It\'s fine \n Select your personality manually',
                      style: TextStyle(
                        fontFamily: "Google-Sans",
                        fontSize: 16.0,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 40.0, vertical: 0.0),
                    child: OutlinedButton(
                      onPressed: () async {
                        Navigator.pushNamed(
                          context,
                          ManualPreferences.routeName,
                        );
                      },
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.white,
                        shape: const StadiumBorder(),
                        minimumSize: const Size(double.infinity, 56),
                        side: const BorderSide(
                          color: Color(0xffA7D1D7),
                          width: 3.0,
                        ),
                      ),
                      child: const Text(
                        'Select Personality',
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
                    height: 20.0,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
