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
  String? companyName;
  String? companyLogo;
  String? companyLocation;
  String? companyDistrictAndProvince;
  String? aboutCompany;
  String? companyGallery;
  String? companyContact;
  String? companyEmail;
  String? poster;
  String? jobType;
  String? jobDescription;
  String? skillRequirements;
  String? salaryEstimate;
  String? advantagesOfJoin;
  String? workSystem;
  Null? createdAt;
  Null? updatedAt;

  Data(
      {this.id,
      this.companyName,
      this.companyLogo,
      this.companyLocation,
      this.companyDistrictAndProvince,
      this.aboutCompany,
      this.companyGallery,
      this.companyContact,
      this.companyEmail,
      this.poster,
      this.jobType,
      this.jobDescription,
      this.skillRequirements,
      this.salaryEstimate,
      this.advantagesOfJoin,
      this.workSystem,
      this.createdAt,
      this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    companyName = json['company_name'];
    companyLogo = json['company_logo'];
    companyLocation = json['company_location'];
    companyDistrictAndProvince = json['company_district_and_province'];
    aboutCompany = json['about_company'];
    companyGallery = json['company_gallery'];
    companyContact = json['company_contact'];
    companyEmail = json['company_email'];
    poster = json['poster'];
    jobType = json['job_type'];
    jobDescription = json['job_description'];
    skillRequirements = json['skill_requirements'];
    salaryEstimate = json['salary_estimate'];
    advantagesOfJoin = json['advantages_of_join'];
    workSystem = json['work_system'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'companyName': companyName,
      'companyLogo': companyLogo,
      'companyLocation': companyLocation,
      'companyDistrictAndProvince': companyDistrictAndProvince,
      'aboutCompany': aboutCompany,
      'companyGallery': companyGallery,
      'companyContact': companyContact,
      'companyEmail': companyEmail,
      'poster': poster,
      'jobType': jobType,
      'jobDescription': jobDescription,
      'skillRequirements': skillRequirements,
      'salaryEstimate': salaryEstimate,
      'advantagesOfJoin': advantagesOfJoin,
      'workSystem': workSystem,
    };
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['company_name'] = this.companyName;
    data['company_logo'] = this.companyLogo;
    data['company_location'] = this.companyLocation;
    data['company_district_and_province'] = this.companyDistrictAndProvince;
    data['about_company'] = this.aboutCompany;
    data['company_gallery'] = this.companyGallery;
    data['company_contact'] = this.companyContact;
    data['company_email'] = this.companyEmail;
    data['poster'] = this.poster;
    data['job_type'] = this.jobType;
    data['job_description'] = this.jobDescription;
    data['skill_requirements'] = this.skillRequirements;
    data['salary_estimate'] = this.salaryEstimate;
    data['advantages_of_join'] = this.advantagesOfJoin;
    data['work_system'] = this.workSystem;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
