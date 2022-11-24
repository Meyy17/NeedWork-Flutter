class Post {
  String? message;
  List<Data>? data;

  Post({this.message, this.data});

  Post.fromJson(Map<String, dynamic> json) {
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
  int? idUser;
  String? logoPerusahaan;
  String? tentangPerusahaan;
  String? lokasiPerusahaan;
  String? emailPerusahaan;
  String? contactPerusahaan;
  String? banner;
  String? dibutuhkan;
  String? deskripsi;
  String? rangeGaji;
  String? sistemkerja;
  String? lulusanMinimal;
  String? persyaratan;

  Data(
      {this.id,
      this.idUser,
      this.logoPerusahaan,
      this.tentangPerusahaan,
      this.lokasiPerusahaan,
      this.emailPerusahaan,
      this.contactPerusahaan,
      this.banner,
      this.dibutuhkan,
      this.deskripsi,
      this.rangeGaji,
      this.sistemkerja,
      this.lulusanMinimal,
      this.persyaratan});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    idUser = json['id_user'];
    logoPerusahaan = json['logo_perusahaan'];
    tentangPerusahaan = json['tentang_perusahaan'];
    lokasiPerusahaan = json['lokasi_perusahaan'];
    emailPerusahaan = json['email_perusahaan'];
    contactPerusahaan = json['contact_perusahaan'];
    banner = json['banner'];
    dibutuhkan = json['dibutuhkan'];
    deskripsi = json['deskripsi'];
    rangeGaji = json['range_gaji'];
    sistemkerja = json['sistemkerja'];
    lulusanMinimal = json['lulusan_minimal'];
    persyaratan = json['persyaratan'];
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'companyName': contactPerusahaan,
      'companyLogo': logoPerusahaan,
      'companyLocation': lokasiPerusahaan,
      'aboutCompany': tentangPerusahaan,
      'companyEmail': emailPerusahaan,
      'poster': banner,
      'jobDescription': dibutuhkan,
      'skillRequirements': persyaratan,
      'salaryEstimate': rangeGaji,
      'advantagesOfJoin': lulusanMinimal,
      'workSystem': sistemkerja,
    };
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['id_user'] = this.idUser;
    data['logo_perusahaan'] = this.logoPerusahaan;
    data['tentang_perusahaan'] = this.tentangPerusahaan;
    data['lokasi_perusahaan'] = this.lokasiPerusahaan;
    data['email_perusahaan'] = this.emailPerusahaan;
    data['contact_perusahaan'] = this.contactPerusahaan;
    data['banner'] = this.banner;
    data['dibutuhkan'] = this.dibutuhkan;
    data['deskripsi'] = this.deskripsi;
    data['range_gaji'] = this.rangeGaji;
    data['sistemkerja'] = this.sistemkerja;
    data['lulusan_minimal'] = this.lulusanMinimal;
    data['persyaratan'] = this.persyaratan;
    return data;
  }
}
