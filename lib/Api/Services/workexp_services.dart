import 'dart:convert';
import 'dart:io';

import 'package:pas_app/Api/Constant/constant.dart';
import 'package:pas_app/Api/NeedWork/alluser.dart';
import 'package:pas_app/Api/NeedWork/user.dart';
import 'package:pas_app/Api/NeedWork/workexp.dart';
import 'package:pas_app/Api/Response/responseapi.dart';
import 'package:http/http.dart' as http;
import 'package:pas_app/Api/Services/user_services.dart';
import 'package:shared_preferences/shared_preferences.dart';

//userdetail
Future<Apirespose> getworkexp(String id) async {
  Apirespose apiresponse = Apirespose();
  try {
    String token = await getToken();
    final response = await http
        .get(Uri.parse(baseUrl + "/api/user/workexp/" + id), headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    });

    switch (response.statusCode) {
      case 200:
        apiresponse.data = Work.fromJson(jsonDecode(response.body));
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
