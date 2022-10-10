import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:venu/screens/venues/review_card.dart';

class Venues extends StatefulWidget {
  final List venues;
  static const routeName = '/venues';
  const Venues({Key? key, required this.venues}) : super(key: key);

  @override
  State<Venues> createState() => _VenuesState();
}

class _VenuesState extends State<Venues> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffE5E5E5),
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: IntroductionScreen(
          rawPages: widget.venues
              .map((venue) => SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.05,
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(
                              vertical: 0.0, horizontal: 20.0),
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
                                vertical: 0.0, horizontal: 20.0),
                            child: Text(
                              venue['name'],
                              style: const TextStyle(
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
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.50,
                            height: MediaQuery.of(context).size.width * 0.50,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  image: NetworkImage(venue['pictures'][0]),
                                  fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        ),
                        // Center(
                        //   child: CircleAvatar(
                        //     radius: MediaQuery.of(context).size.width * 0.32,
                        //     child: Image.network(venue['pictures'][0]),
                        //   ),
                        // ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.05,
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 40.0, vertical: 0.0),
                          child: ElevatedButton(
                            onPressed: () async {
                              await launchUrl(Uri.parse(venue['url']),
                                  mode: LaunchMode.externalApplication);
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
                                vertical: 0.0, horizontal: 40.0),
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
                            children: venue['reviews']
                                .map<Widget>((review) => ReviewCard(
                                    reviewerName: review['name'],
                                    reviewedAgo: review['timeText'],
                                    reviewText: review['description'],
                                    reviewerImageUrl: review['authorImg'],
                                    noOfStars: review['rating']))
                                .toList(),
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.12,
                        ),
                      ],
                    ),
                  ))
              .toList(),
          // pages: widget.venues
          //     .map(
          //       (venue) => PageViewModel(
          //         useScrollView: true,
          //         titleWidget: Container(
          //           margin: const EdgeInsets.symmetric(
          //               vertical: 0.0, horizontal: 40.0),
          //           child: const Text(
          //             'Get to know the venue!',
          //             style: TextStyle(
          //               fontFamily: 'Google-Sans',
          //               fontSize: 18.0,
          //               fontWeight: FontWeight.bold,
          //             ),
          //             textAlign: TextAlign.center,
          //           ),
          //         ),
          //         bodyWidget: Column(
          //           children: venue['reviews']
          //               .map<Widget>((review) => ReviewCard(
          //                   reviewerName: review['name'],
          //                   reviewedAgo: review['timeText'],
          //                   reviewText: review['description'],
          //                   reviewerImageUrl: review['authorImg'],
          //                   noOfStars: review['rating']))
          //               .toList(),
          //         ),
          //         image: Container(
          //           margin: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0),
          //           child: Column(
          //             mainAxisAlignment: MainAxisAlignment.spaceAround,
          //             crossAxisAlignment: CrossAxisAlignment.start,
          //             children: [
          //               Padding(
          //                 padding: EdgeInsets.fromLTRB(0.0, 0.0,
          //                     MediaQuery.of(context).size.width * 0.85, 0.0),
          //                 child: GestureDetector(
          //                   onTap: () {
          //                     Navigator.pop(context);
          //                   },
          //                   child: const FaIcon(
          //                     FontAwesomeIcons.angleLeft,
          //                     color: Colors.black,
          //                   ),
          //                 ),
          //               ),
          //               Center(
          //                 child: Container(
          //                   margin: const EdgeInsets.symmetric(
          //                       vertical: 0.0, horizontal: 20.0),
          //                   child: Text(
          //                     venue['name'],
          //                     style: const TextStyle(
          //                       fontFamily: 'Google-Sans',
          //                       fontSize: 18.0,
          //                       fontWeight: FontWeight.bold,
          //                     ),
          //                     textAlign: TextAlign.center,
          //                   ),
          //                 ),
          //               ),
          //               Center(
          //                 child: CircleAvatar(
          //                   radius: MediaQuery.of(context).size.width * 0.32,
          //                   child: Image.network(venue['pictures'][0]),
          //                 ),
          //               ),
          //             ],
          //           ),
          //         ),
          //         footer: Container(
          //           margin: const EdgeInsets.symmetric(
          //               horizontal: 40.0, vertical: 0.0),
          //           child: ElevatedButton(
          //             onPressed: () async {
          //               await launchUrl(Uri.parse(venue['url']),
          //                   mode: LaunchMode.externalApplication);
          //             },
          //             style: ElevatedButton.styleFrom(
          //               minimumSize: const Size(double.infinity, 56),
          //               primary: const Color(0xffA7D1D7),
          //             ),
          //             child: const Text(
          //               'Check on Google Maps',
          //               style: TextStyle(
          //                 fontFamily: "Google-Sans",
          //                 fontSize: 16.0,
          //                 fontWeight: FontWeight.w500,
          //                 color: Colors.black,
          //               ),
          //             ),
          //           ),
          //         ),
          //         decoration: const PageDecoration(
          //           imageFlex: 6,
          //           bodyFlex: 4,
          //         ),
          //       ),
          //     )
          //     .toList(),
          onDone: () {
            // When done button is press
          },
          onSkip: () {
            // You can also override onSkip callback
          },
          showBackButton: true,
          showSkipButton: false,
          back: const Icon(
            Icons.navigate_before,
            color: Color(0xffA7D1D7),
            size: 40.0,
          ),
          skip: const Icon(Icons.skip_next),
          next: const Icon(Icons.navigate_next, color: Color(0xffA7D1D7), size: 40.0,),
          done: const Text(""),
          dotsDecorator: DotsDecorator(
              size: const Size.square(6.0),
              activeSize: const Size(15.0, 10.0),
              activeColor: const Color(0xffA7D1D7),
              color: Colors.black26,
              spacing: const EdgeInsets.symmetric(horizontal: 2.0),
              activeShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0))),
          dotsContainerDecorator: BoxDecoration(
            color: Colors.white.withOpacity(0.90)
          ),
        ),
      ),
    );
  }
}
