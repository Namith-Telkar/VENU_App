import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rive/rive.dart';
import 'package:venu/screens/room/create_room_dialog.dart';
import 'package:venu/screens/room/enter_room_dialog.dart';
import 'package:venu/services/dialog_manager.dart';

class Room extends StatefulWidget {
  const Room({Key? key}) : super(key: key);
  static const routeName = '/room';

  @override
  State<Room> createState() => _RoomState();
}

class _RoomState extends State<Room> {
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffE5E5E5),
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
              const SizedBox(
                width: 175.0,
                height: 200.0,
                child: RiveAnimation.asset('assets/images/join_room.riv'),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 40.0, vertical: 0.0),
                child: ElevatedButton(
                  onPressed: () {
                    DialogManager.showCustomDialog(
                        context, EnterRoomCode(), true);
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 40.0, vertical: 0.0),
                child: OutlinedButton(
                  onPressed: () {
                    DialogManager.showCustomDialog(
                        context, CreateRoomCode(), true);
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
        ),
      ),
    );
  }
}
