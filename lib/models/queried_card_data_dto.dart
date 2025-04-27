enum TicketStatus { all, queried, solved, inProgress }

extension TicketStatusExtension on TicketStatus {
  String get name {
    switch (this) {
      case TicketStatus.all:
        return "All";
      case TicketStatus.queried:
        return "Queried";
      case TicketStatus.solved:
        return "Solved";
      case TicketStatus.inProgress:
        return "In Progress";
    }
  }
}
class QueryCardDataDto {
  String queryId;
   String dateTime;
   String name;
   String phoneNumber;
   String reason;
   String message;
   TicketStatus status;
   String advisorName;
   String advisorPhoneNumber;

  QueryCardDataDto({
    this.queryId='',
     this.dateTime ='',
     this.name ='',
     this.phoneNumber ='',
     this.reason ='',
     this.message ='',
     this.status = TicketStatus.queried,
     this.advisorName ='',
     this.advisorPhoneNumber ='',
  });
}
