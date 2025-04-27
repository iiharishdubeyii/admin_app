import 'package:flutter/material.dart';
import 'package:gc_admin_app/providers/gc_admin_provider.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'advisor_withdraw_popup.dart';

class AdvisorWithdrawCardDetails extends StatefulWidget {
 

  const AdvisorWithdrawCardDetails({
    Key? key, 
  }) : super(key: key);

  @override
  _AdvisorWithdrawCardDetailsState createState() =>
      _AdvisorWithdrawCardDetailsState();
}

class _AdvisorWithdrawCardDetailsState
    extends State<AdvisorWithdrawCardDetails> {
  String status = "New";
    late GcAdminProvider gcAdminProvider;
 

@override
  void didChangeDependencies() {
    gcAdminProvider =Provider.of<GcAdminProvider>(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Advisor Withdraw'),
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
                  'Advisor Withdraw',
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
                     "${gcAdminProvider.selectedAdvisorWithdraw!.dateTime.split(" ").first}",
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold,color: Colors.red),
                  ),
                  SizedBox(width: 16,),
                   Text(
                     "${gcAdminProvider.selectedAdvisorWithdraw!.dateTime.split(" ").last}",
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  
                ],
              ),
                  const Divider(),
                  Text(
                    gcAdminProvider.selectedAdvisorWithdraw!.name,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                     gcAdminProvider.selectedAdvisorWithdraw!.phoneNumber,
                    style:
                        const TextStyle(fontSize: 16, color: Colors.blueAccent),
                  ),
                    Text(
                    'Withdrawl: ${ gcAdminProvider.selectedAdvisorWithdraw!.withdrawl}',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                     Text(
                    'Total Balance: ${ gcAdminProvider.selectedAdvisorWithdraw!.totalNalance}',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                      Text(
                    'Status: ${ gcAdminProvider.selectedAdvisorWithdraw!.status.name}',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  final selectedReason = await showDialog<String>(
                    context: context,
                    builder: (context) => AdvisorWithdrawPopup(),
                  );
gcAdminProvider.updateAdvisorStatusByOrderId(  "${selectedReason}");
                  // if (selectedReason != null) {
                  //   ScaffoldMessenger.of(context).showSnackBar(
                  //     SnackBar(
                  //         content: Text('Selected Reason: $selectedReason')),
                  //   );
                  // }
                },
                child: const Text('Update Status'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
