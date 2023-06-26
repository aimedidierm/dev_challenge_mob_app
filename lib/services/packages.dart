import 'dart:convert';
import 'dart:ffi';

import 'package:dev_challenge/constants.dart';
import 'package:dev_challenge/models/api_response.dart';
import 'package:dev_challenge/services/user.dart';
import 'package:http/http.dart' as http;

Future<ApiResponse> sendPackageRequest(
    String name, String price, String units) async {
  ApiResponse apiResponse = ApiResponse();
  try {
    String token = await getToken();
    final response = await http.post(Uri.parse(categoryRequestURL), headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    }, body: {
      'name': name,
      'price': price,
      'unit': units,
    });
    print(response.body);
    switch (response.statusCode) {
      case 200:
        apiResponse.data = jsonDecode(response.body);
        break;
      case 422:
        final errors = jsonDecode(response.body)['errors'];
        apiResponse.error = errors[errors.keys.element(0)][0];
        break;
      case 403:
        apiResponse.error = jsonDecode(response.body)['message'];
        break;
      default:
        apiResponse.error = somethingWentWrong;
        break;
    }
  } catch (e) {
    apiResponse.error = serverError;
  }

  return apiResponse;
}
