import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:location/location.dart';
import 'package:rive/rive.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:venu/models/venuUser.dart';
import 'package:venu/redux/actions.dart';
import 'package:venu/redux/store.dart';
import 'package:venu/screens/landing/landing.dart';
import 'package:venu/screens/self_analysis/self_analysis.dart';
import 'package:venu/services/dialog_manager.dart';
import 'package:venu/services/network_helper.dart';

class ManualPreferences extends StatefulWidget {
  static const routeName = '/manual_preferences';
  const ManualPreferences({Key? key}) : super(key: key);

  @override
  State<ManualPreferences> createState() => _ManualPreferencesState();
}

class _ManualPreferencesState extends State<ManualPreferences> {
  late BuildContext appStateContext;
  String personality = 'INTJ';

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

  Future<void> openOfficialTest() async {
    await launchUrl(
      Uri.parse('https://www.16personalities.com/free-personality-test'),
    );
  }

  Future<void> openSelfAnalysis() async {
    String? selected =
        await Navigator.pushNamed(context, SelfAnalysis.routeName) as String?;
    if (selected != null) {
      setState(() {
        personality = selected;
      });
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 40.0,
                      vertical: 20.0,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: const [
                        FaIcon(FontAwesomeIcons.angleLeft),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  width: 75.0,
                  height: 25.0,
                  child: RiveAnimation.asset('assets/images/venu-logo.riv'),
                ),
                const Text(
                  'Find your personality',
                  style: TextStyle(
                    fontFamily: "Google-Sans",
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          openOfficialTest();
                        },
                        child: Container(
                          margin: const EdgeInsets.only(
                            left: 20.0,
                          ),
                          padding: const EdgeInsets.symmetric(
                            vertical: 15.0,
                            horizontal: 10.0,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10.0),
                            border: Border.all(
                              color: const Color(0xffA7D1D7),
                              width: 3.0,
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Text(
                                'Official Test',
                                style: TextStyle(
                                  fontFamily: "Google-Sans",
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                height: 15.0,
                              ),
                              Text(
                                'takes about 5-10 min to complete.',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: "Google-Sans",
                                  fontSize: 16.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10.0,
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          openSelfAnalysis();
                        },
                        child: Container(
                          margin: const EdgeInsets.only(
                            right: 20.0,
                          ),
                          padding: const EdgeInsets.symmetric(
                            vertical: 15.0,
                            horizontal: 10.0,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10.0),
                            border: Border.all(
                              color: const Color(0xffA7D1D7),
                              width: 3.0,
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Text(
                                'Self analyse',
                                style: TextStyle(
                                  fontFamily: "Google-Sans",
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                height: 15.0,
                              ),
                              Text(
                                'takes about 2-3 min to complete.',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: "Google-Sans",
                                  fontSize: 16.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(),
                // Container(
                //   margin: const EdgeInsets.symmetric(
                //     vertical: 0.0,
                //     horizontal: 40.0,
                //   ),
                //   child: const Text(
                //     'Finish the questionnaire below. It will take about 5-10 min to complete',
                //     style: TextStyle(
                //       fontFamily: "Google-Sans",
                //       fontSize: 16.0,
                //     ),
                //     textAlign: TextAlign.center,
                //   ),
                // ),
                // GestureDetector(
                //   onTap: openOfficialTest,
                //   child: const Center(
                //     child: Text(
                //       '16 Personalities Test',
                //       style: TextStyle(
                //         fontFamily: 'Google-Sans',
                //         fontSize: 14.0,
                //         color: Color(0xff4295A5),
                //         decoration: TextDecoration.underline,
                //       ),
                //     ),
                //   ),
                // ),
                // Row(
                //   children: const [
                //     Expanded(
                //       child: Divider(
                //         thickness: 3.0,
                //         color: Color(0xff8A8A8E),
                //         endIndent: 10.0,
                //         indent: 10.0,
                //       ),
                //     ),
                //     Text(
                //       'or',
                //       style: TextStyle(
                //         fontFamily: 'Google-Sans',
                //         fontSize: 18.0,
                //         color: Color(0xff8A8A8E),
                //       ),
                //     ),
                //     Expanded(
                //       child: Divider(
                //         thickness: 3.0,
                //         color: Color(0xff8A8A8E),
                //         endIndent: 10.0,
                //         indent: 10.0,
                //       ),
                //     ),
                //   ],
                // ),
                // Center(
                //   child: Container(
                //     margin: const EdgeInsets.symmetric(
                //       vertical: 0.0,
                //       horizontal: 40.0,
                //     ),
                //     child: const Text(
                //       'Self analyse your personality. It will take about 2-3 min to complete',
                //       style: TextStyle(
                //         fontFamily: "Google-Sans",
                //         fontSize: 16.0,
                //       ),
                //       textAlign: TextAlign.center,
                //     ),
                //   ),
                // ),
                // Container(
                //   margin: const EdgeInsets.symmetric(
                //     horizontal: 70.0,
                //     vertical: 0.0,
                //   ),
                //   child: OutlinedButton(
                //     onPressed: openSelfAnalysis,
                //     style: OutlinedButton.styleFrom(
                //       foregroundColor: Colors.white,
                //       shape: const StadiumBorder(),
                //       minimumSize: const Size(double.infinity, 56),
                //       side: const BorderSide(
                //         color: Color(0xffA7D1D7),
                //         width: 3.0,
                //       ),
                //     ),
                //     child: const Text(
                //       'Find your personality',
                //       style: TextStyle(
                //         fontFamily: "Google-Sans",
                //         fontSize: 16.0,
                //         fontWeight: FontWeight.w500,
                //         color: Colors.black,
                //       ),
                //     ),
                //   ),
                // ),
                const Divider(
                  thickness: 3.0,
                  color: Color(0xff8A8A8E),
                  endIndent: 0.0,
                  indent: 0.0,
                ),
                Center(
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                      vertical: 0.0,
                      horizontal: 40.0,
                    ),
                    child: const Text(
                      'Select your personality from the dropdown',
                      style: TextStyle(
                        fontFamily: "Google-Sans",
                        fontSize: 16.0,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                Center(
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 70.0,
                      vertical: 20.0,
                    ),
                    child: DropdownButtonFormField<String>(
                      items: <String>[
                        'ENFJ',
                        'ENFP',
                        'ENTJ',
                        'ENTP',
                        'ESFJ',
                        'ESFP',
                        'ESTJ',
                        'ESTP',
                        'INFJ',
                        'INFP',
                        'INTJ',
                        'INTP',
                        'ISFJ',
                        'ISFP',
                        'ISTJ',
                        'ISTP',
                      ].map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      value: personality,
                      hint: const Text(
                        'Pick a personality',
                        style: TextStyle(
                          fontFamily: 'Google-Sans',
                          fontSize: 12.0,
                          color: Colors.black45,
                        ),
                      ),
                      onChanged: (newValue) {
                        setState(() {
                          personality = newValue!;
                          userDetails['twitterHandle'] = personality;
                        });
                      },
                      style: const TextStyle(
                        fontFamily: 'Google-Sans',
                        fontSize: 16.0,
                        color: Colors.black,
                      ),
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Color(0xffA7D1D7), width: 3.0),
                        ),
                      ),
                    ),
                  ),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 70.0, vertical: 0.0),
                    child: ElevatedButton(
                      onPressed: () async {
                        DialogManager.showLoadingDialog(context);
                        await getLocation();
                        userDetails['latitude'] = locationData.latitude;
                        userDetails['longitude'] = locationData.longitude;
                        userDetails['googleToken'] = await FirebaseAuth
                            .instance.currentUser!
                            .getIdToken();
                        Map<String, dynamic> response =
                            await NetworkHelper.addUserP(userDetails);
                        if (response['success']) {
                          VenuUser user =
                              VenuUser.fromNetworkMap(response['userDetails']);
                          StoreProvider.of<AppState>(context)
                              .dispatch(UpdateNewUser(newUser: user));
                          DialogManager.hideDialog(context);
                          Navigator.pushReplacementNamed(
                              context, Landing.routeName);
                        } else {
                          DialogManager.hideDialog(context);
                          DialogManager.showErrorDialog(
                              'Error setting twitter handle', context, true,
                              () {
                            DialogManager.hideDialog(context);
                          });
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        shape: const StadiumBorder(),
                        minimumSize: const Size(double.infinity, 56),
                        primary: const Color(0xffA7D1D7),
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
                ),
                const SizedBox(
                  height: 40.0,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
