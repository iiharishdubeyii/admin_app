// ignore_for_file: prefer_null_aware_operators


import 'advisor_model.dart';

class UserModel {
  String? firstName;
  String? lastName;
  String? title;
  String? profileImage;
  DateTime? dateOfBirth;
  String? phoneNumber;
  String? email;
  String? alpyneUserId;
  double? inrBalance;
  double? walletBalance;
  bool? termsAndConditionsAccepted;
  BankDetails? bankDetails;
  Address? address;
  GovernmentId? governmentId;
  AdvisorModel? advisor;
  bool? kycStatus;

  UserModel({
    this.firstName,
    this.lastName,
    this.title,
    this.profileImage,
    this.dateOfBirth,
    this.phoneNumber,
    this.email,
    this.alpyneUserId,
    this.inrBalance,
    this.walletBalance,
    this.termsAndConditionsAccepted,
    this.bankDetails,
    this.address,
    this.governmentId,
    this.advisor,
    this.kycStatus,
  });

  UserModel.fromJson(Map<String, dynamic> json)
      : firstName = json['firstName'],
        lastName = json['lastName'],
        title = json['title'],
        profileImage = json['profileImage'] ,
        dateOfBirth = DateTime.parse(json['dateOfBirth']),
        phoneNumber = json['phoneNumber'],
        email = json['email'],
        alpyneUserId = json['alpyneUserId'],
        inrBalance = json['inrBalance'] != null
            ? double.parse(json['inrBalance'].toString())
            : 0.0,
        walletBalance = json['walletBalance'] != null
            ? double.parse(json['walletBalance'].toString())
            : 0.0,
        termsAndConditionsAccepted = json['termsAndConditionsAccepted'],
        bankDetails = json['bankDetails'] != null
            ? BankDetails.fromJson(json['bankDetails'])
            : null,
        address =
            json['address'] != null ? Address.fromJson(json['address']) : null,
        governmentId = json['governmentId'] != null
            ? GovernmentId.fromJson(json['governmentId'])
            : null,
            
        advisor = json['advisor'] != null
            ? AdvisorModel.fromJson(json['advisor'],
            
            )
            : null,
            kycStatus = json['kycStatus'] ?? false ;
             
            

  Map<String, dynamic> toJson() => {
        'firstName': firstName,
        'lastName': lastName,
        'title': title,
        'profileImage': profileImage,
        'dateOfBirth': dateOfBirth!.toIso8601String(),
        'phoneNumber': phoneNumber,
        'email': email,
        'alpyneUserId': alpyneUserId,
        'walletBalance': walletBalance,
        'termsAndConditionsAccepted': true,
        'bankDetails': bankDetails != null ? bankDetails!.toJson() : null,
        'address': address != null ? address!.toJson() : null,
        'governmentId': governmentId != null ? governmentId!.toJson() : null,
        'advisor': advisor != null ? advisor!.toJson() : null,
        'kycStatus': kycStatus??false,
      };
}

class BankDetails {
  String? accountNumber;
  String? ifscCode;
  String? accountHolderName;
  String? bankName;
  String? vpa;

  BankDetails({
    this.accountNumber,
    this.ifscCode,
    this.accountHolderName,
    this.bankName,
    this.vpa,
  });

  BankDetails.fromJson(Map<String, dynamic> json)
      : accountNumber = json['accountNumber'],
        ifscCode = json['ifscCode'],
        accountHolderName = json['accountHolderName'],
        bankName = json['bankName'],
        vpa = json['vpa'];

  Map<String, dynamic> toJson() => {
        'accountNumber': accountNumber,
        'ifscCode': ifscCode,
        'accountHolderName': accountHolderName,
        'bankName': bankName,
        'vpa': vpa,
      };
}

class Address {
  String? addressLine1;
  String? addressLine2;
  String? city;
  String? state;
  String? pinCode;

  Address({
    this.addressLine1,
    this.addressLine2,
    this.city,
    this.state,
    this.pinCode,
  });

  Address.fromJson(Map<String, dynamic> json)
      : addressLine1 = json['addressLine1'],
        addressLine2 = json['addressLine2'],
        city = json['city'],
        state = json['state'],
        pinCode = json['pinCode'];

  Map<String, dynamic> toJson() => {
        'addressLine1': addressLine1,
        'addressLine2': addressLine2,
        'city': city,
        'state': state,
        'pinCode': pinCode,
      };
}

class GovernmentId {
  String? aadharCard;
  String? panCard;

  GovernmentId({
    this.aadharCard,
    this.panCard,
  });

  GovernmentId.fromJson(Map<String, dynamic> json)
      : aadharCard = json['aadharCard'],
        panCard = json['panCard'];

  Map<String, dynamic> toJson() => {
        'aadharCard': aadharCard,
        'panCard': panCard,
      };
}
