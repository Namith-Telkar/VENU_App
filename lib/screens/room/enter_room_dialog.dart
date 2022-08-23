import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:venu/screens/room/code_field.dart';
import 'package:venu/services/dialog_manager.dart';
import 'package:venu/services/network_helper.dart';


class EnterRoomCode extends StatefulWidget {

  EnterRoomCode({Key? key,}) : super(key: key) {}

  @override
  State<EnterRoomCode> createState() => _EnterRoomCodeState();
}

class _EnterRoomCodeState extends State<EnterRoomCode> {
  String roomId = '';
  String lat = '';
  String lng = '';

  bool switchValue = false;

  Map<String, dynamic> userDetails = {};

  Location location = Location();

  late bool serviceEnabled;
  late PermissionStatus permissionGranted;
  late LocationData locationData;

  Future<LocationData> getLocation() async{
    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
    }

    if(!serviceEnabled || permissionGranted != PermissionStatus.granted){
      //show error
    }
    locationData = await location.getLocation();
    return locationData;
  }

  void onCodeInput(String value) {
    roomId = value;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Theme.of(context).canvasColor,
      title: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Enter Room Code',
              style: TextStyle(
                fontFamily: "Google-Sans",
                fontSize: 16.0,
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 5.0,horizontal: 20.0),
              child: const Text(
                'The six digit code your friend shared. It should look like #123456',
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
            height: switchValue?MediaQuery.of(context).size.height*0.4:MediaQuery.of(context).size.height*0.3,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  //CodeField(onChanged: onCodeInput),
                  Container(
                    margin: const EdgeInsets.symmetric(
                      vertical: 20.0,
                      horizontal: 15.0,
                    ),
                    child: TextField(
                      onChanged: (val) {
                        setState(() {
                          roomId = val;
                        });
                      },
                      style: const TextStyle(
                        fontFamily: 'Google-Sans',
                        fontSize: 16,
                        color: Colors.black,
                      ),
                      decoration: const InputDecoration(
                        hintText: '#Room code',
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
                    margin: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 0.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        const Text(
                          'Current location',
                          style: TextStyle(
                            fontFamily: "Google-Sans",
                            fontSize: 12.0,
                          ),
                        ),
                        SizedBox(
                          width: 10.0,
                          child: CupertinoSwitch(
                            value: switchValue,
                            onChanged: (value) {
                              setState(() {
                                switchValue = value;
                              });
                            },
                            trackColor: const Color(0xffA7D1D7),
                            activeColor: const Color(0xffA7D1D7),
                          ),
                        ),
                        const Text(
                          'Enter location',
                          style: TextStyle(
                            fontFamily: "Google-Sans",
                            fontSize: 12.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                  !switchValue?const SizedBox(width: 0.0,):Container(
                    margin: const EdgeInsets.symmetric(vertical: 20.0,horizontal: 0.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15.0, vertical: 10.0),
                    child: ElevatedButton(
                      onPressed: () async {
                        DialogManager.showLoadingDialog(context);
                        userDetails['googleToken'] = await FirebaseAuth.instance.currentUser!.getIdToken();
                        userDetails['roomId'] = roomId;
                        if(!switchValue){
                          await getLocation();
                          userDetails['latitude'] = locationData.latitude;
                          userDetails['longitude'] = locationData.longitude;
                        }
                        else{
                          userDetails['latitude'] = num.tryParse(lat)?.toDouble();
                          userDetails['longitude'] = num.tryParse(lng)?.toDouble();
                        }
                        Map<String,dynamic> response = {};
                        response = await NetworkHelper.joinRoom(userDetails);
                        DialogManager.hideDialog(context);
                        DialogManager.hideDialog(context);
                      },
                      style: ElevatedButton.styleFrom(
                        shape: const StadiumBorder(),
                        minimumSize:
                        const Size(double.infinity, 56),
                        primary: const Color(0xffA7D1D7),
                      ),
                      child: const Text(
                        'Join room',
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
  }
}
