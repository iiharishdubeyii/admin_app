
import 'package:gc_admin_app/models/user_transaction_dto.dart';

class QueriedApiDto {
    QuriedData? quriedData;
    String? docId;
    UserQueriedDto? userData;
    AdvisorQueried? avisorQData;

    QueriedApiDto({
          this.quriedData,
          this.docId,
          this.userData,
          this.avisorQData,
    });

    factory QueriedApiDto.fromJson(Map<String, dynamic> json) => QueriedApiDto(
        quriedData:json["quriedData"] == null ? null: QuriedData.fromJson(json["quriedData"]),
        docId: json["docId"]??"",
        userData:json['userData'] == null ? null : UserQueriedDto.fromJson(json['userData']),
         avisorQData:json['avisorQData']==null?null: AdvisorQueried.fromJson(json['avisorQData']),
    );

    Map<String, dynamic> toJson() => {
        "quriedData": quriedData?.toJson(),
        "docId": docId??'',
        'userData':userData?.toJson(),
        "avisorQData":avisorQData ==null ?null:avisorQData?.toJson(),
    };
}

class QuriedData {
    String reason;
    String name;
    String description;
    String phoneCode;
    String isRegistered;
    String userType;
    String phoneNo;
    String email;
    String status;

    QuriedData({
         this.reason='',
         this.name='',
         this.description='',
         this.phoneCode='',
         this.isRegistered='',
         this.userType='',
         this.phoneNo='',
         this.email='',
         this.status= '',
    });

    factory QuriedData.fromJson(Map<String, dynamic> json) => QuriedData(
        reason: json["reason"]??'',
        name: json["name"]??'',
        description: json["description"]??'',
        phoneCode: json["phoneCode"]??'',
        isRegistered: json["isRegistered"]??'',
        userType: json["userType"]??'',
        phoneNo: json["phoneNo"]??'',
        email: json["email"]??'',
        status :json['status']??''
    );

    Map<String, dynamic> toJson() => {
        "reason": reason,
        "name": name,
        "description": description,
        "phoneCode": phoneCode,
        "isRegistered": isRegistered,
        "userType": userType,
        "phoneNo": phoneNo,
        "email": email,
        'status':status,
    };
}

class UserQueriedDto {
   String firstName;
   String lastName;
   String title;
   String dateOfBirth;

  UserQueriedDto({
     this.firstName='',
     this.lastName='',
     this.title='',
     this.dateOfBirth='',
  });

  factory UserQueriedDto.fromJson(Map<String, dynamic> json) {
    return UserQueriedDto(
      firstName: json['firstName']??'',
      lastName: json['lastName']??'',
      title: json['title']??'',
      dateOfBirth:json['dateOfBirth']??'',
    );
  }

  // Method to convert a User object to JSON
  Map<String, dynamic> toJson() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'title': title,
      'dateOfBirth': dateOfBirth,
    };
  }
}


class AdvisorQueried {
    String? firstName;
    String? lastName;
    String? id;
    String? profileImage;
    String? title;
    String? username;

    AdvisorQueried({
         this.firstName,
         this.lastName,
         this.id,
         this.profileImage,
         this.title,
         this.username,
    });

    factory AdvisorQueried.fromJson(Map<String, dynamic> json) => AdvisorQueried(
        firstName: json["firstName"]??''!,
        lastName: json["lastName"]??'',
        id: json["id"]??'',
        profileImage: json["profileImage"]??'',
        title: json["title"]??'',
        username: json["username"]??'',
    );

    Map<String, dynamic> toJson() => {
        "firstName": firstName??'',
        "lastName": lastName,
        "id": id??'',
        "profileImage": profileImage,
        "title": title??'',
        "username": username??'',
    };
}
   