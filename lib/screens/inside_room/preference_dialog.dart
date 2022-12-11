import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:venu/screens/venues/venues.dart';
import 'package:venu/services/dialog_manager.dart';

import '../../models/venuUser.dart';
import '../../redux/actions.dart';
import '../../redux/store.dart';
import '../../services/network_helper.dart';

class PreferencesDialog extends StatefulWidget {
  final Function updateRoomDetails;
  final String roomId;

  const PreferencesDialog({
    required this.roomId,
    required this.updateRoomDetails,
    Key? key,
  }) : super(key: key);

  @override
  State<PreferencesDialog> createState() => _PreferencesDialogState();
}

class _PreferencesDialogState extends State<PreferencesDialog> {
  late BuildContext _appStateContext;
  late AppState _appState;

  List<String> venueTypesList = [];
  String? preference;

  Future<void> getPredictions() async {
    DialogManager.showLoadingDialog(context);

    String googleToken = await FirebaseAuth.instance.currentUser!.getIdToken();
    Map<String, dynamic> result = await NetworkHelper.getPredictions(
      googleToken,
      widget.roomId,
      _appState.appConfigs!.venueTypes[preference],
    );

    if (result['success']) {
      VenuUser user = VenuUser.fromNetworkMap(result['user']);
      StoreProvider.of<AppState>(_appStateContext).dispatch(
        UpdateNewUser(newUser: user),
      );
      widget.updateRoomDetails(result['room'], result['venues']);

      DialogManager.hideDialog(_appStateContext); // hide loading dialog
      DialogManager.hideDialog(_appStateContext); // hide preferences dialog
      Navigator.of(_appStateContext).push(
        MaterialPageRoute(
          builder: (context) => Venues(venues: result['venues']),
        ),
      );
    } else {
      DialogManager.hideDialog(_appStateContext);
      DialogManager.showErrorDialog(
        result['message'] ?? 'Error, Try again later!',
        _appStateContext,
        true,
        () {
          Navigator.pop(_appStateContext);
          DialogManager.hideDialog(_appStateContext);
        },
      );
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        venueTypesList = _appState.appConfigs!.venueTypes.entries
            .map((e) => e.key as String)
            .toList();
        preference = venueTypesList[0];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AppState>(
      converter: (store) => store.state,
      builder: (context, state) {
        _appStateContext = context;
        _appState = state;
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
                  margin: const EdgeInsets.symmetric(
                      horizontal: 0.0, vertical: 20.0),
                  child: DropdownButtonFormField<String>(
                    items: venueTypesList.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    value: preference ?? 'Loading...',
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
                        preference = newValue!;
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
                  margin: const EdgeInsets.symmetric(
                      horizontal: 30.0, vertical: 10.0),
                  child: ElevatedButton(
                    onPressed: getPredictions,
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
      },
    );
  }
}
