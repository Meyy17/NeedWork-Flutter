class Schooldatauser {
  List<Schoolusers>? schoolusers;

  Schooldatauser({this.schoolusers});

  Schooldatauser.fromJson(Map<String, dynamic> json) {
    if (json['schoolusers'] != null) {
      schoolusers = <Schoolusers>[];
      json['schoolusers'].forEach((v) {
        schoolusers!.add(new Schoolusers.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.schoolusers != null) {
      data['schoolusers'] = this.schoolusers!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Schoolusers {
  int? id;
  int? idUser;
  String? nameschool;
  String? major;
  String? graduationYear;
  String? createdAt;
  String? updatedAt;

  Schoolusers(
      {this.id,
      this.idUser,
      this.nameschool,
      this.major,
      this.graduationYear,
      this.createdAt,
      this.updatedAt});

  Schoolusers.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    idUser = json['id_user'];
    nameschool = json['nameschool'];
    major = json['major'];
    graduationYear = json['graduation_year'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['id_user'] = this.idUser;
    data['nameschool'] = this.nameschool;
    data['major'] = this.major;
    data['graduation_year'] = this.graduationYear;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
