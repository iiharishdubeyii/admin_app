



class UserTransactionDto {
    Transaction transaction;
    String tdocId;
    String userDocId;
    User user;

    UserTransactionDto({
        required this.transaction,
        required this.tdocId,
        required this.userDocId,
        required this.user,
    });

    factory UserTransactionDto.fromJson(Map<String, dynamic> json) => UserTransactionDto(
        transaction: Transaction.fromJson(json["transaction"]),
        user: User.fromJson(json["user"]),
        tdocId:  json["tdocId"],
         userDocId:  json["udocId"],
    );

    Map<String, dynamic> toJson() => {
        "transaction": transaction.toJson(),
        "user": user.toJson(),
        "tdocId":tdocId,
        "udocId":userDocId,
    };
}

class Transaction {
    String? transactionType;
   String? transactionHash;
    String? createdAt;
    String? chain;
    TransactionDetails? transactionDetails;
    num? amount;
    String? walletAddressOrAccountNumber;
    num? cryptoAmount;
    String? provider;
    String? orderId;
    String?  userId;
    String? status;

    Transaction({
         this.transactionType,
         this.transactionHash,
         this.createdAt,
         this.chain,
         this.transactionDetails,
         this.amount,
         this.walletAddressOrAccountNumber,
         this.cryptoAmount,
         this.provider,
         this.orderId,
         this.userId,
         this.status,
    });

    factory Transaction.fromJson(Map<String, dynamic> json) => Transaction(
        transactionType: json["transactionType"]??'',
        transactionHash:json['transactionHash']??'',
        createdAt: json["createdAt"],
        chain: json["chain"],
        transactionDetails:json["transactionDetails"]==null?null: TransactionDetails.fromJson(json["transactionDetails"]),
        amount: json["amount"]??0,
        walletAddressOrAccountNumber: json["walletAddressOrAccountNumber"]??'',
        cryptoAmount: json["cryptoAmount"],
        provider:  json["provider"]??'',
        orderId: json["orderId"]??'',
        userId: json["userId"]??'',
        status: json["status"]??'',
    );

    Map<String, dynamic> toJson() => {
        "transactionType": transactionType,
        "transactionHash":transactionHash,
        "createdAt": createdAt,
        "chain":chain,
        "transactionDetails":transactionDetails==null ?null: transactionDetails!.toJson(),
        "amount": amount,
        "walletAddressOrAccountNumber": walletAddressOrAccountNumber,
        "cryptoAmount": cryptoAmount,
        "provider": provider,
        "orderId": orderId,
        "userId": userId,
        "status": status,
    };
}


class TransactionDetails {
    num? gasFee;
    num? onRampFee;
    num? gatewayFee;
    String? provider;
    // String? raw;
    String? merchantRecognitionId;
    num? clientFee;
    String? coinCode;
    String? transactionHash;
    // String? referenceId;
    String? network;

    TransactionDetails({
         this.gasFee,
         this.onRampFee,
         this.gatewayFee,
         this.provider,
        //  this.raw,
         this.merchantRecognitionId,
         this.clientFee,
         this.coinCode,
         this.transactionHash,
        //  this.referenceId,
         this.network,
    });

    factory TransactionDetails.fromJson(Map<String, dynamic> json) => TransactionDetails(
        gasFee: json["gasFee"]??0,
        onRampFee: json["onRampFee"]??0,
        gatewayFee: json["gatewayFee"]??0,
        provider:  json["provider"]??'',
        // raw: json["raw"]??'',
        merchantRecognitionId: json["merchantRecognitionId"]??'',
        clientFee: json["clientFee"]??0,
        coinCode: json["coinCode"]??'',
        transactionHash: json["transactionHash"]??'',
        // referenceId: json["referenceId"]??'',
        network:json["network"]??'',
    );

    Map<String, dynamic> toJson() => {
        "gasFee": gasFee,
        "onRampFee": onRampFee,
        "gatewayFee": gatewayFee,
        "provider": provider,
        // "raw": raw,
        "merchantRecognitionId": merchantRecognitionId,
        "clientFee": clientFee,
        "coinCode": coinCode,
        "transactionHash": transactionHash,
        // "referenceId": referenceId,
        "network": network,
    };
}
 
class User {
    String? lastName;
    dynamic address;
    String? dateOfBirth;
    String? profileImage;
    bool? termsAndConditionsAccepted;
    String? title;
    dynamic bankDetails;
    String? firstName;
    Advisor? advisor;
    
    bool? alchemyWebhook;
    String? phoneNumber;
    dynamic walletBalance;
    String? venlyPin;
    dynamic alpyneUserId;
    String? email;
 
    dynamic governmentId;

    User({
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

    factory User.fromJson(Map<String, dynamic> json) => User(
        lastName: json["lastName"]??''!,
        address: json["address"]??'',
        dateOfBirth: json["dateOfBirth"]??'',
        profileImage: json["profileImage"]??'',
        termsAndConditionsAccepted: json["termsAndConditionsAccepted"]??false,
        title: json["title"]??''!,
        bankDetails: json["bankDetails"]??'',
        firstName: json["firstName"]??'',
        advisor: json["advisor"] == null ? null : Advisor.fromJson(json["advisor"]),
        
        alchemyWebhook: json["alchemyWebhook"]??false,
        phoneNumber: json["phoneNumber"]??'',
        walletBalance: json["walletBalance"],
        venlyPin: json["venlyPin"]??'',
        alpyneUserId: json["alpyneUserId"]??'',
        email: json["email"]??'',
         governmentId: json["governmentId"]??'',
    );

    Map<String, dynamic> toJson() => {
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

class Advisor {
    String? firstName;
    String? lastName;
    String? id;
    String? profileImage;
    String? title;
    String? username;

    Advisor({
         this.firstName,
         this.lastName,
         this.id,
         this.profileImage,
         this.title,
         this.username,
    });

    factory Advisor.fromJson(Map<String, dynamic> json) => Advisor(
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
   