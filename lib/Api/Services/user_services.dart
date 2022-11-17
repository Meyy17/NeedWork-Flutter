import 'dart:convert';
import 'dart:io';

import 'package:pas_app/Api/Constant/constant.dart';
import 'package:pas_app/Api/NeedWork/alluser.dart';
import 'package:pas_app/Api/NeedWork/user.dart';
import 'package:pas_app/Api/Response/responseapi.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

//Login
Future<Apirespose> login(String email, String password) async {
  Apirespose apiresponse = Apirespose();
  try {
    final response = await http.post(Uri.parse(baseUrl + "/api/login"),
        headers: {'Accept': 'application/json'},
        body: {'email': email, 'password': password});

    switch (response.statusCode) {
      case 200:
        apiresponse.data = User.fromJson(jsonDecode(response.body));
        break;
      case 422:
        final errors = jsonDecode(response.body)['errors'];
        apiresponse.error = errors[errors.keys.elementAt(0)[0]];
        break;
      case 403:
        apiresponse.error = jsonDecode(response.body)['message'];
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

//Register
Future<Apirespose> registerUser(
    String email, String password, String name, String? tanggal_lahir) async {
  Apirespose apiresponse = Apirespose();
  try {
    final response =
        await http.post(Uri.parse(baseUrl + "/api/register"), headers: {
      'Accept': 'application/json'
    }, body: {
      'email': email,
      'password': password,
      'name': name,
      'password_confirmation': password,
      'tanggal_lahir': tanggal_lahir,
    });

    switch (response.statusCode) {
      case 200:
        apiresponse.data = User.fromJson(jsonDecode(response.body));
        break;
      case 422:
        final errors = jsonDecode(response.body)['errors'];
        apiresponse.error = errors[errors.keys.elementAt(0)[0]];
        break;
      case 403:
        apiresponse.error = jsonDecode(response.body)['message'];
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

//userdetail
Future<Apirespose> getuserdetail() async {
  Apirespose apiresponse = Apirespose();
  try {
    String token = await getToken();
    final response = await http.get(Uri.parse(baseUrl + "/api/user"), headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    });

    switch (response.statusCode) {
      case 200:
        apiresponse.data = User.fromJson(jsonDecode(response.body));
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

//GetToken
Future<String> getToken() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  return pref.getString('token') ?? '';
}

//GetUserid
Future<int> getUserid() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  return pref.getInt('userId') ?? 0;
}

//LOGOUT
Future<bool> logout() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  return pref.remove('token');
}

// Update user
Future<Apirespose> updateimg(
    String? image_profile,
    String? name,
    String? tempat_lahir,
    String? tanggal_lahir,
    String? jenis_kelamin,
    String? phone_number,
    String? agama,
    String? alamat_lengkap,
    String? skill) async {
  Apirespose apiResponse = Apirespose();
  try {
    String token = await getToken();
    final response = await http.put(Uri.parse(baseUrl + "/api/user/update/img"),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token'
        },
        body: image_profile == null
            ? {
                'name': name,
                'tempat_lahir': tempat_lahir,
                'tanggal_lahir': tanggal_lahir,
                'jenis_kelamin': jenis_kelamin,
                'phone_number': phone_number,
                'agama': agama,
                'alamat_lengkap': alamat_lengkap,
                'skill': skill,
              }
            : {
                'name': name,
                'tempat_lahir': tempat_lahir,
                'tanggal_lahir': tanggal_lahir,
                'jenis_kelamin': jenis_kelamin,
                'phone_number': phone_number,
                'agama': agama,
                'alamat_lengkap': alamat_lengkap,
                'skill': skill,
                'image_profile': image_profile,
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

Future<Apirespose> updateuser(
    String? name,
    String? tempat_lahir,
    String? tanggal_lahir,
    String? jenis_kelamin,
    String? phone_number,
    String? agama,
    String? alamat_lengkap,
    String? skill) async {
  Apirespose apiResponse = Apirespose();
  int pun = 08954103180;
  try {
    String token = await getToken();
    final response =
        await http.put(Uri.parse(baseUrl + "/api/user/update"), headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    }, body: {
      'name': name,
      'tempat_lahir': tempat_lahir,
      'tanggal_lahir': tanggal_lahir,
      'jenis_kelamin': jenis_kelamin,
      'phone_number': phone_number,
      'agama': agama,
      'alamat_lengkap': alamat_lengkap,
      'skill': skill,
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

// Get base64 encoded image
String? getStringImage(File? file) {
  if (file == null) return null;
  return base64Encode(file.readAsBytesSync());
}
