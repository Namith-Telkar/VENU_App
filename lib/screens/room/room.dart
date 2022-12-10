import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rive/rive.dart';
import 'package:venu/screens/room/create_room_dialog.dart';
import 'package:venu/screens/room/enter_room_dialog.dart';
import 'package:venu/services/dialog_manager.dart';

import '../../redux/actions.dart';
import '../../redux/store.dart';
import '../../services/network_helper.dart';
import '../inside_room/inside_room.dart';
import 'card.dart';

// https://docs.flutter.dev/cookbook/effects/expandable-fab

class Room extends StatefulWidget {
  final Function setFloatingActionButton;
  const Room({
    Key? key,
    required this.setFloatingActionButton,
  }) : super(key: key);
  static const routeName = '/room';

  @override
  State<Room> createState() => _RoomState();
}

class _RoomState extends State<Room> {
  late Future<List> roomList;

  late BuildContext _appStateContext;
  late AppState _appState;

  void openCreateRoomDialog() {
    DialogManager.showCustomDialog(
      context,
      CreateRoomCode(),
      true,
    );
  }

  Future<List> setRoomList() async {
    Map<String, dynamic> response = {};
    String googleToken = await FirebaseAuth.instance.currentUser!.getIdToken();
    response = await NetworkHelper.getRooms(googleToken);
    if (response['success']) {
      List temp = response['rooms'];
      StoreProvider.of<AppState>(_appStateContext).dispatch(
        UpdateRooms(
          rooms: temp,
          roomsUpdated: false,
        ),
      );
      return temp;
    }
    return [];
  }

  Future<void> leaveRoom(String roomId) async {
    DialogManager.showLoadingDialog(context);
    String googleToken = await FirebaseAuth.instance.currentUser!.getIdToken();
    Map<String, dynamic> res = await NetworkHelper.leaveRoom(
      googleToken,
      roomId,
    );

    if (res['success']) {
      setState(() {
        roomList = setRoomList();
      });
      // hide loading dialog
      DialogManager.hideDialog(context);
    } else {
      DialogManager.hideDialog(context);
      DialogManager.showErrorDialog(
        'Could not sign in. Please try again.',
        context,
        true,
        () {
          Navigator.pop(context);
        },
      );
    }
  }

  FloatingActionButton getFloatingActionButton() {
    return FloatingActionButton(
      onPressed: () {
        openCreateRoomDialog();
      },
      backgroundColor: const Color(0xffA7D1D7),
      child: const FaIcon(
        FontAwesomeIcons.plus,
      ),
    );
  }

  Widget getCurrentPage(BuildContext context) {
    if (_appState.rooms!.isEmpty) {
      return Center(
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
            const SizedBox(
              width: 175.0,
              height: 200.0,
              child: RiveAnimation.asset('assets/images/join_room.riv'),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 40.0,
                vertical: 0.0,
              ),
              child: ElevatedButton(
                onPressed: () {
                  DialogManager.showCustomDialog(
                    context,
                    EnterRoomCode(),
                    true,
                  );
                },
                style: ElevatedButton.styleFrom(
                  shape: const StadiumBorder(),
                  minimumSize: const Size(double.infinity, 56),
                  primary: const Color(0xffA7D1D7),
                ),
                child: const Text(
                  'Join a room',
                  style: TextStyle(
                    fontFamily: "Google-Sans",
                    fontSize: 18.0,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 40.0,
                vertical: 0.0,
              ),
              child: OutlinedButton(
                onPressed: () {
                  openCreateRoomDialog();
                },
                style: OutlinedButton.styleFrom(
                  shape: const StadiumBorder(),
                  minimumSize: const Size(double.infinity, 56),
                  primary: Colors.white,
                  side: const BorderSide(
                    color: Color(0xffA7D1D7),
                    width: 3.0,
                  ),
                ),
                child: const Text(
                  'Create a room',
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
      );
    } else {
      return RefreshIndicator(
        edgeOffset: 180.0,
        onRefresh: () async {
          roomList = setRoomList();
        },
        child: FutureBuilder(
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
                    child: _appState.rooms!.isEmpty
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
                                  'assets/images/venu-logo.riv',
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.symmetric(
                                  vertical: 0.0,
                                  horizontal: 40.0,
                                ),
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
                                  'assets/images/not_in_any_room.riv',
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.symmetric(
                                  vertical: 0.0,
                                  horizontal: 40.0,
                                ),
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
                                child: ListView.builder(
                                  scrollDirection: Axis.vertical,
                                  physics: const BouncingScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: _appState.rooms!.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return GestureDetector(
                                      onTap: () async {
                                        debugPrint("testing");
                                        Map res =
                                            await Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        InsideRoom(
                                                      roomId: _appState
                                                          .rooms![index]['id'],
                                                    ),
                                                  ),
                                                ) ??
                                                {};
                                        // debugPrint(res.toString());
                                        if (res['leaveRoom']) {
                                          leaveRoom(
                                            _appState.rooms![index]['id'],
                                          );
                                        }
                                      },
                                      child: RoomCard(
                                        roomName: _appState.rooms![index]
                                            ['name'],
                                        roomCode: _appState.rooms![index]['id'],
                                        noOfPpl: _appState.rooms![index]
                                            ['userCount'],
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                  ),
                );
              default:
                return const SizedBox();
            }
          },
        ),
      );
    }

    return Container();
  }

  @override
  void initState() {
    super.initState();
    roomList = Future<List<dynamic>>.value([]);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.setFloatingActionButton(getFloatingActionButton());
      if (_appState.roomsUpdated == null || _appState.roomsUpdated == true) {
        roomList = setRoomList();
        roomList.then((value) {
          StoreProvider.of<AppState>(_appStateContext).dispatch(
            UpdateRooms(
              rooms: value,
              roomsUpdated: false,
            ),
          );
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: StoreConnector<AppState, AppState>(
        converter: (store) => store.state,
        builder: (context, state) {
          _appStateContext = context;
          _appState = state;
          if (_appState.roomsUpdated == null ||
              _appState.roomsUpdated == true) {
            roomList = setRoomList();
          }
          return getCurrentPage(_appStateContext);
        },
      ),
    );
  }
}
