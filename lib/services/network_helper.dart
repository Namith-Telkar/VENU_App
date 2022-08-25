import 'dart:convert';
import 'package:http/http.dart' as http;

class NetworkHelper {
  NetworkHelper();

  static String endpoint = 'https://venu-backend-api.herokuapp.com';

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
    if (responseObject['success']) {
      return responseObject;
    }
    Map<String, dynamic> result = {};
    result['success'] = false;
    return result;
  }

  static Future<Map<String, dynamic>> addUser(
      Map<String, dynamic> userDetails) async {
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

  static Future<Map<String, dynamic>> getRooms(String googleToken) async {
    var url = Uri.parse('$endpoint/api/user/getRooms');
    var response = await http.post(url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'token': googleToken,
        }));
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
      Map<String, dynamic> userDetails) async {
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
    print(responseObject);
    if (responseObject['success']) {
      result['success'] = true;
      result['roomName'] = responseObject['name'];
      result['userRoomList'] = responseObject['userRoomList'];
      result['roomDetails'] = responseObject['roomDetails'];
      return result;
    }
    result['success'] = false;
    return result;
  }

  static Future<Map<String, dynamic>> createRoom(
      Map<String, dynamic> userDetails) async {
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
      String googleToken, String roomId) async {
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
      result['result'] = responseObject['result'];
      return result;
    }
    result['success'] = false;
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
