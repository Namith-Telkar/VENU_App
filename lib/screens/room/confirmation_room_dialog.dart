import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../services/dialog_manager.dart';

class ConfirmationRoom extends StatefulWidget {
  late final String roomId;
  late final String roomName;

  ConfirmationRoom({
    Key? key,
    required String id,
    required String name,
  }) : super(key: key) {
    roomId = id;
    roomName = name;
  }

  @override
  State<ConfirmationRoom> createState() => _ConfirmationRoomState();
}

class _ConfirmationRoomState extends State<ConfirmationRoom> {
  @override
  Widget build(BuildContext context) {
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
        height: MediaQuery.of(context).size.height * 0.3,
        child: Center(
          child: Column(
            // mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                width: double.infinity,
                margin: const EdgeInsets.symmetric(
                    horizontal: 15.0, vertical: 10.0),
                padding: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                    border:
                        Border.all(color: const Color(0xffA7D1D7), width: 1.5)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.height * 0.14,
                      child: Text(
                        widget.roomId,
                        style: const TextStyle(
                          fontFamily: "Google-Sans",
                          fontSize: 18.0,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Clipboard.setData(ClipboardData(text: widget.roomId))
                            .then((_) {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                                  content: Text(
                            'Copied to your clipboard !',
                            style: TextStyle(fontFamily: 'Google-Sans'),
                          )));
                        });
                      },
                      child: Row(
                        children: const [
                          FaIcon(
                            FontAwesomeIcons.copy,
                            color: Colors.black54,
                          ),
                          Text(
                            ' Copy',
                            style: TextStyle(
                              fontFamily: "Google-Sans",
                              fontSize: 14.0,
                              fontWeight: FontWeight.w500,
                              color: Colors.black54,
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin:
                    const EdgeInsets.symmetric(vertical: 0.0, horizontal: 10.0),
                child: Text(
                  'Room Name : ${widget.roomName}',
                  style: const TextStyle(
                    fontFamily: "Google-Sans",
                    fontSize: 18.0,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(
                    horizontal: 15.0, vertical: 10.0),
                child: ElevatedButton(
                  onPressed: () async {
                    DialogManager.hideDialog(context);
                  },
                  style: ElevatedButton.styleFrom(
                    shape: const StadiumBorder(),
                    minimumSize: const Size(double.infinity, 56),
                    primary: const Color(0xffA7D1D7),
                  ),
                  child: const Text(
                    'Done !',
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
    );
  }
}
