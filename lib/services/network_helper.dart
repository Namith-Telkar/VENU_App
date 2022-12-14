import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:venu/models/AppConfigs.dart';

class NetworkHelper {
  NetworkHelper();

  //static String endpoint = 'https://venu-backend-api.herokuapp.com';
  static String endpoint = 'https://venu.arnavdewan.dev';

  static Future<bool> checkUserExists(String googleToken) async {
    var url = Uri.parse('$endpoint/api/user/getDetails');
    var response = await http.post(url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'token': googleToken,
        }));
    Map<String, dynamic> responseObject = await json.decode(response.body);
    if (responseObject['success']) {
      return true;
    }
    return false;
  }

  static Future<Map<String, dynamic>> getUser(String googleToken) async {
    var url = Uri.parse('$endpoint/api/user/getDetails');
    var response = await http.post(url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'token': googleToken,
        }));
    Map<String, dynamic> responseObject = json.decode(response.body);
    Map<String, dynamic> result = {};
    if (responseObject['success']) {
      result['success'] = true;
      result['user'] = responseObject['user'];
      result['venueTypes'] = responseObject['venueTypes'];
      result['personalityTypes'] = responseObject['personalityTypes'];
      return result;
    }
    result['success'] = false;
    return result;
  }

  static Future<Map<String, dynamic>> addUser(
    Map<String, dynamic> userDetails,
  ) async {
    var url = Uri.parse('$endpoint/api/user/addDetails');
    var response = await http.post(url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'token': userDetails['googleToken'],
          'twitter': userDetails['twitterHandle'],
          'location': {
            'lat': userDetails['latitude'],
            'lng': userDetails['longitude'],
          }
        }));
    Map<String, dynamic> responseObject = json.decode(response.body);
    Map<String, dynamic> result = {};
    if (responseObject['success']) {
      result['success'] = true;
      result['userDetails'] = responseObject['user'];
      return result;
    }
    result['success'] = false;
    return result;
  }

  static Future<Map<String, dynamic>> addUserP({
    required String token,
    required String personality,
    required double latitude,
    required double longitude,
  }) async {
    var url = Uri.parse('$endpoint/api/user/addDetails');
    var response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(
        {
          'token': token,
          'personality': personality,
          'location': {
            'lat': latitude,
            'lng': longitude,
          }
        },
      ),
    );
    Map<String, dynamic> responseObject = json.decode(response.body);
    Map<String, dynamic> result = {};
    if (responseObject['success']) {
      result['success'] = true;
      result['userDetails'] = responseObject['user'];
      return result;
    } else {
      result['success'] = false;
      result['message'] = responseObject['message'] ?? 'Personality error';
      return result;
    }
    return result;
  }

  static Future<Map<String, dynamic>> getRooms(String googleToken) async {
    var url = Uri.parse('$endpoint/api/user/getRooms');
    var response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(
        {
          'token': googleToken,
        },
      ),
    );
    Map<String, dynamic> responseObject = await jsonDecode(response.body);
    Map<String, dynamic> result = {};
    if (responseObject['success']) {
      result['success'] = true;
      result['rooms'] = responseObject['result'];
      return result;
    }
    result['success'] = false;
    return result;
  }

  static Future<Map<String, dynamic>> joinRoom(
    Map<String, dynamic> userDetails,
  ) async {
    var url = Uri.parse('$endpoint/api/user/joinRoom');
    var response = await http.post(url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'token': userDetails['googleToken'],
          'roomId': userDetails['roomId'],
          'location': {
            'lat': userDetails['latitude'],
            'lng': userDetails['longitude'],
          }
        }));
    Map<String, dynamic> responseObject = json.decode(response.body);
    Map<String, dynamic> result = {};
    if (responseObject['success']) {
      result['success'] = true;
      result['roomList'] = responseObject['roomList'] as List<dynamic>;
      result['roomDetails'] = responseObject['roomDetails'];
      return result;
    }
    result['success'] = false;
    return result;
  }

  static Future<Map<String, dynamic>> createRoom(
    Map<String, dynamic> userDetails,
  ) async {
    var url = Uri.parse('$endpoint/api/user/createRoom');
    var response = await http.post(url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'token': userDetails['googleToken'],
          'name': userDetails['roomName'],
          'location': {
            'lat': userDetails['latitude'],
            'lng': userDetails['longitude'],
          }
        }));
    Map<String, dynamic> responseObject = json.decode(response.body);
    Map<String, dynamic> result = {};
    if (responseObject['success']) {
      result['success'] = true;
      result['result'] = responseObject['result'];
      return result;
    }
    result['success'] = false;
    return result;
  }

  static Future<Map<String, dynamic>> getRoomDetails(
    String googleToken,
    String roomId,
  ) async {
    var url = Uri.parse('$endpoint/api/user/getRoom');
    var response = await http.post(url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'token': googleToken,
          'roomId': roomId,
        }));
    Map<String, dynamic> responseObject = json.decode(response.body);
    Map<String, dynamic> result = {};
    if (responseObject['success']) {
      result['success'] = true;
      result['result'] = responseObject['roomDetails'];
      result['venueTypes'] = responseObject['venueTypes'];
      print(responseObject['roomDetails']);
      return result;
    }
    result['success'] = false;
    return result;
  }

  static Future<Map<String, dynamic>> getUsersInRoom(
    String googleToken,
    String roomId,
  ) async {
    var url = Uri.parse('$endpoint/api/user/getUsersInRoom');
    var response = await http.post(url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'token': googleToken,
          'roomId': roomId,
        }));
    Map<String, dynamic> responseObject = json.decode(response.body);
    Map<String, dynamic> result = {};
    if (responseObject['success']) {
      result['success'] = true;
      result['result'] = responseObject['result'];
      return result;
    }
    result['success'] = false;
    return result;
  }

  static Future<Map<String, dynamic>> leaveRoom(
    String googleToken,
    String roomId,
  ) async {
    var url = Uri.parse('$endpoint/api/user/leaveRoom');
    var response = await http.post(url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'token': googleToken,
          'roomId': roomId,
        }));
    Map<String, dynamic> responseObject = json.decode(response.body);
    Map<String, dynamic> result = {};
    if (responseObject['success']) {
      result['success'] = true;
      result['result'] = responseObject['result'];
      return result;
    }
    result['success'] = false;
    return result;
  }

  static Future<Map<String, dynamic>> getSuggestions(
    String googleToken,
    Map<String, dynamic> suggestionIds,
  ) async {
    var url = Uri.parse('$endpoint/api/user/getSuggestions');
    var response = await http.post(url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'token': googleToken,
          'suggestions': suggestionIds,
        }));
    Map<String, dynamic> responseObject = json.decode(response.body);
    Map<String, dynamic> result = {};
    if (responseObject['success']) {
      result['success'] = true;
      result['venues'] = responseObject['result'];
      return result;
    }
    result['success'] = false;
    return result;
  }

  static Future<Map<String, dynamic>> getPredictions(
    String googleToken,
    String roomId,
    String venueType,
  ) async {
    var url = Uri.parse('$endpoint/api/user/getPredictions');
    var response = await http.post(url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'token': googleToken,
          'roomId': roomId,
          'venueType': venueType,
        }));
    Map<String, dynamic> responseObject = json.decode(response.body);
    Map<String, dynamic> result = {};
    print('error error');
    print(responseObject);
    if (responseObject['success']) {
      result['success'] = true;
      result['venues'] = responseObject['result'];
      result['user'] = responseObject['user'];
      result['room'] = responseObject['room'];
      return result;
    }
    result['success'] = false;
    return result;
  }

  static Future<Map<String, dynamic>> getPredictionsNearMe(
    String googleToken,
    double lat,
    double lng,
    String venueType,
  ) async {
    Map<String, dynamic> result = {
      'success': false,
      'error': 'Not implemented',
    };

    var url = Uri.parse('$endpoint/api/user/getPredictionsNearMe');
    var response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(
        {
          'token': googleToken,
          'lat': lat,
          'lng': lng,
          'venueType': venueType,
        },
      ),
    );
    Map<String, dynamic> responseObject = json.decode(response.body);

    debugPrint('error error');
    debugPrint(responseObject.toString());

    if (responseObject['success']) {
      result['success'] = true;
      result['venues'] = responseObject['result'];
      result['user'] = responseObject['user'];
      return result;
    }

    return result;
  }

  static Future<Map<String, dynamic>> updateRoomUserLocation(
    Map<String, dynamic> userDetails,
  ) async {
    var url = Uri.parse('$endpoint/api/user/updateRoomUserLocation');
    var response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(
        {
          'token': userDetails['googleToken'],
          'roomId': userDetails['roomId'],
          'lat': userDetails['latitude'],
          'lng': userDetails['longitude'],
        },
      ),
    );
    Map<String, dynamic> responseObject = json.decode(response.body);
    Map<String, dynamic> result = {};
    if (responseObject['success']) {
      result['success'] = true;
      return result;
    }
    result['success'] = false;
    return result;
  }

  static Future<Map<String, dynamic>> updateTwitterHandle(
    String googleToken,
    String twitterId,
  ) async {
    var url = Uri.parse('$endpoint/api/user/updatePersonality');
    var response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(
        {
          'token': googleToken,
          'twitter': twitterId,
        },
      ),
    );
    Map<String, dynamic> responseObject = json.decode(response.body);
    Map<String, dynamic> result = {};
    if (responseObject['success']) {
      result['success'] = true;
      result['user'] = responseObject['user'];
      result['message'] =
          responseObject['message'] ?? 'Your Twitter ID has been updated :)';
      return result;
    }
    result['success'] = false;
    result['message'] =
        responseObject['message'] ?? 'Something went wrong :(, try again later';
    return result;
  }

  static Future<Map<String, dynamic>> updatePersonality(
    String googleToken,
    String personality,
  ) async {
    var url = Uri.parse('$endpoint/api/user/updatePersonality');
    var response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(
        {
          'token': googleToken,
          'personality': personality,
        },
      ),
    );
    Map<String, dynamic> responseObject = json.decode(response.body);
    Map<String, dynamic> result = {};
    if (responseObject['success']) {
      result['success'] = true;
      result['user'] = responseObject['user'];
      result['message'] =
          responseObject['message'] ?? 'Your personality has been updated :)';
      return result;
    }

    result['success'] = false;
    result['message'] =
        responseObject['message'] ?? 'Something went wrong :(, try again later';
    return result;
  }

  static Future<Map<String, dynamic>> sendFeedback(
    String googleToken,
    String subject,
    String message,
  ) async {
    var url = Uri.parse('$endpoint/api/feedback/submit');
    var response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(
        {
          'token': googleToken,
          'subject': subject,
          'message': message,
        },
      ),
    );
    Map<String, dynamic> responseObject = json.decode(response.body);
    Map<String, dynamic> result = {};
    if (responseObject['success']) {
      result['success'] = true;
      result['formLink'] = responseObject['formLink'];
      result['message'] = responseObject['message'];
      return result;
    }
    result['success'] = false;
    return result;
  }

  static Future<Map<String, dynamic>> getAppConfigs() async {
    Map<String, dynamic> result = {
      'success': false,
      'message': 'Not implemented',
    };

    var url = Uri.parse('$endpoint/api/config/android');
    var response = await http.get(url);
    Map<String, dynamic> responseObject = json.decode(response.body);

    if (responseObject['success']) {
      result['success'] = true;
      result['appConfigs'] = AppConfigs.fromNetworkMap(responseObject);
      result['message'] = responseObject['message'];
      return result;
    } else {
      result['success'] = false;
      result['message'] = responseObject['message'] ?? 'Unknown error';
    }

    return result;
  }
}

// static Future<bool> checkUserExists(String phone) async {
//   var url = Uri.parse('$endpoint/user-exists?phone=$phone');
//   var response = await http.get(url);
//   if (kDebugMode) {
//     print(
//       'get $url ${response.statusCode} Response: ${response.body} ${response.headers}',
//     );
//   }
//   if (response.statusCode == 200 && response.body == 'true') {
//     return true;
//   }
//   return false;
// }

// static Future<Map<String, dynamic>> registerAndGetUserDetails(
//     AccountDetails accountDetails,
//     ) async {
//   Uri url = Uri.parse('$endpoint/auth');
//   Map<String, String> headerMap = {
//     'authtoken': accountDetails.token,
//   };
//
//   http.Response response = await http.post(url, headers: headerMap);
//   print(
//       'post $url ${response.statusCode} Response: ${response.body} ${response.headers}');
//   Map<String, dynamic> result = new Map();
//   result['success'] = false;
//   if (response.statusCode == 200) {
//     print('post $url successful');
//     result['success'] = true;
//     Map<String, dynamic> responseObject =
//     new Map<String, dynamic>.from(json.decode(response.body));
//     print('post $url Body: $responseObject');
//     User newUser = new User(
//       name: responseObject['name'] == null || responseObject['name'] == ''
//           ? 'User'
//           : responseObject['name'],
//       email: responseObject['email'],
//       picture: responseObject['photoURL'] == null ||
//           responseObject['photoURL'] == ''
//           ? defaultProfileUrl
//           : responseObject['photoURL'],
//     );
//
//     print(
//         'post $url user: ${newUser.name} ${newUser.email} ${newUser.picture}');
//     result['user'] = newUser;
//   } else {
//     print('post $url failed');
//     result['success'] = false;
//     result['user'] = null;
//     result['message'] = response.body;
//   }
//
//   print('post $url result: $result');
//   return result;
// }
