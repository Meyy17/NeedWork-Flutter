class Workexpbyuser {
  List<Workexpsuser>? workexpsuser;

  Workexpbyuser({this.workexpsuser});

  Workexpbyuser.fromJson(Map<String, dynamic> json) {
    if (json['workexpsuser'] != null) {
      workexpsuser = <Workexpsuser>[];
      json['workexpsuser'].forEach((v) {
        workexpsuser!.add(new Workexpsuser.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.workexpsuser != null) {
      data['workexpsuser'] = this.workexpsuser!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Workexpsuser {
  int? id;
  int? idUser;
  String? namaPekerjaan;
  String? namaPerusahaan;
  String? tanggalBekerja;
  String? tanggalBerhenti;
  String? description;
  String? createdAt;
  String? updatedAt;

  Workexpsuser(
      {this.id,
      this.idUser,
      this.namaPekerjaan,
      this.namaPerusahaan,
      this.tanggalBekerja,
      this.tanggalBerhenti,
      this.description,
      this.createdAt,
      this.updatedAt});

  Workexpsuser.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    idUser = json['id_user'];
    namaPekerjaan = json['Nama_pekerjaan'];
    namaPerusahaan = json['Nama_perusahaan'];
    tanggalBekerja = json['Tanggal_bekerja'];
    tanggalBerhenti = json['Tanggal_Berhenti'];
    description = json['Description'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['id_user'] = this.idUser;
    data['Nama_pekerjaan'] = this.namaPekerjaan;
    data['Nama_perusahaan'] = this.namaPerusahaan;
    data['Tanggal_bekerja'] = this.tanggalBekerja;
    data['Tanggal_Berhenti'] = this.tanggalBerhenti;
    data['Description'] = this.description;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
