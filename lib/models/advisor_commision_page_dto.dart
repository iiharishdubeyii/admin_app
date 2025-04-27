enum AdvisorCommisionPageDtoEnum { newQ, processed, toCheck }

class AdvisorCommisionPageDto {
  String id;
  String transactionId;
   String dateTime;
   String transactionCustName;
   String phoneNumber;
   String commissionAmountReceived; 
   String amountInvested; 
   String percentageCommission;
   String basketName;
   AdvisorCommisionPageDtoEnum transactionStatus;
   String advisorName;
   String advisorPhoneNumber; 

  AdvisorCommisionPageDto({ 
    this.id ='',
    this.transactionId ='',
    this.dateTime ='',
     this.transactionCustName ='',
     this.percentageCommission ='',
     this.phoneNumber ='',
     this.amountInvested ='',
     this.commissionAmountReceived ='',
     this.basketName ='',
     this.transactionStatus = AdvisorCommisionPageDtoEnum.newQ,
     this.advisorName ='',
     this.advisorPhoneNumber ='',});


  // AdvisorCommisionPageDto.fromJson(
  //   Map<String, dynamic> json,
  // )   : dateTime = json['firstName'],
  //       id = json['userId'],

  //       transactionId = json['transactionId'],
  //       transactionCustName = json['lastName'],
  //       phoneNumber = json['title'],
  //       commissionAmountReceived = json['profileImage'] ,
  //       amountInvested = json['id'],
  //       basketName = json['username'],
  //       status = json['status'],
  //       advisorName = json['advisorName'],
  //       advisorPhoneNumber = json['advisorPhoneNumber'];
        

  // Map<String, dynamic> toJson() => {
  //   'userId': id,
  //   'transactionId': transactionId,
  //   'dateTime': dateTime,
  //   'transactionCustName': transactionCustName,
  //   'phoneNumber': phoneNumber,
  //   'commissionAmountReceived': commissionAmountReceived,
  //   'amountInvested': amountInvested,
  //   'basketName': basketName,
  //   'status': status,
  //   'advisorName': advisorName,
  //   'advisorPhoneNumber': advisorPhoneNumber,

  //     };
}
