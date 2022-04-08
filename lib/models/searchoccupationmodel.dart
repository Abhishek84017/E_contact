class SearchOccupationModel {
  int id;
  String code;
  String name;
  String gotra;
  String gender;
  int age;
  String bloodGroup;
  String dateOfBirth;
  String mobile;
  String email;
  String address;
  String firmName;
  String officeAddress;
  String occupation;
  String occupationDetail;
  String officeContact;
  String image;
  String nativePlace;
  String birthPlace;
  String dateOfJoin;
  String socialGroup;
  int status;
  String barcode;
  String password;
  String anniversary;
  String fatherName;
  String motherName;
  String officeEmail;
  String reference;
  String specialAchievement;
  String whyJoin;
  String aadharNo;
  String token;
  String marrital;
  String deviceType;
  String proof;

  SearchOccupationModel(
      {this.id,
        this.code,
        this.name,
        this.gotra,
        this.gender,
        this.age,
        this.bloodGroup,
        this.dateOfBirth,
        this.mobile,
        this.email,
        this.address,
        this.firmName,
        this.officeAddress,
        this.occupation,
        this.occupationDetail,
        this.officeContact,
        this.image,
        this.nativePlace,
        this.birthPlace,
        this.dateOfJoin,
        this.socialGroup,
        this.status,
        this.barcode,
        this.password,
        this.anniversary,
        this.fatherName,
        this.motherName,
        this.officeEmail,
        this.reference,
        this.specialAchievement,
        this.whyJoin,
        this.aadharNo,
        this.token,
        this.marrital,
        this.deviceType,
        this.proof});

  SearchOccupationModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    name = json['name'];
    gotra = json['gotra'];
    gender = json['gender'];
    age = json['age'];
    bloodGroup = json['blood_group'];
    dateOfBirth = json['date_of_birth'];
    mobile = json['mobile'];
    email = json['email'];
    address = json['address'];
    firmName = json['firm_name'];
    officeAddress = json['office_address'];
    occupation = json['occupation'];
    occupationDetail = json['occupation_detail'];
    officeContact = json['office_contact'];
    image = json['image'];
    nativePlace = json['native_place'];
    birthPlace = json['birth_place'];
    dateOfJoin = json['date_of_join'];
    socialGroup = json['social_group'];
    status = json['status'];
    barcode = json['barcode'];
    password = json['password'];
    anniversary = json['anniversary'];
    fatherName = json['father_name'];
    motherName = json['mother_name'];
    officeEmail = json['office_email'];
    reference = json['reference'];
    specialAchievement = json['special_achievement'];
    whyJoin = json['why_join'];
    aadharNo = json['aadhar_no'];
    token = json['token'];
    marrital = json['marrital'];
    deviceType = json['device_type'];
    proof = json['proof'];
  }
}