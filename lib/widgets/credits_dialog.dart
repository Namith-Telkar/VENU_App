import 'dart:ui';

import 'package:flutter/material.dart';

class CreditsDialog extends StatefulWidget {
  final String title;
  final String content;
  final String okText;
  final Function okFunction;

  const CreditsDialog({
    Key? key,
    required this.title,
    required this.content,
    required this.okText,
    required this.okFunction,
  }) : super(key: key);

  @override
  State<CreditsDialog> createState() => _CreditsDialogState();
}

class _CreditsDialogState extends State<CreditsDialog> {
  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 4.0, sigmaY: 4.0),
      child: AlertDialog(
        backgroundColor: Theme.of(context).canvasColor,
        title: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 0.0,
              horizontal: 30.0,
            ),
            child: Text(
              widget.title,
              style: const TextStyle(
                fontFamily: "Google-Sans",
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              widget.content,
              style: const TextStyle(
                fontFamily: "Google-Sans",
                fontSize: 16.0,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
        actions: [
          Container(
            margin: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 30.0),
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
                          widget.okFunction();
                        },
                        child: Text(
                          widget.okText,
                          style: const TextStyle(
                            fontFamily: "Google-Sans",
                            fontSize: 16.0,
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
          )
        ],
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(14.0)),
        ),
      ),
    );
  }
}
