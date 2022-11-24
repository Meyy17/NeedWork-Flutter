class PortofolioModel {
  List<Portofolio>? portofolio;

  PortofolioModel({this.portofolio});

  PortofolioModel.fromJson(Map<String, dynamic> json) {
    if (json['portofolio'] != null) {
      portofolio = <Portofolio>[];
      json['portofolio'].forEach((v) {
        portofolio!.add(new Portofolio.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.portofolio != null) {
      data['portofolio'] = this.portofolio!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Portofolio {
  int? id;
  int? idUser;
  String? image;
  String? judul;
  String? deskripsi;
  String? createdAt;
  String? updatedAt;

  Portofolio(
      {this.id,
      this.idUser,
      this.image,
      this.judul,
      this.deskripsi,
      this.createdAt,
      this.updatedAt});

  Portofolio.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    idUser = json['id_user'];
    image = json['image'];
    judul = json['judul'];
    deskripsi = json['deskripsi'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['id_user'] = this.idUser;
    data['image'] = this.image;
    data['judul'] = this.judul;
    data['deskripsi'] = this.deskripsi;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
