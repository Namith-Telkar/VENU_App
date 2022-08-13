import 'dart:ui';
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
  final String _code = '';

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
        content: SizedBox(
          height: MediaQuery.of(context).size.height * 0.2,
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
                Padding(
                  padding: const EdgeInsets.symmetric(
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
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(14.0)),
        ),
      ),
    );
  }
}
