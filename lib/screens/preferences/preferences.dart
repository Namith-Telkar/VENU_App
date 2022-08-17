import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:rive/rive.dart';

class Preferences extends StatefulWidget {
  const Preferences({Key? key}) : super(key: key);
  static const routeName = '/preferences';

  @override
  State<Preferences> createState() => _PreferencesState();
}

class _PreferencesState extends State<Preferences> {
  bool isChecked = false;

  Map<String, dynamic> userDetails = {};

  Location location = Location();

  late bool serviceEnabled;
  late PermissionStatus permissionGranted;
  late LocationData locationData;

  Future<LocationData> getLocation() async{
    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
    }

    if(!serviceEnabled || permissionGranted != PermissionStatus.granted){
      //show error
    }
    locationData = await location.getLocation();
    return locationData;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const SizedBox(
                height: 20.0,
              ),
              const SizedBox(
                width: 75.0,
                height: 25.0,
                child: RiveAnimation.asset('assets/images/venu-logo.riv'),
              ),
              const Text(
                'Tell us about you',
                style: TextStyle(
                    fontFamily: "Google-Sans",
                    fontSize: 22.0,
                    fontWeight: FontWeight.w500,
                ),
              ),
              Container(
                margin:
                    const EdgeInsets.symmetric(vertical: 0.0, horizontal: 40.0),
                child: const Text(
                  'Enter your Twitter ID to help us get to know your preferences',
                  style: TextStyle(
                    fontFamily: "Google-Sans",
                    fontSize: 16.0,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(
                  vertical: 0.0,
                  horizontal: 40.0,
                ),
                child: TextFormField(
                  onChanged: (val) {
                    setState(() {
                      userDetails['twitter_handle'] = val;
                    });
                  },
                  style: const TextStyle(
                    fontFamily: 'Google-Sans',
                    fontSize: 18,
                    color: Colors.black,
                  ),
                  decoration: const InputDecoration(
                    hintText: 'Twitter ID',
                    hintStyle: TextStyle(
                      fontFamily: 'Raleway',
                      fontSize: 18.0,
                      color: Colors.black45,
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black,
                      ),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Checkbox(
                    checkColor: const Color(0xffA7D1D7),
                    activeColor: Colors.transparent,
                    value: isChecked,
                    onChanged: (bool? value) {
                      setState(() {
                        isChecked = value!;
                      });
                    },
                  ),
                  Center(
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        children: [
                          const TextSpan(
                            text:'I agree to the ',
                            style: TextStyle(
                              fontFamily: "Google-Sans",
                              fontSize: 16.0,
                              color: Colors.black,
                            ),
                          ),
                          TextSpan(
                            text: 'terms and conditions',
                            style: const TextStyle(
                              fontFamily: "Google-Sans",
                              fontSize: 16.0,
                              decoration: TextDecoration.underline,
                              color: Colors.blue,
                            ),
                            recognizer: TapGestureRecognizer()..onTap = () async{}
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 0.0),
                child: ElevatedButton(
                  onPressed: () async {
                    if(isChecked){
                      await getLocation();
                      userDetails['latitude'] = locationData.latitude;
                      userDetails['longitude'] = locationData.longitude;
                      userDetails['googleToken'] = FirebaseAuth.instance.currentUser!.uid.toString();
                      print('user details');
                      print(userDetails);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    shape: const StadiumBorder(),
                    minimumSize: const Size(double.infinity, 56),
                    primary: const Color(0xffA7D1D7),
                  ),
                  child: const Text(
                    'Submit',
                    style: TextStyle(
                      fontFamily: "Google-Sans",
                      fontSize: 18.0,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
