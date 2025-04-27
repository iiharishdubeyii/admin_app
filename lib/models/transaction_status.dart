enum TransactionStatusEnum { processing, completed, rejected }

extension TicketStatusExtension on TransactionStatusEnum {
  String get name {
    switch (this) {
      case TransactionStatusEnum.processing:
        return "Processing";
      case TransactionStatusEnum.completed:
        return "Completed";
      case TransactionStatusEnum.rejected:
        return "Rejected";
    }
  }
}

class TransactionStatus {
  String dateTime;
  String userName;
  String phoneNumber;
  String advisorName;
  String chain;
  String txnHash;
  String amount;
  String amountTobeAdded;
  String walletBalance;
  String orderId;
  String uid;
  TransactionStatusEnum status;

  TransactionStatus({
     this.dateTime='',
     this.userName='',
     this.phoneNumber='',
     this.advisorName='',
     this.chain='',
     this.txnHash='',
     this.amountTobeAdded='',
     this.amount='',
     this.orderId='',
     this.walletBalance='',
     this.uid='',
     this.status=TransactionStatusEnum.completed,
  });
}
