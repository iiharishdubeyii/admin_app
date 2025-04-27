import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/gc_admin_provider.dart';
import 'issueUSDT_popup.dart';
 

class IssueUsdtCardDetails extends StatefulWidget {
 
  
  

  const IssueUsdtCardDetails({
    Key? key,
   
    
  }) : super(key: key);

  @override
  _IssueUsdtCardDetailsState createState() => _IssueUsdtCardDetailsState();
}

class _IssueUsdtCardDetailsState extends State<IssueUsdtCardDetails> {
//    late GcAdminProvider gcAdminProvider;
//   String status = "New";

// @override
//   void didChangeDependencies() {
//     gcAdminProvider =Provider.of<GcAdminProvider>(context);
//     super.didChangeDependencies();
//   }
  @override
  Widget build(BuildContext context) {
    
    return Consumer<GcAdminProvider>(

      builder: (context, gcAdminProvider, child) {
        print(gcAdminProvider.selectedIssueUsdt!.toJson());
        return Scaffold(
          appBar: AppBar(
            title: const Text('Issue USDT'),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top Right Query Label
               
                Text(
                  'Name: ${gcAdminProvider.selectedIssueUsdt!.name}',
                  style: const TextStyle(fontSize: 16),
                ),
                   const SizedBox(height: 8), 
                Text(
                  'Mobile: ${gcAdminProvider.selectedIssueUsdt!.number}',
                  style: const TextStyle(fontSize: 16),
                ),
                   const SizedBox(height: 8), 
                  Text(
                  'Email: ${gcAdminProvider.selectedIssueUsdt!.email}',
                  style: const TextStyle(fontSize: 16),
                ),
                   const SizedBox(height: 8), 
                 Text(
                  'Advisor: ${gcAdminProvider.selectedIssueUsdt!.advisorName}',
                  style: const TextStyle(fontSize: 16),
                ),
                   const SizedBox(height: 8), 
                Text(
                  'Balance: ${gcAdminProvider.selectedIssueUsdt!.walletBalance}',
                  style: const TextStyle(fontSize: 16),
                ),
                  
                // Text(
                //   'Mob. No.: ${widget.advisorPhoneNumber}',
                //   style: const TextStyle(fontSize: 16, color: Colors.blueAccent),
                // ),
                const SizedBox(height: 8),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
          
                          onPressed: () async {
                            final selectedReason = await showDialog<String>(
                              context: context,
                              builder: (context) => IssueUSDTDialog(),
                            );
                            gcAdminProvider.setSelectedIssueUsdtAmountTobeAdd(selectedReason?? "0");
                             gcAdminProvider.updateUsdtIssued( );
                            if (selectedReason != null) {
                              // ScaffoldMessenger.of(context).showSnackBar(
                              //   SnackBar(
                              //       content:
                              //           Text('Selected Reason: $selectedReason')),
                              // );
                            }
                          },
                          child: const Text('Issue USD'),
                        ),
        ),
                
              ],
            ),
          ),
        );
      }
    );
  }
}
