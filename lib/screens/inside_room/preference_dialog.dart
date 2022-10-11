import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:venu/screens/venues/venues.dart';
import 'package:venu/services/dialog_manager.dart';

import '../../services/network_helper.dart';

class PreferencesDialog extends StatefulWidget {
  final Map<String,dynamic> venueTypes;
  final String roomId;

  const PreferencesDialog(
      {required this.venueTypes, required this.roomId, Key? key})
      : super(key: key);

  @override
  State<PreferencesDialog> createState() => _PreferencesDialogState();
}

class _PreferencesDialogState extends State<PreferencesDialog> {
  late List<String> venueTypesList = widget.venueTypes.entries.map((e) => e.key).toList();
  late String _preference = venueTypesList[0];

  Future<List> getPredictions() async {
    Map<String, dynamic> result = {};
    String googleToken = await FirebaseAuth.instance.currentUser!.getIdToken();
    result = await NetworkHelper.getPredictions(
        googleToken, widget.roomId, _preference.toLowerCase());
    return result['venues'];
  }

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 4.0, sigmaY: 4.0),
      child: AlertDialog(
        backgroundColor: Theme.of(context).canvasColor,
        title: const Center(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 20.0),
            child: Text(
              'Select your venue preference',
              style: TextStyle(
                fontFamily: "Google-Sans",
                fontSize: 16.0,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const Text(
              'If you have any preference for your type of venue, please select them from the dropdown menu',
              style: TextStyle(
                fontFamily: 'Google-Sans',
                fontSize: 14.0,
              ),
              textAlign: TextAlign.center,
            ),
            Container(
              margin:
                  const EdgeInsets.symmetric(horizontal: 0.0, vertical: 20.0),
              child: DropdownButtonFormField<String>(
                items: venueTypesList.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                value: _preference,
                hint: const Text(
                  'Pick a preference',
                  style: TextStyle(
                    fontFamily: 'Google-Sans',
                    fontSize: 12.0,
                    color: Colors.black45,
                  ),
                ),
                onChanged: (newValue) {
                  setState(() {
                    _preference = widget.venueTypes['value'];
                  });
                },
                style: const TextStyle(
                  fontFamily: 'Google-Sans',
                  fontSize: 14.0,
                  color: Colors.black,
                ),
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Container(
              margin:
                  const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
              child: ElevatedButton(
                onPressed: () async {
                  DialogManager.showLoadingDialog(context);
                  List venues = await getPredictions();
                  DialogManager.hideDialog(context);
                  DialogManager.hideDialog(context);
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => Venues(venues: venues),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                  primary: const Color(0xffA7D1D7),
                ),
                child: const Text(
                  'Find Venues',
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
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(14.0)),
        ),
      ),
    );
  }
}
