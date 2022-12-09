import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:venu/screens/home/home.dart';
import 'package:venu/screens/profile/profile.dart';
import 'package:venu/screens/room/room.dart';

class Landing extends StatefulWidget {
  const Landing({Key? key}) : super(key: key);
  static const routeName = '/landing';

  @override
  State<Landing> createState() => _LandingState();
}

class _LandingState extends State<Landing> {
  int _selectedIndex = 0;
  Widget childWidget = const Home();

  FloatingActionButton? _floatingActionButton;

  void setFloatingActionButton(FloatingActionButton? floatingActionButton) {
    setState(() {
      _floatingActionButton = floatingActionButton;
    });
  }

  void _onItemTapped(int index) {
    if (index != 1) {
      setFloatingActionButton(null);
    }

    setState(() {
      _selectedIndex = index;
    });
    if (_selectedIndex == 0) {
      setState(() {
        childWidget = const Home();
      });
    } else if (_selectedIndex == 1) {
      setState(() {
        childWidget = Room(
          setFloatingActionButton: setFloatingActionButton,
        );
      });
    } else {
      setState(() {
        childWidget = const Profile();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: childWidget,
      bottomNavigationBar: BottomNavigationBar(
        elevation: 10.0,
        type: BottomNavigationBarType.shifting,
        items: const [
          BottomNavigationBarItem(
            icon: FaIcon(
              FontAwesomeIcons.house,
            ),
            label: '\u2022',
          ),
          BottomNavigationBarItem(
            icon: FaIcon(
              FontAwesomeIcons.peopleGroup,
            ),
            label: '\u2022',
          ),
          BottomNavigationBarItem(
            icon: FaIcon(
              FontAwesomeIcons.solidUser,
            ),
            label: '\u2022',
          )
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedLabelStyle: const TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
        selectedItemColor: const Color(0xffA7D1D7),
        unselectedItemColor: Colors.black,
      ),
      floatingActionButton: _floatingActionButton,
    );
  }
}
