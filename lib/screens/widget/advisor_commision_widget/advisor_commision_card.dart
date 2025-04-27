import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; 
import '../../../models/advisor_commision_page_dto.dart';
import '../../../providers/gc_admin_provider.dart';
import 'advisor_commision_details.dart'; 
 

class AdvisorCommssionCard extends StatefulWidget {
  final String dateTime;
  final String advisorName;
  final String advisorPhoneNumber; 

    final String amountInvested;
  final String basketName;
  final String commissionAmountReceived; 
  
    final String id;
  final String transactionStatus;
  final String transactionId;
  final String transactionCustName; 
    final String percentageCommission; 
  

  const AdvisorCommssionCard({
    Key? key,
    required this.dateTime,
    required this.advisorName,
    required this.advisorPhoneNumber,
    required this.amountInvested,
    required this.basketName,
    required this.commissionAmountReceived,
    required this.id,
    required this.transactionStatus,
    required this.transactionId,
    required this.transactionCustName,
    required this.percentageCommission

  }) : super(key: key);

  @override
  State<AdvisorCommssionCard> createState() => _AdvisorCommssionCardState();
}

class _AdvisorCommssionCardState extends State<AdvisorCommssionCard> {
late GcAdminProvider gcAdminProvider;

@override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    gcAdminProvider =Provider.of<GcAdminProvider>(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    // Formatting date and time
   

    return GestureDetector(
      onTap: () {
        gcAdminProvider.setSelectedAdvisorCommisionData(
          AdvisorCommisionPageDto(dateTime: widget.dateTime,
          advisorName: widget.advisorName,
          advisorPhoneNumber: widget.advisorPhoneNumber,
          amountInvested: widget.amountInvested,
          basketName: widget.basketName,
          commissionAmountReceived: widget.commissionAmountReceived,
          id: widget.id,
          transactionStatus: widget.transactionStatus=="new" ? AdvisorCommisionPageDtoEnum.newQ : widget.transactionStatus=="processed" ? AdvisorCommisionPageDtoEnum.processed : AdvisorCommisionPageDtoEnum.toCheck,
          transactionId: widget.transactionId,
          transactionCustName: widget.transactionCustName,
          percentageCommission: widget.percentageCommission
          )
        );
         Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AdvisorCommissionCardDetails(
             

             
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
                     "${widget.dateTime.split(" ").first}",
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold,color: Colors.red),
                  ),
                  SizedBox(width: 16,),
                   Text(
                     "${widget.dateTime.split(" ").last}",
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  
                ],
              ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     Text(
              //        "25 Oct 2025",
              //       style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              //     ),
              //     Text(
              //       "8:00 AM",
              //       style: const TextStyle(fontSize: 16, color: Colors.grey),
              //     ),
              //   ],
              // ),
              const Divider(), // Second Child: Divider Line
              // Third Child: Name
              Text(
                widget.advisorName,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              // Fourth Child: Phone Number
              
              // Sixth Child: Message Label
                Text(
                'Advisor Commission : ${widget.commissionAmountReceived}',
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
