import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:venu/screens/fragment_feedback/fragment_feedback.dart';
import 'package:venu/screens/fragment_home/fragment_home.dart';
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

  FloatingActionButton? _floatingActionButton;

  void setFloatingActionButton(FloatingActionButton? floatingActionButton) {
    setState(() {
      _floatingActionButton = floatingActionButton;
    });
  }

  void _onItemTapped(int index) {
    debugPrint('index: $index');
    if (index != 1 || index != 0) {
      setFloatingActionButton(null);
    }

    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> widgetOptions = <Widget>[
      FragmentHome(
        setFloatingActionButton: setFloatingActionButton,
      ),
      Room(
        setFloatingActionButton: setFloatingActionButton,
      ),
      const Profile(),
      const FragmentFeedback(),
    ];

    return Scaffold(
      backgroundColor: const Color(0xffE5E5E5),
      resizeToAvoidBottomInset: false,
      body: widgetOptions.elementAt(_selectedIndex),
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
          ),
          BottomNavigationBarItem(
            icon: FaIcon(
              FontAwesomeIcons.lightbulb,
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
