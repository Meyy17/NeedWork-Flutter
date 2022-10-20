class User {
  String? message;
  List<Data>? data;

  User({this.message, this.data});

  User.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? id;
  String? username;
  String? namaLengkap;
  String? alamat;
  String? tanggalLahir;
  String? bidangSkill;

  Data(
      {this.id,
      this.username,
      this.namaLengkap,
      this.alamat,
      this.tanggalLahir,
      this.bidangSkill});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['Username'];
    namaLengkap = json['Nama_Lengkap'];
    alamat = json['Alamat'];
    tanggalLahir = json['Tanggal_lahir'];
    bidangSkill = json['Bidang_Skill'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['Username'] = this.username;
    data['Nama_Lengkap'] = this.namaLengkap;
    data['Alamat'] = this.alamat;
    data['Tanggal_lahir'] = this.tanggalLahir;
    data['Bidang_Skill'] = this.bidangSkill;
    return data;
  }
}
