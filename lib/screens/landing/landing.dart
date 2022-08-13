import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:venu/screens/home/home.dart';
import 'package:venu/screens/room/room.dart';

class Landing extends StatefulWidget {
  const Landing({Key? key}) : super(key: key);
  static const routeName = '/landing';

  @override
  State<Landing> createState() => _LandingState();
}

class _LandingState extends State<Landing> {

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _selectedIndex==0?const Home():_selectedIndex==1?const Room():const Text('Hello'),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xff26242B),
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
