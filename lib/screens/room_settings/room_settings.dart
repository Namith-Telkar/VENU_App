import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class RoomSettings extends StatefulWidget {
  static const routeName = '/room_settings';
  const RoomSettings({Key? key}) : super(key: key);

  @override
  State<RoomSettings> createState() => _RoomSettingsState();
}

class _RoomSettingsState extends State<RoomSettings> {
  bool switchValue = true;
  String lat = '';
  String lng = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffE5E5E5),
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.symmetric(
                  vertical: 50.0, horizontal: 40.0),
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
                  fontSize: 18.0,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(
                  vertical: 40.0, horizontal: 40.0),
              child: const Text(
                'Your Location',
                style: TextStyle(
                  fontFamily: 'Google-Sans',
                  fontSize: 14.0,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(60.0, 0.0, 0.0, 40.0),
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
                    width: MediaQuery.of(context).size.width*0.08,
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
            switchValue?const SizedBox(width: 0.0,):Container(
              margin: const EdgeInsets.fromLTRB(40.0,0.0,40.0,40.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Text(
                    'Enter your location',
                    style: TextStyle(
                      fontFamily: "Google-Sans",
                      fontSize: 14.0,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(
                          vertical: 20.0,
                          horizontal: 10.0,
                        ),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width*0.35,
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
                          width: MediaQuery.of(context).size.width*0.35,
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
            Container(
              margin: const EdgeInsets.symmetric(
                  horizontal: 70.0, vertical: 00.0),
              child: ElevatedButton(
                onPressed: () async {},
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                  primary: const Color(0xffA7D1D7),
                ),
                child: const Text(
                  'Update Location',
                  style: TextStyle(
                    fontFamily: "Google-Sans",
                    fontSize: 14.0,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
