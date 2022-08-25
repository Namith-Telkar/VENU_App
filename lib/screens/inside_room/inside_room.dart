import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rive/rive.dart';
import 'package:venu/services/network_helper.dart';

class InsideRoom extends StatefulWidget {
  static const routeName = '/inside_room';
  final String roomId;
  const InsideRoom({Key? key, required this.roomId}) : super(key: key);

  @override
  State<InsideRoom> createState() => _InsideRoomState();
}

class _InsideRoomState extends State<InsideRoom> {
  late Future<Map<String, dynamic>> response;
  String groupPer = '';
  List users = [];

  Future<Map<String, dynamic>> getRoomDetails() async {
    Map<String, dynamic> result = {};
    String googleToken = await FirebaseAuth.instance.currentUser!.getIdToken();
    result = await NetworkHelper.getRoomDetails(googleToken, widget.roomId);
    return result;
  }

  @override
  void initState() {
    super.initState();
    response = getRoomDetails();
    response.then((value) {
      String temp = '';
      value['result']['gpEncoding'][0]>0?temp='${temp}i':temp='${temp}e';
      value['result']['gpEncoding'][0]>0?temp='${temp}n':temp='${temp}s';
      value['result']['gpEncoding'][0]>0?temp='${temp}t':temp='${temp}f';
      value['result']['gpEncoding'][0]>0?temp='${temp}p':temp='${temp}j';
      setState(() {
        users = value['result']['users'];
        groupPer = temp;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: response,
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return const Scaffold(
                backgroundColor: Color(0xffE5E5E5),
                resizeToAvoidBottomInset: false,
                body: Center(
                  child: SpinKitThreeBounce(
                    color: Colors.black54,
                    size: 40.0,
                  ),
                ),
              );
            case ConnectionState.done:
              return Scaffold(
                backgroundColor: const Color(0xffE5E5E5),
                resizeToAvoidBottomInset: false,
                endDrawer: SafeArea(
                  child: Drawer(
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 50.0),
                      child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: users.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                              margin: const EdgeInsets.fromLTRB(
                                  0.0, 0.0, 0.0, 20.0),
                              child: Column(
                                children: [
                                  ListTile(
                                    leading: CircleAvatar(
                                      radius: 25,
                                      backgroundImage:
                                          NetworkImage(users[index]['url']),
                                    ),
                                    title: Text(
                                      users[index]['email'].substring(0,
                                          users[index]['email'].indexOf('@')),
                                      style: const TextStyle(
                                        fontFamily: 'Google-Sans',
                                        fontSize: 16.0,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10.0,
                                  ),
                                  const Divider(
                                    thickness: 1,
                                    color: Colors.black54,
                                  ),
                                ],
                              ),
                            );
                          }),
                    ),
                  ),
                ),
                body: Builder(builder: (context) {
                  return SafeArea(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(
                            vertical: 0.0, horizontal: 40.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: const FaIcon(
                                FontAwesomeIcons.angleLeft,
                                color: Colors.black,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Scaffold.of(context).openEndDrawer();
                              },
                              child: const FaIcon(
                                FontAwesomeIcons.userGroup,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.symmetric(
                                vertical: 0.0, horizontal: 40.0),
                            child: const Text(
                              'Your groups personality',
                              style: TextStyle(
                                fontFamily: "Google-Sans",
                                fontSize: 16.0,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          const SizedBox(
                            height: 40.0,
                          ),
                          Image.asset('assets/images/$groupPer.png'),
                          const SizedBox(
                            height: 20.0,
                          ),
                          Text(
                            groupPer.toUpperCase(),
                            style: const TextStyle(
                              fontFamily: "Google-Sans",
                              fontSize: 24.0
                            ),
                          ),
                        ],
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(
                            vertical: 0.0, horizontal: 40.0),
                        child: const Text(
                          'Previous Suggestions',
                          style: TextStyle(
                            fontFamily: "Google-Sans",
                            fontSize: 16.0,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 40.0, vertical: 40.0),
                        child: ElevatedButton(
                          onPressed: () async {},
                          style: ElevatedButton.styleFrom(
                            shape: const StadiumBorder(),
                            minimumSize: const Size(double.infinity, 56),
                            primary: const Color(0xffA7D1D7),
                          ),
                          child: const Text(
                            'Find Venues',
                            style: TextStyle(
                              fontFamily: "Google-Sans",
                              fontSize: 16.0,
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ));
                }),
              );
            default:
              return const SizedBox();
          }
        });
  }
}
