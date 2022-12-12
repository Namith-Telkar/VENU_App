import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ThankYouDialog extends StatefulWidget {
  final String message;
  final Uri formLink;
  const ThankYouDialog({
    Key? key,
    required this.message,
    required this.formLink,
  }) : super(key: key);

  @override
  State<ThankYouDialog> createState() => _ThankYouDialogState();
}

class _ThankYouDialogState extends State<ThankYouDialog> {
  Future<void> onOkPressed() async {
    // open link in browser
    if (!await launchUrl(
      widget.formLink,
      mode: LaunchMode.externalApplication,
    )) {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Theme.of(context).canvasColor,
      title: const Text(
        'Thank You :)',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontFamily: "Google-Sans",
          fontSize: 26.0,
        ),
      ),
      content: SizedBox(
        height: MediaQuery.of(context).size.height * 0.3,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              margin: const EdgeInsets.symmetric(
                vertical: 10.0,
                horizontal: 20.0,
              ),
              child: Text(
                widget.message,
                style: const TextStyle(
                  fontFamily: "Google-Sans",
                  fontSize: 18.0,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            // Container(
            //   margin: const EdgeInsets.symmetric(
            //     vertical: 0.0,
            //     horizontal: 10.0,
            //   ),
            //   child: Text(
            //     widget.formLink,
            //     style: const TextStyle(
            //       fontFamily: "Google-Sans",
            //       fontSize: 18.0,
            //     ),
            //     overflow: TextOverflow.ellipsis,
            //   ),
            // ),
            Container(
              margin: const EdgeInsets.symmetric(
                horizontal: 15.0,
                vertical: 10.0,
              ),
              child: ElevatedButton(
                onPressed: onOkPressed,
                style: ElevatedButton.styleFrom(
                  shape: const StadiumBorder(),
                  backgroundColor: const Color(0xffA7D1D7),
                  minimumSize: const Size(double.infinity, 56),
                ),
                child: const Text(
                  'Fill the Feedback Form!',
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
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(14.0)),
      ),
    );
  }
}
