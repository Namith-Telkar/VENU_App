import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class RoomCard extends StatefulWidget {
  final String roomName;
  final String roomCode;
  final int noOfPpl;

  const RoomCard({Key? key, required this.roomName, required this.roomCode, required this.noOfPpl}) : super(key: key);

  @override
  State<RoomCard> createState() => _RoomCardState();
}

class _RoomCardState extends State<RoomCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 30.0),
      child: Card(
        shadowColor: Colors.black54,
        surfaceTintColor: Colors.black54,
        elevation: 10.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.roomName,
                    style: const TextStyle(
                      fontFamily: "Google-Sans",
                      fontSize: 16.0,
                    ),
                  ),
                  // Text(
                  //   widget.roomCode,
                  //   style: const TextStyle(
                  //       fontFamily: "Google-Sans",
                  //       fontSize: 14.0,
                  //       color: Color(0xff8A8A8E)
                  //   ),
                  // ),
                  const SizedBox(
                    height: 25.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Image.asset('assets/images/room-card-circles.png'),
                      const SizedBox(
                        width: 10.0,
                      ),
                      Text(
                        '${widget.noOfPpl} people',
                        style: const TextStyle(
                          fontFamily: "Google-Sans",
                          fontSize: 14.0,
                          color: Color(0xff26242B),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  FaIcon(
                    FontAwesomeIcons.angleRight,
                    color: Colors.black,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
