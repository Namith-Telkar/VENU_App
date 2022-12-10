import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class VenueCard extends StatefulWidget {
  final Map<String, dynamic> venue;

  const VenueCard({
    Key? key,
    required this.venue,
  }) : super(key: key);

  @override
  State<VenueCard> createState() => _VenueCardState();
}

class _VenueCardState extends State<VenueCard> {
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
                    widget.venue['name'] ?? "Venue Name",
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
                      Text(
                        '${widget.venue['similarity'].toString() ?? 0}% Match!',
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
