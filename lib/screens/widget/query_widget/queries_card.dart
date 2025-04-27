import 'package:flutter/material.dart';
import 'package:gc_admin_app/models/queried_card_data_dto.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../models/queried_api_dto.dart';
import '../../../providers/gc_admin_provider.dart';
import 'queries_card_details_page.dart';

class QuieryCard extends StatefulWidget {
final QueryCardDataDto queriedDataDto;

  const QuieryCard({
    Key? key,
   required  this.queriedDataDto,
  }) : super(key: key);

  @override
  State<QuieryCard> createState() => _QuieryCardState();
}

class _QuieryCardState extends State<QuieryCard> {
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
        gcAdminProvider.setSelectedQueried( widget.queriedDataDto);
         Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => QueryCardDetailsPage(
              queryCardDataDto: widget.queriedDataDto,
              // dateTime: dateTime,
              // name: name,
              // phoneNumber: phoneNumber,
              // reason: reason,
              // message: message,
              // advisorName: "advisorName",
              // advisorPhoneNumber: "advisorPhoneNumber",
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: [
                   if(widget.queriedDataDto.queryId.isNotEmpty && widget.queriedDataDto.queryId.contains("Not"))
               Text(
                widget.queriedDataDto.queryId,
                style: const TextStyle(fontSize: 18, color: Colors.red,fontWeight: FontWeight.bold),
              ),
                   Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                         "${widget.queriedDataDto.dateTime.split(" ").first}",
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold,color: Colors.blue),
                      ),
                      SizedBox(width: 16,),
                       Text(
                         "${widget.queriedDataDto.dateTime.split(" ").last}",
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      
                    ],
                                 ),
                 ],
               ),
              const Divider(), // Second Child: Divider Line
              // Third Child: Name
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.queriedDataDto.name,
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                   Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: (widget.queriedDataDto.reason.toLowerCase().startsWith('user') && widget.queriedDataDto.reason.toLowerCase().contains('updated'))?Colors.green:(widget.queriedDataDto.reason.toLowerCase().startsWith('advisor') && widget.queriedDataDto.reason.toLowerCase().contains('updated'))?Colors.green:Colors.amber,
                      borderRadius: BorderRadius.circular(5),),
                     child: Text(
                      (widget.queriedDataDto.reason.toLowerCase().startsWith('user') && widget.queriedDataDto.reason.toLowerCase().contains('updated'))?'User Updated':(widget.queriedDataDto.reason.toLowerCase().startsWith('advisor') && widget.queriedDataDto.reason.toLowerCase().contains('updated'))?'Advisor Updated':'Query From Support',
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold,color: Colors.black),
                                       ),
                   ),
                ],
              ),
              // Fourth Child: Phone Number
             

              Text(
                widget.queriedDataDto.phoneNumber,
                style: const TextStyle(fontSize: 16, color: Colors.blueAccent),
              ),
              // Fifth Child: Reason
              Text(
                'Reason: ${widget.queriedDataDto.reason}',
                style: const TextStyle(fontSize: 16),
              ),
              // Sixth Child: Message Label
              const Text(
                'Message:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              // Seventh Child: Message Content
              Text(
                widget.queriedDataDto.message,
                style: const TextStyle(fontSize: 16),
              ),
               
            ],
          ),
        ),
      ),
    );
  }
}
