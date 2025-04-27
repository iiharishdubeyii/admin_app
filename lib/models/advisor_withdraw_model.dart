enum AdvisorWithdrawEnum { processing, inProgress, completed,rejected }
  
extension AdvisorWithdrawExtension on AdvisorWithdrawEnum {
  String get name {
    switch (this) {
      case AdvisorWithdrawEnum.processing:
        return "Processing";
      case AdvisorWithdrawEnum.inProgress:
        return "InProcess";
      case AdvisorWithdrawEnum.completed:
        return "Completed";
      case AdvisorWithdrawEnum.rejected:
        return "Rejected";
    }
  }
}
class AdvisorWithdrawDto {
  String advisorTrId;
   String dateTime;
   String name;
   String phoneNumber;
   String withdrawl;
   String totalNalance;
   AdvisorWithdrawEnum status;
   String advisorName;
   String advisorPhoneNumber;

  AdvisorWithdrawDto({
    this.advisorTrId = '',
     this.dateTime ='',
     this.name ='',
     this.phoneNumber ='',
     this.withdrawl ='',
     this.totalNalance ='',
     this.status = AdvisorWithdrawEnum.processing,
     this.advisorName ='',
     this.advisorPhoneNumber ='',
  });
}
