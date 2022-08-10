import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rive/rive.dart';

class Room extends StatefulWidget {
  const Room({Key? key}) : super(key: key);
  static const routename = '/room';

  @override
  State<Room> createState() => _RoomState();
}

class _RoomState extends State<Room> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
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
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 0.0),
                child: ElevatedButton(
                  onPressed: () {
                  },
                  style: ElevatedButton.styleFrom(
                    shape: const StadiumBorder(),
                    minimumSize:
                    const Size(double.infinity, 56),
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
                    horizontal: 20.0, vertical: 0.0),
                child: OutlinedButton(
                  onPressed: () {
                  },
                  style: OutlinedButton.styleFrom(
                    shape: const StadiumBorder(),
                    minimumSize:
                    const Size(double.infinity, 56),
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
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color(0xff26242B),
        elevation: 10.0,
        type: BottomNavigationBarType.shifting,
        items: const [
          BottomNavigationBarItem(
            icon: FaIcon(
              FontAwesomeIcons.house,
            ),
              label: '\u2022'
          ),
          BottomNavigationBarItem(
            icon: FaIcon(
              FontAwesomeIcons.plus,
            ),
            label: '\u2022'
          ),
          BottomNavigationBarItem(
            icon: FaIcon(
              FontAwesomeIcons.solidUser,
            ),
            label: '\u2022'
          )
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedLabelStyle: const TextStyle(fontSize: 18.0,fontWeight: FontWeight.bold,color: Colors.black),
        selectedItemColor: const Color(0xffA7D1D7),
        unselectedItemColor: Colors.black,
      ),
    );
  }
}
