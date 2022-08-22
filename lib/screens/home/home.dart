// import 'package:flutter/material.dart';
// import 'package:flutter_redux/flutter_redux.dart';
//
// import '../../redux/actions.dart';
// import '../../redux/store.dart';
//
// class Home extends StatefulWidget {
//   const Home({Key? key}) : super(key: key);
//   static const routeName = '/';
//
//   @override
//   State<Home> createState() => _HomeState();
// }
//
// class _HomeState extends State<Home> {
//   @override
//   Widget build(BuildContext context) {
//     return StoreConnector<AppState, AppState>(
//       converter: (store) => store.state,
//       builder: (context, state) {
//         return SafeArea(
//           child: Scaffold(
//             resizeToAvoidBottomInset: false,
//             body: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 const SizedBox(
//                   width: double.infinity,
//                   height: 0.0,
//                 ),
//                 Text(
//                   'Hello world!',
//                   style: TextStyle(
//                     color: Theme.of(context).textTheme.bodyText1!.color,
//                   ),
//                 ),
//                 Checkbox(
//                   value: state.darkTheme,
//                   onChanged: (bool? value) {
//                     StoreProvider.of<AppState>(context)
//                         .dispatch(ToggleTheme(darkTheme: value!));
//                     // print(value);
//                   },
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
// }

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:rive/rive.dart';
import 'package:venu/screens/home/card.dart';
import 'package:venu/services/dialog_manager.dart';
import 'package:venu/services/network_helper.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);
  static const routeName = '/home';

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late Future<List> roomList;
  int noOfRooms = 0;

  Future<List> setRoomList() async {
    Map<String, dynamic> response = {};
    //DialogManager.showLoadingDialog(context);
    String googleToken = await FirebaseAuth.instance.currentUser!.getIdToken();
    response = await NetworkHelper.getRooms(googleToken);
    if (response['success']) {
      List temp = response['rooms'];
      if (temp.isNotEmpty) {
        setState(() {
          noOfRooms = 1;
        });
      }
      return response['rooms'];
    }
    //DialogManager.hideDialog(context);
    return [];
  }

  @override
  void initState() {
    super.initState();
    roomList = setRoomList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffE5E5E5),
      resizeToAvoidBottomInset: false,
      body: FutureBuilder(
        future: roomList,
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return const Center(
                child: SpinKitThreeBounce(
                  color: Colors.black54,
                  size: 40.0,
                ),
              );
            case ConnectionState.done:
              return SafeArea(
                child: Center(
                  child: noOfRooms == 0
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            const SizedBox(
                              height: 20.0,
                            ),
                            const SizedBox(
                              width: 75.0,
                              height: 25.0,
                              child: RiveAnimation.asset(
                                  'assets/images/venu-logo.riv'),
                            ),
                            Container(
                              margin: const EdgeInsets.symmetric(
                                  vertical: 0.0, horizontal: 40.0),
                              child: const Text(
                                'You are not in any room',
                                style: TextStyle(
                                  fontFamily: "Google-Sans",
                                  fontSize: 16.0,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            const SizedBox(
                              width: 300.0,
                              height: 200.0,
                              child: RiveAnimation.asset(
                                  'assets/images/not_in_any_room.riv'),
                            ),
                            Container(
                              margin: const EdgeInsets.symmetric(
                                  vertical: 0.0, horizontal: 40.0),
                              child: const Text(
                                'Join a room now',
                                style: TextStyle(
                                  fontFamily: "Google-Sans",
                                  fontSize: 16.0,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            const SizedBox(
                              height: 20.0,
                            ),
                          ],
                        )
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            const SizedBox(
                              height: 50.0,
                            ),
                            const SizedBox(
                              width: 75.0,
                              height: 25.0,
                              child: RiveAnimation.asset(
                                  'assets/images/venu-logo.riv'),
                            ),
                            const SizedBox(
                              height: 40.0,
                            ),
                            Container(
                              margin: const EdgeInsets.symmetric(
                                  vertical: 0.0, horizontal: 40.0),
                              child: const Text(
                                'Rooms you have joined',
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
                            Expanded(
                              child: ListView(
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                children: [
                                  RoomCard(
                                      roomName: 'Annav',
                                      roomCode: '#420',
                                      noOfPpl: 10),
                                  RoomCard(
                                      roomName: 'Kulcha',
                                      roomCode: '#420',
                                      noOfPpl: 10),
                                  RoomCard(
                                      roomName: 'Namo',
                                      roomCode: '#420',
                                      noOfPpl: 10),
                                  RoomCard(
                                      roomName: 'Pracherrrr',
                                      roomCode: '#420',
                                      noOfPpl: 10),
                                  RoomCard(
                                      roomName: 'Rando',
                                      roomCode: '#420',
                                      noOfPpl: 10),
                                ],
                              ),
                            ),
                          ],
                        ),
                ),
              );
            default:
              return SizedBox();
          }
        },
      ),
    );
  }
}
