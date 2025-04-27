import 'package:flutter/material.dart';
import 'package:gc_admin_app/models/advisor_withdraw_model.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../providers/gc_admin_provider.dart';
import 'advisor_withdraw_card_details.dart';
 

class AdvisorWithdrawCard extends StatefulWidget {
AdvisorWithdrawDto advisorWithdrawDto;

    AdvisorWithdrawCard({
    Key? key,
    required this.advisorWithdrawDto
  }) : super(key: key);

  @override
  State<AdvisorWithdrawCard> createState() => _AdvisorWithdrawCardState();
}

class _AdvisorWithdrawCardState extends State<AdvisorWithdrawCard> {

  late GcAdminProvider ticketProvider;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    ticketProvider = Provider.of<GcAdminProvider>(context);
   
  }
  @override
  Widget build(BuildContext context) {
    // Formatting date and time
   

    return GestureDetector(
      onTap: () {
ticketProvider.setSelectedAdvisorWithdrawDto(widget.advisorWithdrawDto);
         Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AdvisorWithdrawCardDetails(
              // dateTime: dateTime,
              // name: name,
              // phoneNumber: "phoneNumber",
             
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
                     "${widget.advisorWithdrawDto.dateTime.split(" ").first}",
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold,color: Colors.red),
                  ),
                  SizedBox(width: 16,),
                   Text(
                     "${widget.advisorWithdrawDto.dateTime.split(" ").last}",
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  
                ],
              ),
              const Divider(), // Second Child: Divider Line
              // Third Child: Name
              Text(
                widget.advisorWithdrawDto.name,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              // Fourth Child: Phone Number
              
              // Sixth Child: Message Label
                Text(
                'USDT: ${widget.advisorWithdrawDto.withdrawl}',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              // Seventh Child: Message Content
              
            ],
          ),
        ),
      ),
    );
  }
}
