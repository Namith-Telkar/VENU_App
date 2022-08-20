import 'dart:ui';

import 'package:flutter/material.dart';

import '../utilities/constants.dart';

class ErrorDialog extends StatelessWidget {
  late final String _title;
  late final Function _okFunction;

  ErrorDialog({
    Key? key,
    required String title,
    required Function okFunction,
  }) : super(key: key) {
    _title = title;
    _okFunction = okFunction;
  }

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 4.0, sigmaY: 4.0),
      child: AlertDialog(
        backgroundColor: Theme.of(context).canvasColor,
        title: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 30.0),
            child: Text(
              _title,
              style: const TextStyle(
                fontFamily: "Google-Sans",
                fontSize: 16.0,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        content: Container(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                margin: const EdgeInsets.fromLTRB(0.0, 30.0, 0.0, 0.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Stack(
                        children: <Widget>[
                          Positioned.fill(
                            child: Container(
                              color: const Color(0xffA7D1D7),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              _okFunction();
                            },
                            child: const Text(
                              'Okay',
                              style: TextStyle(
                                fontFamily: "Google-Sans",
                                fontSize: 14.0,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(14.0)),
        ),
      ),
    );
  }
}
