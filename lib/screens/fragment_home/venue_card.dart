import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:venu/screens/fragment_view_venue/fragment_view_venue.dart';

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
  void viewVenue() {
    // build the venue page
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Scaffold(
          backgroundColor: const Color(0xffE5E5E5),
          resizeToAvoidBottomInset: false,
          body: SafeArea(
            child: FragmentViewVenue(
              venue: widget.venue,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: viewVenue,
      child: Card(
        shadowColor: Colors.black54,
        surfaceTintColor: Colors.black54,
        elevation: 10.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        margin: const EdgeInsets.only(
          left: 25.0,
          right: 25.0,
          top: 15.0,
          bottom: 15.0,
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.only(
                top: 20.0,
                bottom: 20.0,
                left: 15.0,
              ),
              child: CircleAvatar(
                radius: 30.0,
                backgroundImage: NetworkImage(widget.venue['pictures'][0]),
              ),
            ),
            const SizedBox(width: 15.0),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.venue['name'] ?? "Venue Name",
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: const TextStyle(
                      fontFamily: "Google-Sans",
                      fontSize: 16.0,
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Rating:  ${widget.venue['rating'] ?? "0"}',
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: const TextStyle(
                          fontFamily: "Google-Sans",
                          fontSize: 14.0,
                          height: 1.5,
                        ),
                      ),
                      const SizedBox(width: 2.0),
                      const FaIcon(
                        FontAwesomeIcons.star,
                        color: Color(0xffEFD370),
                        size: 12.0,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: 10.0),
            Container(
              padding: const EdgeInsets.only(
                top: 30.0,
                bottom: 30.0,
                right: 20.0,
                left: 20.0,
              ),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(10.0),
                  bottomRight: Radius.circular(10.0),
                ),
                color: Color(0xffA7D1D7),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    '${widget.venue['similarity'] ?? "0"}%',
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: const TextStyle(
                      color: Colors.white,
                      fontFamily: "Google-Sans",
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Text(
                    'Match',
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: "Google-Sans",
                      fontSize: 14.0,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
