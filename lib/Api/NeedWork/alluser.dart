class Alluser {
  String? message;
  List<Data>? data;

  Alluser({this.message, this.data});

  Alluser.fromJson(Map<String, dynamic> json) {
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
  String? name;
  String? email;
  Null? emailVerifiedAt;
  String? jenisKelamin;
  String? tempatLahir;
  String? agama;
  String? alamatLengkap;
  String? skill;
  String? phoneNumber;
  String? tanggalLahir;
  String? namaPekerjaan;
  String? createdAt;
  String? updatedAt;

  Data(
      {this.id,
      this.name,
      this.email,
      this.emailVerifiedAt,
      this.jenisKelamin,
      this.tempatLahir,
      this.agama,
      this.alamatLengkap,
      this.skill,
      this.phoneNumber,
      this.tanggalLahir,
      this.namaPekerjaan,
      this.createdAt,
      this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    emailVerifiedAt = json['email_verified_at'];
    jenisKelamin = json['jenis_kelamin'];
    tempatLahir = json['tempat_lahir'];
    agama = json['agama'];
    alamatLengkap = json['alamat_lengkap'];
    skill = json['skill'];
    phoneNumber = json['phone_number'];
    tanggalLahir = json['tanggal_lahir'];
    namaPekerjaan = json['Nama_pekerjaan'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['jenis_kelamin'] = this.jenisKelamin;
    data['tempat_lahir'] = this.tempatLahir;
    data['agama'] = this.agama;
    data['alamat_lengkap'] = this.alamatLengkap;
    data['skill'] = this.skill;
    data['phone_number'] = this.phoneNumber;
    data['tanggal_lahir'] = this.tanggalLahir;
    data['Nama_pekerjaan'] = this.namaPekerjaan;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
