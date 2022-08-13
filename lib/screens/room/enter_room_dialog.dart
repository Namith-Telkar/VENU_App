import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:venu/screens/room/code_field.dart';
import 'package:venu/services/dialog_manager.dart';


class EnterRoomCode extends StatefulWidget {

  EnterRoomCode({Key? key,}) : super(key: key) {}

  @override
  State<EnterRoomCode> createState() => _EnterRoomCodeState();
}

class _EnterRoomCodeState extends State<EnterRoomCode> {
  String _code = '';

  void onCodeInput(String value) {
    _code = value;
  }

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
        content: SizedBox(
          height: MediaQuery.of(context).size.height*0.2,
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CodeField(onChanged: onCodeInput),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 15.0, vertical: 10.0),
                  child: ElevatedButton(
                    onPressed: () {
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
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(14.0)),
        ),
      ),
    );
  }
}
