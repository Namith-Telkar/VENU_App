import 'package:flutter/material.dart';

class TraitsCard extends StatefulWidget {
  final List traits;
  final String title;
  final bool selected;
  const TraitsCard(
      {Key? key,
      required this.traits,
      required this.title,
      required this.selected})
      : super(key: key);

  @override
  State<TraitsCard> createState() => _TraitsCardState();
}

class _TraitsCardState extends State<TraitsCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      shadowColor: widget.selected ? const Color(0xffA7D1D7) : Colors.black54,
      surfaceTintColor:
          widget.selected ? const Color(0xffA7D1D7) : Colors.black54,
      elevation: 10.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
        side: widget.selected
            ? const BorderSide(
                color: Color(0xffA7D1D7),
                width: 8.0,
              )
            : const BorderSide(
                color: Colors.black54,
                width: 0.5,
              ),
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Center(
              child: Text(
                widget.title,
                style: const TextStyle(
                  fontFamily: 'Google-Sans',
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            ...widget.traits
                .map(
                  (trait) => Row(
                    children: [
                      const Text(
                        '\u2022',
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'Google-Sans',
                        ),
                      ), //bullet text
                      const SizedBox(
                        width: 10,
                      ), //space between bullet and text
                      Expanded(
                        child: Text(
                          trait,
                          style: const TextStyle(
                            fontSize: 14.0,
                            fontFamily: 'Google-Sans',
                          ),
                        ), //text
                      ),
                    ],
                  ),
                )
                .toList(), //on
          ],
        ),
      ),
    );
  }
}
