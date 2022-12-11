import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import 'review_card.dart';

class FragmentViewVenue extends StatefulWidget {
  final Map venue;
  const FragmentViewVenue({
    Key? key,
    required this.venue,
  }) : super(key: key);

  @override
  State<FragmentViewVenue> createState() => _FragmentViewVenueState();
}

class _FragmentViewVenueState extends State<FragmentViewVenue> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.05,
          ),
          Container(
            margin: const EdgeInsets.symmetric(
              vertical: 0.0,
              horizontal: 20.0,
            ),
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: const FaIcon(
                FontAwesomeIcons.angleLeft,
                color: Colors.black,
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.05,
          ),
          Center(
            child: Container(
              margin: const EdgeInsets.symmetric(
                vertical: 0.0,
                horizontal: 20.0,
              ),
              child: Text(
                widget.venue['name'],
                style: const TextStyle(
                  fontFamily: 'Google-Sans',
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Center(
            child: Container(
              margin: const EdgeInsets.symmetric(
                vertical: 5.0,
                horizontal: 20.0,
              ),
              child: Text(
                '${widget.venue['similarity'].toString()}% Match!',
                style: const TextStyle(
                  fontFamily: 'Google-Sans',
                  fontSize: 14.0,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.03,
          ),
          Center(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.50,
              height: MediaQuery.of(context).size.width * 0.50,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: NetworkImage(widget.venue['pictures'][0]),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          // Center(
          //   child: CircleAvatar(
          //     radius: MediaQuery.of(context).size.width * 0.32,
          //     child: Image.network(widget.venue['pictures'][0]),
          //   ),
          // ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.05,
          ),
          Container(
            margin: const EdgeInsets.symmetric(
              horizontal: 40.0,
              vertical: 0.0,
            ),
            child: ElevatedButton(
              onPressed: () async {
                await launchUrl(
                  Uri.parse(widget.venue['url']),
                  mode: LaunchMode.externalApplication,
                );
              },
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 56),
                primary: const Color(0xffA7D1D7),
              ),
              child: const Text(
                'Check on Google Maps',
                style: TextStyle(
                  fontFamily: "Google-Sans",
                  fontSize: 16.0,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.05,
          ),
          Center(
            child: Container(
              margin: const EdgeInsets.symmetric(
                vertical: 0.0,
                horizontal: 40.0,
              ),
              child: const Text(
                'Get to know the venue!',
                style: TextStyle(
                  fontFamily: 'Google-Sans',
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.03,
          ),
          Center(
            child: Column(
              children: widget.venue['reviews']
                  .map<Widget>(
                    (review) => ReviewCard(
                      reviewerName: review['name'],
                      reviewedAgo: review['timeText'],
                      reviewText: review['description'],
                      reviewerImageUrl: review['authorImg'],
                      noOfStars: review['rating'],
                    ),
                  )
                  .toList(),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.12,
          ),
        ],
      ),
    );
  }
}
