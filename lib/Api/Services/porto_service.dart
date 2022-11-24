import 'dart:convert';

import 'package:pas_app/Api/Constant/constant.dart';
import 'package:pas_app/Api/NeedWork/portomodel.dart';
import 'package:pas_app/Api/Response/responseapi.dart';
import 'package:http/http.dart' as http;
import 'package:pas_app/Api/Services/user_services.dart';

//getportouser
Future<Apirespose> getportouser(String id) async {
  Apirespose apiresponse = Apirespose();
  try {
    String token = await getToken();
    final response = await http
        .get(Uri.parse(baseUrl + "/api/user/portofolio/" + id), headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    });

    switch (response.statusCode) {
      case 200:
        apiresponse.data = PortofolioModel.fromJson(jsonDecode(response.body));
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
