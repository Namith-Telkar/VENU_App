import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:venu/models/venuUser.dart';
import 'package:venu/redux/actions.dart';
import 'package:venu/redux/store.dart';
import 'package:venu/services/dialog_manager.dart';
import 'package:venu/services/network_helper.dart';

class ProfileSettings extends StatefulWidget {
  static const routeName = '/profile_settings';
  const ProfileSettings({Key? key}) : super(key: key);

  @override
  State<ProfileSettings> createState() => _ProfileSettingsState();
}

class _ProfileSettingsState extends State<ProfileSettings> {
  String twitterId = '';
  String personality = 'INTJ';
  bool switchValue = true;

  @override
  Widget build(BuildContext context) {
    late BuildContext appStateContext;

    return StoreConnector<AppState, AppState>(
        converter: (store) => store.state,
        builder: (context, state) {
          appStateContext = context;
          return Scaffold(
            resizeToAvoidBottomInset: false,
            body: SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 30.0, vertical: 0.0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const FaIcon(
                        FontAwesomeIcons.angleLeft,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const Center(
                    child: Text(
                      'Settings',
                      style: TextStyle(
                        fontFamily: 'Google-Sans',
                        fontSize: 20.0,
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 40.0, vertical: 20.0),
                    child: Text(
                      'Your personality type is ${StoreProvider.of<AppState>(appStateContext).state.user?.personality}',
                      style: const TextStyle(
                        fontFamily: 'Google-Sans',
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(
                        vertical: 10.0,
                        horizontal: MediaQuery.of(context).size.width * 0.15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 10.0,
                          child: CupertinoSwitch(
                            value: switchValue,
                            onChanged: (value) {
                              setState(() {
                                switchValue = value;
                              });
                            },
                            activeColor: const Color(0xffA7D1D7),
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.08,
                        ),
                        const Text(
                          'Use Twitter',
                          style: TextStyle(
                            fontFamily: "Google-Sans",
                            fontSize: 12.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                  switchValue
                      ? Column(
                          children: [
                            Container(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 40.0, vertical: 0.0),
                              child: Text(
                                StoreProvider.of<AppState>(appStateContext)
                                            .state
                                            .user
                                            ?.twitter ==
                                        ' '
                                    ? 'Your Twitter handle is "${StoreProvider.of<AppState>(appStateContext).state.user?.twitter}"'
                                    : 'Add your Twitter handle',
                                style: const TextStyle(
                                  fontFamily: 'Google-Sans',
                                  fontSize: 16.0,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 40.0,
                            ),
                            Container(
                              margin: const EdgeInsets.symmetric(
                                vertical: 0.0,
                                horizontal: 40.0,
                              ),
                              child: TextField(
                                onChanged: (val) {
                                  setState(() {
                                    twitterId = val;
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
                                    fontSize: 16.0,
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
                          ],
                        )
                      : Column(
                          children: [
                            Container(
                              margin: const EdgeInsets.symmetric(
                                  vertical: 0.0, horizontal: 40.0),
                              child: const Text(
                                'Update your personality type',
                                style: TextStyle(
                                  fontFamily: "Google-Sans",
                                  fontSize: 16.0,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            const SizedBox(
                              height: 40.0,
                            ),
                            Center(
                              child: Container(
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 50.0, vertical: 0.0),
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
                                    });
                                  },
                                  style: const TextStyle(
                                    fontFamily: 'Google-Sans',
                                    fontSize: 16.0,
                                    color: Colors.black,
                                  ),
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                  Center(
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.5,
                      margin: const EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 0.0),
                      child: ElevatedButton(
                        onPressed: () async {
                          DialogManager.showLoadingDialog(context);
                          String googleToken = await FirebaseAuth
                              .instance.currentUser!
                              .getIdToken();
                          Map<String, dynamic> response = {};
                          if(switchValue){
                            response = await NetworkHelper.updateTwitterHandle(
                                googleToken, twitterId);
                          }
                          else{
                            response = await NetworkHelper.updatePersonality(googleToken, personality);
                          }
                          if (response['success']) {
                            VenuUser user =
                                VenuUser.fromNetworkMap(response['user']);
                            StoreProvider.of<AppState>(context)
                                .dispatch(UpdateNewUser(newUser: user));
                            DialogManager.hideDialog(context);
                            DialogManager.showErrorDialog(
                                'Twitter ID updated successfully',
                                context,
                                false, () {
                              DialogManager.hideDialog(context);
                              Navigator.pop(context);
                            });
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(double.infinity, 56),
                          primary: const Color(0xffA7D1D7),
                        ),
                        child: Text(
                          switchValue? 'Update Twitter ID' : 'Update Personality',
                          style: const TextStyle(
                            fontFamily: "Google-Sans",
                            fontSize: 16.0,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.05,
                  ),
                ],
              ),
            ),
          );
        });
  }
}
