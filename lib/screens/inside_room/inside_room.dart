import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:venu/screens/room_settings/room_settings.dart';
import 'package:venu/screens/venues/venues.dart';
import 'package:venu/services/dialog_manager.dart';
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
  late Map<String, dynamic> suggestionIds;
  String groupPer = '';
  List users = [];

  Future<Map<String, dynamic>> getRoomDetails() async {
    Map<String, dynamic> result = {};
    String googleToken = await FirebaseAuth.instance.currentUser!.getIdToken();
    result = await NetworkHelper.getRoomDetails(googleToken, widget.roomId);
    return result;
  }

  Future<List> getSuggestions() async {
    Map<String, dynamic> result = {};
    String googleToken = await FirebaseAuth.instance.currentUser!.getIdToken();
    result = await NetworkHelper.getSuggestions(googleToken, suggestionIds);
    return result['venues'];
  }

  Future<List> getPredictions() async {
    Map<String, dynamic> result = {};
    String googleToken = await FirebaseAuth.instance.currentUser!.getIdToken();
    result = await NetworkHelper.getPredictions(googleToken, widget.roomId);
    return result['venues'];
  }
  
  @override
  void initState() {
    super.initState();
    response = getRoomDetails();
    response.then((value) {
      String temp = '';
      value['result']['gpEncoding'][0] > 0
          ? temp = '${temp}i'
          : temp = '${temp}e';
      value['result']['gpEncoding'][0] > 0
          ? temp = '${temp}n'
          : temp = '${temp}s';
      value['result']['gpEncoding'][0] > 0
          ? temp = '${temp}f'
          : temp = '${temp}t';
      value['result']['gpEncoding'][0] > 0
          ? temp = '${temp}p'
          : temp = '${temp}j';
      setState(() {
        users = value['result']['users'];
        groupPer = temp;
        suggestionIds = value['result']['suggestions'];
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
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin:
                              const EdgeInsets.fromLTRB(20.0, 50.0, 20.0, 10.0),
                          child: const Text(
                            'Room Code:',
                            style: TextStyle(
                              fontFamily: 'Google-Sans',
                              fontSize: 16.0,
                            ),
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          margin: const EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 10.0),
                          padding: const EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: const Color(0xffA7D1D7), width: 1.5)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width:
                                    MediaQuery.of(context).size.height * 0.14,
                                child: Text(
                                  widget.roomId,
                                  style: const TextStyle(
                                    fontFamily: "Google-Sans",
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Clipboard.setData(
                                          ClipboardData(text: widget.roomId))
                                      .then((_) {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(const SnackBar(
                                            content: Text(
                                      'Copied to your clipboard !',
                                      style:
                                          TextStyle(fontFamily: 'Google-Sans'),
                                    )));
                                  });
                                },
                                child: Row(
                                  children: const [
                                    FaIcon(
                                      FontAwesomeIcons.copy,
                                      color: Colors.black54,
                                    ),
                                    Text(
                                      ' Copy code',
                                      style: TextStyle(
                                        fontFamily: "Google-Sans",
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black54,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin:
                              const EdgeInsets.fromLTRB(20.0, 40.0, 20.0, 10.0),
                          child: const Text(
                            'Participants:',
                            style: TextStyle(
                              fontFamily: 'Google-Sans',
                              fontSize: 16.0,
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 20.0),
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
                                      FirebaseAuth.instance.currentUser!
                                                  .email ==
                                              users[index]['email']
                                          ? ListTile(
                                              leading: CircleAvatar(
                                                radius: 25,
                                                backgroundImage: NetworkImage(
                                                    users[index]['url']),
                                              ),
                                              title: Text(
                                                users[index]['email'].substring(
                                                    0,
                                                    users[index]['email']
                                                        .indexOf('@')),
                                                style: const TextStyle(
                                                  fontFamily: 'Google-Sans',
                                                  fontSize: 14.0,
                                                ),
                                              ),
                                              trailing: GestureDetector(
                                                onTap: () {
                                                  Navigator.pushNamed(context,
                                                      RoomSettings.routeName);
                                                },
                                                child: const FaIcon(
                                                  FontAwesomeIcons.gear,
                                                  color: Colors.black54,
                                                ),
                                              ),
                                            )
                                          : ListTile(
                                              leading: CircleAvatar(
                                                radius: 25,
                                                backgroundImage: NetworkImage(
                                                    users[index]['url']),
                                              ),
                                              title: Text(
                                                users[index]['email'].substring(
                                                    0,
                                                    users[index]['email']
                                                        .indexOf('@')),
                                                style: const TextStyle(
                                                  fontFamily: 'Google-Sans',
                                                  fontSize: 14.0,
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
                      ],
                    ),
                  ),
                ),
                body: Builder(builder: (context) {
                  return SafeArea(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const SizedBox(
                        height: 10.0,
                      ),
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
                                fontFamily: "Google-Sans", fontSize: 24.0),
                          ),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            margin: const EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 40.0),
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
                                vertical: 10.0, horizontal: 30.0),
                            child: GestureDetector(
                              onTap: () async {
                                DialogManager.showLoadingDialog(context);
                                List venues =
                                    await getSuggestions();
                                DialogManager.hideDialog(context);
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) =>
                                       Venues(venues: venues)));
                              },
                              child: Card(
                                shadowColor: Colors.black54,
                                surfaceTintColor: Colors.black54,
                                elevation: 10.0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(30.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            'Venue Suggestions',
                                            style: TextStyle(
                                              fontFamily: 'Google-Sans',
                                              fontSize: 16.0,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 10.0,
                                          ),
                                          Text(
                                            '${suggestionIds.length} venues to choose from',
                                            style: const TextStyle(
                                              fontFamily: 'Google-Sans',
                                              fontSize: 14.0,
                                              color: Colors.black54,
                                            ),
                                          )
                                        ],
                                      ),
                                      const Center(
                                        child: FaIcon(
                                          FontAwesomeIcons.angleRight,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 40.0, vertical: 0.0),
                        child: ElevatedButton(
                          onPressed: () async {
                            DialogManager.showLoadingDialog(context);
                            List venues =
                            await getPredictions();
                            DialogManager.hideDialog(context);
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) =>
                                    Venues(venues: venues)));
                          },
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
                      const SizedBox(
                        height: 20.0,
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