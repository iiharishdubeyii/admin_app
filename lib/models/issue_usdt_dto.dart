class IssueUsdtDto {
  String issueUsdtid;
   String name;
   String number;
   String advisorName;
   String email;
   String walletBalance;
String amountTobeAdded;

    String dateTime;
   

  IssueUsdtDto({
    this.issueUsdtid='',
     this.name='',
     this.number='',
     this.advisorName='',
     this.email='',
     this.walletBalance='',
     this.amountTobeAdded = '',
     this.dateTime = '',
  });

  // Factory method to create a DTO from JSON
  factory IssueUsdtDto.fromJson(Map<String, dynamic> json) {
    return IssueUsdtDto(
      name: json['name'] as String,
      number: json['number'] as String,
      advisorName: json['advisorName'] as String,
         email: json['email'] as String,
      walletBalance: json['walletBalance'] as String,
      amountTobeAdded: json['amountTobeAdded'] as String,
    );
  }

  // Method to convert the DTO to JSON
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'number': number,
      'advisorName': advisorName,
      'email':email,
      'walletBalance':walletBalance,
      'amountTobeAdded':amountTobeAdded,
    };
  }

  @override
  String toString() {
    return 'IssueUsdtDto(name: $name, number: $number, advisorName: $advisorName)';
  }
}





class IssueUSDTDto {
    
    String userDocId;
    UserIsuueUSDT user;

    IssueUSDTDto({
        
        required this.userDocId,
        required this.user,
    });

    factory IssueUSDTDto.fromJson(Map<String, dynamic> json) => IssueUSDTDto(
       
        user: UserIsuueUSDT.fromJson(json["user"]),
        
         userDocId:  json["udocId"],
    );

    Map<String, dynamic> toJson() => {
        
        "user": user.toJson(),
 
        "udocId":userDocId,
    };
}


class UserIsuueUSDT {
  String userId;
    String? lastName;
    dynamic address;
    String? dateOfBirth;
    String? profileImage;
    bool? termsAndConditionsAccepted;
    String? title;
    dynamic bankDetails;
    String? firstName;
    AdvisorIssueUSDT? advisor;
    
    bool? alchemyWebhook;
    String? phoneNumber;
    dynamic walletBalance;
    String? venlyPin;
    dynamic alpyneUserId;
    String? email;
 
    dynamic governmentId;

    UserIsuueUSDT({
      this.userId='',
         this.lastName,
         this.address,
         this.dateOfBirth,
         this.profileImage,
         this.termsAndConditionsAccepted,
         this.title,
         this.bankDetails,
         this.firstName,
         this.advisor,
      
        this.alchemyWebhook,
         this.phoneNumber,
         this.walletBalance,
        this.venlyPin,
        this.alpyneUserId,
         this.email,
       
         this.governmentId,
    });

    factory UserIsuueUSDT.fromJson(Map<String, dynamic> json) => UserIsuueUSDT(
       userId: json["userId"]??''!,
         lastName: json["lastName"]??''!,
        address: json["address"]??'',
        dateOfBirth: json["dateOfBirth"]??'',
        profileImage: json["profileImage"]??'',
        termsAndConditionsAccepted: json["termsAndConditionsAccepted"]??false,
        title: json["title"]??''!,
        bankDetails: json["bankDetails"]??'',
        firstName: json["firstName"]??'',
        advisor: json["advisor"] == null ? null : AdvisorIssueUSDT.fromJson(json["advisor"]),
        
        alchemyWebhook: json["alchemyWebhook"]??false,
        phoneNumber: json["phoneNumber"]??'',
        walletBalance: json["walletBalance"]??0,
        venlyPin: json["venlyPin"]??'',
        alpyneUserId: json["alpyneUserId"]??'',
        email: json["email"]??'',
         governmentId: json["governmentId"]??'',
    );

    Map<String, dynamic> toJson() => {
        "userId": userId,
        "lastName": lastName,
        "address": address,
        "dateOfBirth": dateOfBirth,
        "profileImage": profileImage,
        "termsAndConditionsAccepted": termsAndConditionsAccepted,
        "title": title,
        "bankDetails": bankDetails,
        "firstName": firstName,
        "advisor": advisor?.toJson(),
         
        "alchemyWebhook": alchemyWebhook,
        "phoneNumber": phoneNumber,
        "walletBalance": walletBalance,
        "venlyPin": venlyPin,
        "alpyneUserId": alpyneUserId,
        "email": email,
         
        "governmentId": governmentId,
    };
}

class AdvisorIssueUSDT {
    String? firstName;
    String? lastName;
    String? id;
    String? profileImage;
    String? title;
    String? username;

    AdvisorIssueUSDT({
         this.firstName,
         this.lastName,
         this.id,
         this.profileImage,
         this.title,
         this.username,
    });

    factory AdvisorIssueUSDT.fromJson(Map<String, dynamic> json) => AdvisorIssueUSDT(
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
   