class Work {
  List<Workexps>? workexps;

  Work({this.workexps});

  Work.fromJson(Map<String, dynamic> json) {
    if (json['workexps'] != null) {
      workexps = <Workexps>[];
      json['workexps'].forEach((v) {
        workexps!.add(new Workexps.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.workexps != null) {
      data['workexps'] = this.workexps!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Workexps {
  int? idWorkexp;
  String? namaPekerjaan;
  String? namaPerusahaan;
  String? tanggalBekerja;
  String? tanggalBerhenti;
  String? description;
  String? createdAt;
  String? updatedAt;
  int? id;

  Workexps(
      {this.idWorkexp,
      this.namaPekerjaan,
      this.namaPerusahaan,
      this.tanggalBekerja,
      this.tanggalBerhenti,
      this.description,
      this.createdAt,
      this.updatedAt,
      this.id});

  Workexps.fromJson(Map<String, dynamic> json) {
    idWorkexp = json['id_workexp'];
    namaPekerjaan = json['Nama_pekerjaan'];
    namaPerusahaan = json['Nama_perusahaan'];
    tanggalBekerja = json['Tanggal_bekerja'];
    tanggalBerhenti = json['Tanggal_Berhenti'];
    description = json['Description'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_workexp'] = this.idWorkexp;
    data['Nama_pekerjaan'] = this.namaPekerjaan;
    data['Nama_perusahaan'] = this.namaPerusahaan;
    data['Tanggal_bekerja'] = this.tanggalBekerja;
    data['Tanggal_Berhenti'] = this.tanggalBerhenti;
    data['Description'] = this.description;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['id'] = this.id;
    return data;
  }
}
