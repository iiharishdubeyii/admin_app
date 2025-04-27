import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../models/advisor_commision_page_dto.dart';
import '../../../providers/gc_admin_provider.dart';
import 'advisor_commision_popup.dart'; 

class AdvisorCommissionCardDetails extends StatefulWidget {
  

  const AdvisorCommissionCardDetails({
    Key? key, 

  }) : super(key: key);

  @override
  _AdvisorCommissionCardDetailsState createState() =>
      _AdvisorCommissionCardDetailsState();
}

class _AdvisorCommissionCardDetailsState
    extends State<AdvisorCommissionCardDetails> {
  String status = "New";

late GcAdminProvider gcAdminProvider;

@override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    gcAdminProvider =Provider.of<GcAdminProvider>(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:   Text('Advisor Commission  ${gcAdminProvider.selectedAdvisorPageDto!.transactionId}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Right Query Label
            Align(
              alignment: Alignment.topRight,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: const Text(
                  'Advisor Commission',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Card Details (7 Children)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                     "${gcAdminProvider.selectedAdvisorPageDto!.dateTime.split(" ").first}",
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold,color: Colors.red),
                  ),
                  SizedBox(width: 16,),
                   Text(
                     "${gcAdminProvider.selectedAdvisorPageDto!.dateTime.split(" ").last}",
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  
                ],
              ),
                  const Divider(),
                  Text(
                    gcAdminProvider.selectedAdvisorPageDto!.advisorName,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    gcAdminProvider.selectedAdvisorPageDto!.advisorPhoneNumber,
                    style:
                        const TextStyle(fontSize: 16, color: Colors.blueAccent),
                  ),
                   Text(
                    "Customer name : ${gcAdminProvider.selectedAdvisorPageDto!.transactionCustName}",
                    style:
                        const TextStyle(fontSize: 16, color: Colors.blueAccent),
                  ),
                     Text(
                    "Basket Name : ${gcAdminProvider.selectedAdvisorPageDto!.basketName}",
                    style:
                        const TextStyle(fontSize: 16, color: Colors.blueAccent),
                  ),
                   Text(
                    "Amount Invested : ${gcAdminProvider.selectedAdvisorPageDto!.amountInvested}",
                    style:
                        const TextStyle(fontSize: 16, color: Colors.blueAccent),
                  ),
                   Text(
                    "Commission Recevied : ${gcAdminProvider.selectedAdvisorPageDto!.commissionAmountReceived}",
                    style:
                        const TextStyle(fontSize: 16, color: Colors.blueAccent),
                  ),
                   Text(
                    "percentage: ${gcAdminProvider.selectedAdvisorPageDto!.percentageCommission} %",
                    style:
                        const TextStyle(fontSize: 16, color: Colors.blueAccent),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  bool? selectedReason = await showDialog<bool>(
                    context: context,
                    builder: (context) => DynamicPopupDialog(title: "No Additional Commission",),
                  );

                  if (selectedReason != null && selectedReason) {
                    gcAdminProvider.updateAdvisorCommisionStatusByOrderId(gcAdminProvider.selectedAdvisorPageDto!.transactionId, AdvisorCommisionPageDtoEnum.processed.name);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                          content: Text('Processed')),
                    );
                  }
                },
                child: const Text('No Additional Commissions'),
              ),
            ),
          const  SizedBox(height: 8,),
              SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  bool? selectedReason = await showDialog<bool>(
                    context: context,
                    builder: (context) => DynamicPopupDialog(title: "Move To Check",),
                  );

                  if (selectedReason != null && selectedReason) {
                    gcAdminProvider.updateAdvisorCommisionStatusByOrderId(gcAdminProvider.selectedAdvisorPageDto!.transactionId, AdvisorCommisionPageDtoEnum.toCheck.name);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                          content: Text('Moved to Check')),
                    );
                  }
                },
                child: const Text('Move To Check'),
              ),
            ),
            const  SizedBox(height: 8,),
              SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                showDialog(
                context: context,
                builder: (context) => AddCommissionPopup(),
              );
                },
                child: const Text('Add Commission'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
