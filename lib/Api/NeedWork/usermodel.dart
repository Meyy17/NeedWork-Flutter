import 'dart:ffi';

import 'package:flutter/foundation.dart';

class User {
  int? id;
  String? name;
  String? email;
  String? token;
  String? image_profile;
  String? tanggal_lahir;
  String? phone_number;
  String? skill;

  String? jenis_kelamin;
  String? tempat_lahir;
  String? agama;
  String? alamat_lengkap;

  User({
    this.id,
    this.name,
    this.email,
    this.token,
    this.image_profile,
    this.tanggal_lahir,
    this.phone_number,
    this.skill,
    this.jenis_kelamin,
    this.agama,
    this.tempat_lahir,
    this.alamat_lengkap,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        id: json['user']['id'],
        name: json['user']['name'],
        email: json['user']['email'],
        image_profile: json['user']['image_profile'],
        tanggal_lahir: json['user']['tanggal_lahir'],
        phone_number: json['user']['phone_number'],
        skill: json['user']['skill'],
        jenis_kelamin: json['user']['jenis_kelamin'],
        tempat_lahir: json['user']['tempat_lahir'],
        agama: json['user']['agama'],
        alamat_lengkap: json['user']['alamat_lengkap'],
        token: json['token']);
  }
}
