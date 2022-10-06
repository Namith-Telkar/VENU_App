import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ReviewCard extends StatefulWidget {
  final String reviewerName;
  final String reviewedAgo;
  final String reviewText;
  final String reviewerImageUrl;
  final int noOfStars;

  const ReviewCard(
      {Key? key,
      required this.reviewerName,
      required this.reviewedAgo,
      required this.reviewText,
      required this.reviewerImageUrl,
      required this.noOfStars})
      : super(key: key);

  @override
  State<ReviewCard> createState() => _ReviewCardState();
}

class _ReviewCardState extends State<ReviewCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 0.0),
      child: Card(
        shadowColor: Colors.black54,
        surfaceTintColor: Colors.black54,
        elevation: 10.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          backgroundImage:
                              NetworkImage(widget.reviewerImageUrl),
                          radius: MediaQuery.of(context).size.width * 0.05,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.02,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.reviewerName,
                              style: const TextStyle(
                                fontFamily: 'Google-Sans',
                                fontSize: 14.0,
                              ),
                            ),
                            Text(
                              'Reviewed ${widget.reviewedAgo}',
                              style: const TextStyle(
                                fontFamily: 'Google-Sans',
                                fontSize: 12.0,
                                color: Colors.black54,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        for (var i = 1; i <= widget.noOfStars; i++)
                          const FaIcon(
                            FontAwesomeIcons.solidStar,
                            color: Color(0xffEFD370),
                            size: 15.0,
                          ),
                        for (var i = widget.noOfStars; i < 5; i++)
                          const FaIcon(
                            FontAwesomeIcons.star,
                            color: Color(0xffEFD370),
                            size: 15.0,
                          ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.015,
                ),
                Text(
                  widget.reviewText,
                  style: const TextStyle(
                    fontFamily: 'Google-Sans',
                    fontSize: 12.0,
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
