import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rive/rive.dart';
import 'package:venu/redux/actions.dart';
import 'package:venu/screens/fragment_home/find_venues_dialog.dart';
import 'package:venu/screens/fragment_home/venue_card.dart';
import 'package:venu/services/ad_helper.dart';

import '../../redux/store.dart';
import '../../services/dialog_manager.dart';
import '../../services/network_helper.dart';
import '../../widgets/credits_dialog.dart';

class FragmentHome extends StatefulWidget {
  final Function setFloatingActionButton;
  const FragmentHome({
    Key? key,
    required this.setFloatingActionButton,
  }) : super(key: key);

  @override
  State<FragmentHome> createState() => _FragmentHomeState();
}

class _FragmentHomeState extends State<FragmentHome> {
  late BuildContext _appStateContext;
  late AppState _appState;

  bool _isLoading = true;

  void creditsNotEnough() {
    DialogManager.showCustomDialog(
      _appStateContext,
      CreditsDialog(
        title: 'Oops! Not enough credits',
        content: 'You have 0 credits left. Watch an ad to get more credits.',
        okText: 'Watch an Ad',
        okFunction: () async {
          String googleToken =
              await FirebaseAuth.instance.currentUser!.getIdToken();
          String userId = FirebaseAuth.instance.currentUser!.uid;

          AdHelper.showRewardedAd(
            adUnitId: AdHelper.getMoreTokensRewardedAd,
            userId: userId,
            token: googleToken,
            onUserEarnedReward: () {
              DialogManager.hideDialog(context); // hide the credits dialog
              DialogManager.showErrorDialog(
                'Congratulation! you are eligible for free credits.',
                context,
                false,
                () async {
                  DialogManager.showLoadingDialog(context);
                  // wait for 3 seconds
                  await Future.delayed(
                    const Duration(seconds: 3),
                    () {},
                  );

                  String googleToken =
                      await FirebaseAuth.instance.currentUser!.getIdToken();
                  Map<String, dynamic> res = await NetworkHelper.getUser(
                    googleToken,
                  );

                  if (res['success']) {
                    StoreProvider.of<AppState>(context).dispatch(
                      UpdateNewUser(
                        newUser: res['user'],
                      ),
                    );
                  }
                  // hide loading dialog
                  DialogManager.hideDialog(context);
                  // hide congratulation dialog
                  DialogManager.hideDialog(context);
                },
              );
            },
          );
        },
      ),
      true,
    );
  }

  void findVenuesNearMe() {
    if (_appState.user!.suggestions.isNotEmpty && _appState.user!.credits < 1) {
      creditsNotEnough();
    } else {
      DialogManager.showCustomDialog(
        context,
        const FindVenuesDialog(),
        true,
      );
    }
  }

  Future<List> getSuggestions(Map<String, dynamic> suggestions) async {
    String googleToken = await FirebaseAuth.instance.currentUser!.getIdToken();
    Map<String, dynamic> result = await NetworkHelper.getSuggestions(
      googleToken,
      suggestions,
    );

    List<dynamic> venues = result['venues'];

    if (venues.isNotEmpty) {
      widget.setFloatingActionButton(getFloatingActionButton());
    } else {
      widget.setFloatingActionButton(null);
    }

    return venues;
  }

  FloatingActionButton getFloatingActionButton() {
    return FloatingActionButton(
      onPressed: findVenuesNearMe,
      backgroundColor: const Color(0xffA7D1D7),
      child: const FaIcon(
        FontAwesomeIcons.arrowsRotate,
        size: 20.0,
      ),
    );
  }

  Widget getBody(BuildContext context) {
    if (_isLoading) {
      return const Expanded(
        child: Center(
          child: SpinKitThreeBounce(
            color: Colors.black54,
            size: 40.0,
          ),
        ),
      );
    }

    if (_appState.user == null || _appState.user!.suggestions.isEmpty) {
      return Expanded(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const SizedBox(
              width: 250.0,
              height: 200.0,
              child: RiveAnimation.asset(
                'assets/images/not_in_any_room.riv',
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 40.0,
                vertical: 0.0,
              ),
              child: ElevatedButton(
                onPressed: findVenuesNearMe,
                style: ElevatedButton.styleFrom(
                  shape: const StadiumBorder(),
                  minimumSize: const Size(double.infinity, 56),
                  backgroundColor: const Color(0xffA7D1D7),
                ),
                child: const Text(
                  'Find venues near me',
                  style: TextStyle(
                    fontFamily: "Google-Sans",
                    fontSize: 18.0,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
          ],
        ),
      );
    } else {
      return Expanded(
        child: ListView.builder(
          scrollDirection: Axis.vertical,
          physics: const BouncingScrollPhysics(),
          shrinkWrap: true,
          itemCount: _appState.userSuggestions!.length,
          padding: const EdgeInsets.only(bottom: 80.0),
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () async {
                debugPrint("testing");

                // await Navigator.of(context).push(
                //   MaterialPageRoute(
                //     builder: (context) =>
                //         InsideRoom(
                //           roomId: _appState
                //               .rooms![index]['id'],
                //         ),
                //   ),
                // )
                // debugPrint(res.toString());
              },
              child: VenueCard(
                venue: _appState.userSuggestions![index],
              ),
            );
          },
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      AdHelper.initializeRewardedAd(adUnitId: AdHelper.getMoreTokensRewardedAd);

      if (_appState.user != null && _appState.user!.suggestions.isNotEmpty) {
        if (_appState.userSuggestions != null &&
            _appState.userSuggestions!.isNotEmpty) {
          setState(() {
            _isLoading = false;
          });
        } else {
          getSuggestions(_appState.user!.suggestions as Map<String, dynamic>)
              .then(
            (value) {
              StoreProvider.of<AppState>(context).dispatch(
                UpdateUserSuggestions(
                  userSuggestions: value,
                ),
              );
              setState(() {
                _isLoading = false;
              });
            },
          );
        }
        widget.setFloatingActionButton(getFloatingActionButton());
      } else {
        widget.setFloatingActionButton(null);
        setState(() {
          _isLoading = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: StoreConnector<AppState, AppState>(
        converter: (store) => store.state,
        builder: (context, state) {
          _appStateContext = context;
          _appState = state;
          return Container(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 50.0,
                ),
                const SizedBox(
                  width: 75.0,
                  height: 25.0,
                  child: RiveAnimation.asset(
                    'assets/images/venu-logo.riv',
                  ),
                ),
                const SizedBox(
                  height: 40.0,
                ),
                Container(
                  margin: const EdgeInsets.symmetric(
                    vertical: 0.0,
                    horizontal: 40.0,
                  ),
                  child: const Text(
                    'Venues around you',
                    style: TextStyle(
                      fontFamily: "Google-Sans",
                      fontSize: 16.0,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(
                  height: 40.0,
                ),
                getBody(context),
              ],
            ),
          );
        },
      ),
    );
  }
}
