import 'dart:convert';

import 'package:pas_app/Api/Constant/constant.dart';
import 'package:pas_app/Api/NeedWork/schoolmodel.dart';
import 'package:pas_app/Api/Response/responseapi.dart';
import 'package:http/http.dart' as http;
import 'package:pas_app/Api/Services/user_services.dart';

//getuserdetail
Future<Apirespose> getschooluser(String id) async {
  Apirespose apiresponse = Apirespose();
  try {
    String token = await getToken();
    final response = await http
        .get(Uri.parse(baseUrl + "/api/user/school/" + id), headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    });

    switch (response.statusCode) {
      case 200:
        apiresponse.data = Schooldatauser.fromJson(jsonDecode(response.body));
        break;
      case 401:
        apiresponse.error = unauthroized;
        break;
      default:
        apiresponse.error = somethingWentWrong;
        break;
    }
  } catch (e) {
    apiresponse.error = serverError;
  }
  return apiresponse;
}

//post work
Future<Apirespose> postschooluser(
  String? nameschool,
  String? major,
  String? graduation_year,
) async {
  Apirespose apiresponse = Apirespose();
  try {
    String token = await getToken();
    final response =
        await http.post(Uri.parse(baseUrl + "/api/user/school/post"), headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    }, body: {
      'nameschool': nameschool,
      'major': major,
      'graduation_year': graduation_year,
    });

    switch (response.statusCode) {
      case 200:
        apiresponse.data = jsonDecode(response.body);
        break;
      case 422:
        final errors = jsonDecode(response.body)['errors'];
        apiresponse.error = errors[errors.keys.elementAt(0)][0];
        break;
      case 401:
        apiresponse.error = unauthroized;
        break;
      default:
        print(response.body);
        apiresponse.error = somethingWentWrong;
        break;
    }
  } catch (e) {
    apiresponse.error = serverError;
  }
  return apiresponse;
}

//upadate work

Future<Apirespose> updateschooluser(
  String? id,
  String? nameschool,
  String? major,
  String? graduation_year,
) async {
  Apirespose apiResponse = Apirespose();
  try {
    String token = await getToken();
    final response = await http.put(
        Uri.parse(baseUrl + "/api/user/school/update/" + id.toString()),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token'
        },
        body: {
          'nameschool': nameschool,
          'major': major,
          'graduation_year': graduation_year,
        });

    switch (response.statusCode) {
      case 200:
        apiResponse.data = jsonDecode(response.body)['message'];
        break;
      case 401:
        apiResponse.error = unauthroized;
        break;
      default:
        print(response.body);
        apiResponse.error = somethingWentWrong;
        break;
    }
  } catch (e) {
    apiResponse.error = serverError;
  }
  return apiResponse;
}

// Delete post
Future<Apirespose> deleteschooluser(String id) async {
  Apirespose apiResponse = Apirespose();
  try {
    String token = await getToken();
    final response = await http.delete(
        Uri.parse(baseUrl + '/api/user/school/delete/' + id.toString()),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token'
        });

    switch (response.statusCode) {
      case 200:
        apiResponse.data = jsonDecode(response.body)['message'];
        break;
      case 403:
        apiResponse.error = jsonDecode(response.body)['message'];
        break;
      case 401:
        apiResponse.error = unauthroized;
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
