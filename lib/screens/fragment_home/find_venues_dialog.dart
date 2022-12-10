import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:location/location.dart';
import 'package:venu/redux/actions.dart';

import '../../models/venuUser.dart';
import '../../redux/store.dart';
import '../../services/dialog_manager.dart';
import '../../services/network_helper.dart';

class FindVenuesDialog extends StatefulWidget {
  const FindVenuesDialog({Key? key}) : super(key: key);

  @override
  State<FindVenuesDialog> createState() => _FindVenuesDialogState();
}

class _FindVenuesDialogState extends State<FindVenuesDialog> {
  late BuildContext _appStateContext;
  late AppState _appState;

  List<String> venueTypesList = [];
  String? preference;

  Location location = Location();
  late bool serviceEnabled;
  late PermissionStatus permissionGranted;
  late LocationData locationData;

  Future<LocationData> getLocation() async {
    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
    }

    if (!serviceEnabled || permissionGranted != PermissionStatus.granted) {
      //show error
    }
    locationData = await location.getLocation();
    return locationData;
  }

  Future<void> getPredictions() async {
    DialogManager.showLoadingDialog(context);
    await getLocation();

    String googleToken = await FirebaseAuth.instance.currentUser!.getIdToken();
    Map<String, dynamic> result = await NetworkHelper.getPredictionsNearMe(
      googleToken,
      locationData.latitude!,
      locationData.longitude!,
      _appState.venueTypes[preference],
    );

    if (result['success']) {
      VenuUser user = VenuUser.fromNetworkMap(result['user']);
      if (!mounted) return;
      StoreProvider.of<AppState>(_appStateContext).dispatch(
        UpdateNewUser(newUser: user),
      );
      StoreProvider.of<AppState>(_appStateContext).dispatch(
        UpdateUserSuggestions(userSuggestions: result['venues']),
      );

      DialogManager.hideDialog(_appStateContext); // hide loading dialog
      DialogManager.hideDialog(_appStateContext); // hide preferences dialog
    } else {
      if (!mounted) return;
      DialogManager.hideDialog(_appStateContext);
      DialogManager.showErrorDialog(
        result['message'] ?? 'Error, Try again later!',
        _appStateContext,
        true,
        () {
          Navigator.of(context).pop();
          DialogManager.hideDialog(context);
        },
      );
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        venueTypesList =
            _appState.venueTypes.entries.map((e) => e.key as String).toList();
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
