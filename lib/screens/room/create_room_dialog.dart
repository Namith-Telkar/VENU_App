import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:location/location.dart';
import 'package:venu/screens/room/code_field.dart';
import 'package:venu/screens/room/confirmation_room_dialog.dart';
import 'package:venu/services/dialog_manager.dart';

import '../../redux/actions.dart';
import '../../redux/store.dart';
import '../../services/network_helper.dart';

class CreateRoomCode extends StatefulWidget {
  CreateRoomCode({
    Key? key,
  }) : super(key: key) {}

  @override
  State<CreateRoomCode> createState() => _CreateRoomCodeState();
}

class _CreateRoomCodeState extends State<CreateRoomCode> {
  late BuildContext _appStateContext;

  String roomName = '';
  String lat = '';
  String lng = '';

  bool switchValue = true;

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

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AppState>(
      converter: (store) => store.state,
      builder: (context, state) {
        _appStateContext = context;
        return AlertDialog(
          backgroundColor: Theme.of(context).canvasColor,
          title: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Share Room Code',
                  style: TextStyle(
                    fontFamily: "Google-Sans",
                    fontSize: 16.0,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(
                      vertical: 5.0, horizontal: 20.0),
                  child: const Text(
                    'Share the code with your friends. They can join using this code',
                    style: TextStyle(
                      fontFamily: "Google-Sans",
                      fontSize: 12.0,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
          content: Scrollbar(
            thickness: 3,
            scrollbarOrientation: ScrollbarOrientation.right,
            radius: const Radius.circular(20),
            child: SingleChildScrollView(
              child: SizedBox(
                height: switchValue
                    ? MediaQuery.of(context).size.height * 0.30
                    : MediaQuery.of(context).size.height * 0.50,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(
                          vertical: 20.0,
                          horizontal: 15.0,
                        ),
                        child: TextField(
                          onChanged: (val) {
                            setState(() {
                              roomName = val;
                            });
                          },
                          style: const TextStyle(
                            fontFamily: 'Google-Sans',
                            fontSize: 16,
                            color: Colors.black,
                          ),
                          decoration: const InputDecoration(
                            hintText: 'Enter Room name',
                            hintStyle: TextStyle(
                              fontFamily: 'Raleway',
                              fontSize: 16.0,
                              color: Colors.black45,
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.black54,
                              ),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.black54,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 40.0),
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
                              'Use current location',
                              style: TextStyle(
                                fontFamily: "Google-Sans",
                                fontSize: 12.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                      switchValue
                          ? const SizedBox(
                              width: 0.0,
                            )
                          : Container(
                              margin: const EdgeInsets.symmetric(
                                  vertical: 20.0, horizontal: 0.0),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  const Text(
                                    'Enter your location',
                                    style: TextStyle(
                                      fontFamily: "Google-Sans",
                                      fontSize: 12.0,
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.symmetric(
                                          vertical: 0.0,
                                          horizontal: 10.0,
                                        ),
                                        child: SizedBox(
                                          width: 100.0,
                                          child: TextField(
                                            onChanged: (val) {
                                              setState(() {
                                                lat = val;
                                              });
                                            },
                                            style: const TextStyle(
                                              fontFamily: 'Google-Sans',
                                              fontSize: 14,
                                              color: Colors.black,
                                            ),
                                            decoration: const InputDecoration(
                                              hintText: 'Latitude',
                                              hintStyle: TextStyle(
                                                fontFamily: 'Raleway',
                                                fontSize: 14.0,
                                                color: Colors.black45,
                                              ),
                                              focusedBorder:
                                                  UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Colors.black54,
                                                ),
                                              ),
                                              enabledBorder:
                                                  UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Colors.black54,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        margin: const EdgeInsets.symmetric(
                                          vertical: 0.0,
                                          horizontal: 10.0,
                                        ),
                                        child: SizedBox(
                                          width: 100.0,
                                          child: TextField(
                                            onChanged: (val) {
                                              setState(() {
                                                lng = val;
                                              });
                                            },
                                            style: const TextStyle(
                                              fontFamily: 'Google-Sans',
                                              fontSize: 14,
                                              color: Colors.black,
                                            ),
                                            decoration: const InputDecoration(
                                              hintText: 'Longitude',
                                              hintStyle: TextStyle(
                                                fontFamily: 'Raleway',
                                                fontSize: 14.0,
                                                color: Colors.black45,
                                              ),
                                              focusedBorder:
                                                  UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Colors.black54,
                                                ),
                                              ),
                                              enabledBorder:
                                                  UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Colors.black54,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                      Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 15.0, vertical: 10.0),
                        child: ElevatedButton(
                          onPressed: () async {
                            DialogManager.showLoadingDialog(context);
                            userDetails['googleToken'] = await FirebaseAuth
                                .instance.currentUser!
                                .getIdToken();
                            userDetails['roomName'] = roomName;
                            if (switchValue) {
                              await getLocation();
                              userDetails['latitude'] = locationData.latitude;
                              userDetails['longitude'] = locationData.longitude;
                            } else {
                              userDetails['latitude'] =
                                  num.tryParse(lat)?.toDouble();
                              userDetails['longitude'] =
                                  num.tryParse(lng)?.toDouble();
                            }
                            Map<String, dynamic> response = {};
                            response =
                                await NetworkHelper.createRoom(userDetails);
                            debugPrint(response.toString());
                            StoreProvider.of<AppState>(_appStateContext)
                                .dispatch(
                              UpdateRooms(rooms: [], roomsUpdated: true),
                            );
                            DialogManager.hideDialog(context);
                            DialogManager.hideDialog(context);
                            if (response['success']) {
                              DialogManager.showCustomDialog(
                                context,
                                ConfirmationRoom(
                                    name: response['result']['name'],
                                    id: response['result']['id']),
                                true,
                              );
                            } else {
                              //error dialog
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            shape: const StadiumBorder(),
                            minimumSize: const Size(double.infinity, 56),
                            primary: const Color(0xffA7D1D7),
                          ),
                          child: const Text(
                            'Create room',
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
                ),
              ),
            ),
          ),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(14.0)),
          ),
        );
      },
    );
  }
}
