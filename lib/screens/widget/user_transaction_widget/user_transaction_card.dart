import 'package:flutter/material.dart';
import 'package:gc_admin_app/models/transaction_status.dart';
import 'package:gc_admin_app/screens/widget/user_transaction_widget/user_transaction_card_details.dart';
import 'package:provider/provider.dart';

import '../../../providers/gc_admin_provider.dart';
 
class UserTransactionCard extends StatefulWidget {
  TransactionStatus transactionStatus;
  // final String dateTime;
  // final String name;
  // final String phoneNumber;
  // final String usdt;
  //  final String advisorName;
  // final String advisorPhoneNumber;
  // final String amount;
  //  final String chain; 
  //  final String txnHash;
  //  final String orderId;
   

    UserTransactionCard({
    Key? key,
    required this.transactionStatus,
    // required this.dateTime,
    // required this.name,
    // required this.phoneNumber,
    // required this.usdt, 
    // required this.advisorName,
    // required this.advisorPhoneNumber,
    // required this.amount,
    // required this.chain, 
    //           required this.txnHash,
    //                required this.orderId,

  }) : super(key: key);

  @override
  State<UserTransactionCard> createState() => _UserTransactionCardState();
}

class _UserTransactionCardState extends State<UserTransactionCard> {

    late GcAdminProvider gcAdminProvider;
  String status = "New";

@override
  void didChangeDependencies() {
    gcAdminProvider =Provider.of<GcAdminProvider>(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    // Formatting date and time
   

    return GestureDetector(
      onTap: () {
        gcAdminProvider.setSelectedUserTransactionData(widget.transactionStatus);
         Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => UserTransactionDetailsPage(
              // dateTime: widget.dateTime,
              // name: widget.name,
              // phoneNumber: widget.phoneNumber,
              // usdt: widget.usdt, 
              // advisorName: widget.advisorName,
              // advisorPhoneNumber:widget.advisorPhoneNumber,
              // amount:widget.amount,
              // chain:widget.chain ,
              // txnHash:widget.txnHash,
              // oredrId: widget.orderId,
            ),
          ),
        );
      },
      child: Card(
        elevation: 4,
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [ 
               Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                     "${widget.transactionStatus.dateTime.split(" ").first}",
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold,color: Colors.red),
                  ),
                  SizedBox(width: 16,),
                   Text(
                     "${widget.transactionStatus.dateTime.split(" ").last}",
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  
                ],
              ),
              const Divider(),  
              Text(
                widget.transactionStatus.userName,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ), 
              Text(
                widget.transactionStatus.phoneNumber,
                style: const TextStyle(fontSize: 16, color: Colors.blueAccent),
              ), 
              Text(
                'USDT: ${widget.transactionStatus.amount}',
                style: const TextStyle(fontSize: 16),
              ),
             
            ],
          ),
        ),
      ),
    );
  }
}
