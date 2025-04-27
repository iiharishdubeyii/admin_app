import 'package:flutter/material.dart';
import 'package:gc_admin_app/models/issue_usdt_dto.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../providers/gc_admin_provider.dart';
import 'issue_usdt_card_details.dart'; 

class IssueUsdtCardWidget extends StatefulWidget {
 
IssueUsdtDto issueUsdtCard;

    IssueUsdtCardWidget({
    Key? key,
required this.issueUsdtCard,
  
  }) : super(key: key);

  @override
  State<IssueUsdtCardWidget> createState() => _IssueUsdtCardState();
}

class _IssueUsdtCardState extends State<IssueUsdtCardWidget> {
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
        gcAdminProvider.setSelectedIssueUsdtDto(widget.issueUsdtCard);
         Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => IssueUsdtCardDetails(
              
              
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
              // First Child: Row with Date and Time
               Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                     "${widget.issueUsdtCard!.dateTime.split(" ").first}",
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold,color: Colors.red),
                  ),
                  SizedBox(width: 16,),
                   Text(
                     "${widget.issueUsdtCard!.dateTime.split(" ").last}",
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  
                ],
              ),
              const Divider(), // Second Child: Divider Line
              // Third Child: Name
              Text(
                widget.issueUsdtCard.name,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              // Fourth Child: Phone Number
              Text(
                widget.issueUsdtCard.number,
                style: const TextStyle(fontSize: 16, color: Colors.blueAccent),
              ),
                Text(
                "Advisor Name: ${widget.issueUsdtCard.advisorName}",
                style: const TextStyle(fontSize: 16, color: Colors.black),
              ),
             
             
            ],
          ),
        ),
      ),
    );
  }
}
