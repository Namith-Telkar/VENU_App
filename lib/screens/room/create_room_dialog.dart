import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:venu/screens/room/code_field.dart';
import 'package:venu/services/dialog_manager.dart';

class CreateRoomCode extends StatefulWidget {
  CreateRoomCode({
    Key? key,
  }) : super(key: key) {}

  @override
  State<CreateRoomCode> createState() => _CreateRoomCodeState();
}

class _CreateRoomCodeState extends State<CreateRoomCode> {
  String _code = '';
  String _roomName = '';
  bool switchValue = true;

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 4.0, sigmaY: 4.0),
      child: AlertDialog(
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
                margin:
                    const EdgeInsets.symmetric(vertical: 5.0, horizontal: 20.0),
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
              height: switchValue?MediaQuery.of(context).size.height * 0.50:MediaQuery.of(context).size.height * 0.35,
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: double.infinity,
                      margin: const EdgeInsets.symmetric(
                          horizontal: 15.0, vertical: 10.0),
                      padding: const EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: const Color(0xffA7D1D7), width: 1.5)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            '#123456',
                            style: TextStyle(
                              fontFamily: "Google-Sans",
                              fontSize: 18.0,
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                            ),
                          ),
                          Row(
                            children: const [
                              FaIcon(
                                FontAwesomeIcons.copy,
                                color: Colors.black54,
                              ),
                              Text(
                                ' Copy code',
                                style: TextStyle(
                                  fontFamily: "Google-Sans",
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black54,
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(
                        vertical: 20.0,
                        horizontal: 15.0,
                      ),
                      child: TextFormField(
                        onChanged: (val) {
                          setState(() {
                            _roomName = val;
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
                                  child: TextFormField(
                                    onChanged: (val) {
                                      setState(() {
                                        _roomName = val;
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
                                  child: TextFormField(
                                    onChanged: (val) {
                                      setState(() {
                                        _roomName = val;
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
                          horizontal: 15.0, vertical: 10.0),
                      child: ElevatedButton(
                        onPressed: () {
                          DialogManager.hideDialog(context);
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
      ),
    );
  }
}
