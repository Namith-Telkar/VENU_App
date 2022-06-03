import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class NetworkHelper {
  NetworkHelper();

  static String endpoint = 'https://www.example.com/api';

  static Future<bool> checkUserExists(String phone) async {
    var url = Uri.parse('$endpoint/user-exists?phone=$phone');
    var response = await http.get(url);
    if (kDebugMode) {
      print(
        'get $url ${response.statusCode} Response: ${response.body} ${response.headers}',
      );
    }
    if (response.statusCode == 200 && response.body == 'true') {
      return true;
    }
    return false;
  }
}

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
