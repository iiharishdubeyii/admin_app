import 'package:flutter/material.dart';
import 'package:gc_admin_app/providers/gc_admin_provider.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'user_transaction_popup.dart';

class UserTransactionDetailsPage extends StatefulWidget {
  // final String dateTime;
  // final String name;
  // final String phoneNumber;
  // final String usdt;
  // final String chain;
  // final String advisorName;
  // final String advisorPhoneNumber;
  // final String txnHash;
  // final String amount;
  // final String oredrId;

  const UserTransactionDetailsPage({
    Key? key,
    // required this.dateTime,
    // required this.name,
    // required this.phoneNumber,
    // required this.usdt,
    // required this.chain,
    // required this.advisorName,
    // required this.advisorPhoneNumber,
    //  required this.txnHash,
    // required this.amount,
    // required this.oredrId,
  }) : super(key: key);

  @override
  _UserTransactionDetailsPageState createState() =>
      _UserTransactionDetailsPageState();
}

class _UserTransactionDetailsPageState
    extends State<UserTransactionDetailsPage> {
  late GcAdminProvider gcAdminProvider;
  String status = "New";

  @override
  void didChangeDependencies() {
    gcAdminProvider = Provider.of<GcAdminProvider>(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User transaction'),
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
                  'User transaction',
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
                        "${gcAdminProvider.selectedUserTransactionStatus!.dateTime.split(" ").first}",
                        style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.red),
                      ),
                      SizedBox(
                        width: 16,
                      ),
                      Text(
                        "${gcAdminProvider.selectedUserTransactionStatus!.dateTime.split(" ").last}",
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const Divider(),
                  Text(
                    gcAdminProvider.selectedUserTransactionStatus!.userName,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    gcAdminProvider.selectedUserTransactionStatus!.phoneNumber,
                    style:
                        const TextStyle(fontSize: 16, color: Colors.blueAccent),
                  ),
                  Text(
                    'Advisor:',
                    style: const TextStyle(fontSize: 16),
                  ),
                  const Divider(),
                  Text(
                    "Chain: ${gcAdminProvider.selectedUserTransactionStatus!.chain}",
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Transaction: ${gcAdminProvider.selectedUserTransactionStatus!.txnHash}",
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Ammount: ${gcAdminProvider.selectedUserTransactionStatus!.amount}",
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () async {
                      final selectedReason = await showDialog<String>(
                        context: context,
                        builder: (context) => RejectTransactionDialog(),
                      );
                      gcAdminProvider.updateReasonToTransaction(
                         
                          selectedReason);
                      if (selectedReason != null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content:
                                  Text('Selected Reason: $selectedReason')),
                        );
                      }
                    },
                    child: const Text('Reject'),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () async {
                      final selectedReason = await showDialog<String>(
                        context: context,
                        builder: (context) => ExactAmountDialog(),
                      );
gcAdminProvider.setSelectedAmountTobeAdded("$selectedReason");
                      gcAdminProvider.updateTransactionStatusByOrderId(
                          "${gcAdminProvider.selectedUserTransactionStatus!.orderId}",
                          double.parse("${selectedReason}"));
                      if (selectedReason != null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content:
                                  Text(' $selectedReason')),
                        );
                      }
                    },
                    child: const Text('Approve'),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
