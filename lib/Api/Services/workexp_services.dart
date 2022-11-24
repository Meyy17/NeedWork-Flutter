import 'dart:convert';
import 'dart:io';

import 'package:pas_app/Api/Constant/constant.dart';
import 'package:pas_app/Api/NeedWork/alluser.dart';
import 'package:pas_app/Api/NeedWork/usermodel.dart';
import 'package:pas_app/Api/NeedWork/workexpmodel.dart';
import 'package:pas_app/Api/Response/responseapi.dart';
import 'package:http/http.dart' as http;
import 'package:pas_app/Api/Services/user_services.dart';
import 'package:shared_preferences/shared_preferences.dart';

//getuserdetail
Future<Apirespose> getworkexpbyuser(String id) async {
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
        apiresponse.data = Workexpbyuser.fromJson(jsonDecode(response.body));
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
Future<Apirespose> postworkexp(
  String? namapekerjaan,
  String? namaperusahaan,
  String? description,
  String? tanggalkerja,
  String? tanggalberhenti,
) async {
  Apirespose apiresponse = Apirespose();
  try {
    String token = await getToken();
    final response = await http
        .post(Uri.parse(baseUrl + "/api/user/workexp/post"), headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    }, body: {
      'Nama_pekerjaan': namapekerjaan,
      'Nama_perusahaan': namaperusahaan,
      'Description': description,
      'Tanggal_bekerja': tanggalkerja,
      'Tanggal_Berhenti': tanggalberhenti,
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

Future<Apirespose> updateworkexp(
  String? id,
  String? namapekerjaan,
  String? namaperusahaan,
  String? description,
  String? tanggalkerja,
  String? tanggalberhenti,
) async {
  Apirespose apiResponse = Apirespose();
  try {
    String token = await getToken();
    final response = await http.put(
        Uri.parse(baseUrl + "/api/user/workexp/update/" + id.toString()),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token'
        },
        body: {
          'Nama_pekerjaan': namapekerjaan,
          'Nama_perusahaan': namaperusahaan,
          'Description': description,
          'Tanggal_bekerja': tanggalkerja,
          'Tanggal_Berhenti': tanggalberhenti,
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
Future<Apirespose> deletePost(String id) async {
  Apirespose apiResponse = Apirespose();
  try {
    String token = await getToken();
    final response = await http.delete(
        Uri.parse(baseUrl + '/api/user/workexp/delete/' + id.toString()),
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
