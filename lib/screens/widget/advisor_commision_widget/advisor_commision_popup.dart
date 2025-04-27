import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gc_admin_app/providers/gc_admin_provider.dart';
import 'package:provider/provider.dart';

class DynamicPopupDialog extends StatelessWidget {
  final String title;

  const DynamicPopupDialog({required this.title});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12), // Rounded corners
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop(true); // Return true for "Yes"
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    backgroundColor: Colors.blue,
                  ),
                  child: Text('Yes',style: TextStyle(color: Colors.white),),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop(false); // Return false for "No"
                  },
                  style: ElevatedButton.styleFrom(
                       shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    backgroundColor: Colors.white,
                  ),
                  child: Text('No',style: TextStyle(color: Colors.blue),),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}


class AdvisorCommissionPopup extends StatefulWidget {
  const AdvisorCommissionPopup({super.key});

  @override
  State<AdvisorCommissionPopup> createState() => _AdvisorCommissionPopupState();
}

class _AdvisorCommissionPopupState extends State<AdvisorCommissionPopup> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}


class ConfirmationPopup extends StatelessWidget {
  final double oldCommission;
  final double newCommission;
  final VoidCallback onEdit;
  final VoidCallback onConfirm;

  const ConfirmationPopup({
    required this.oldCommission,
    required this.newCommission,
    required this.onEdit,
    required this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Confirm Changes',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text('Old Commission: \$${oldCommission.toStringAsFixed(2)}'),
            SizedBox(height: 8),
            Text('New Total Commission: \$${newCommission.toStringAsFixed(2)}'),
            SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: onEdit,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text('Edit'),
                ),
                ElevatedButton(
                  onPressed: onConfirm,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text('Confirm',style: TextStyle(color: Colors.white),),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
} 
class AddCommissionPopup extends StatefulWidget {
  @override
  _AddCommissionPopupState createState() => _AddCommissionPopupState();
}

class _AddCommissionPopupState extends State<AddCommissionPopup> {

late GcAdminProvider gcAdminProvider;

@override
  void didChangeDependencies() {
   gcAdminProvider =Provider.of<GcAdminProvider>(context);
    super.didChangeDependencies();
  }

  final TextEditingController _percentageController = TextEditingController(text: '0');
  // double totalAmount = 10000.0; // Sample total amount
  // double commissionReceived = 2000.0; // Sample commission received
  double newTotalCommission = 0.0;

  void _calculateNewCommission() {
    if(_percentageController.text.isEmpty) {
      newTotalCommission = 0.0;
      setState(() {});
      return;
    }
newTotalCommission =double.parse(gcAdminProvider.selectedAdvisorPageDto!.commissionAmountReceived) + (double.parse(gcAdminProvider.selectedAdvisorPageDto!.amountInvested) * double.parse(_percentageController.text) / 100);
    setState(() {});
    
  }

  void _showConfirmationPopup(double newCommission,double oldCommission) {
    showDialog(
      context: context,
      builder: (context) => ConfirmationPopup(
        oldCommission: oldCommission,
        newCommission: newCommission,
        onEdit: () {
          Navigator.of(context).pop(); // Close confirmation popup
        },
        onConfirm: () {
          Navigator.of(context).pop(); // Close confirmation popup
          Navigator.of(context).pop(); // Close main popup
          gcAdminProvider.createNewEntryOfAdvisorTransactionWithPreviousTransaction(gcAdminProvider.selectedAdvisorPageDto!.transactionId, newCommission-oldCommission, (double.parse(_percentageController.text)+double.parse(gcAdminProvider.selectedAdvisorPageDto!.percentageCommission)));
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Commission Updated Successfully!')),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Add Commission',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text('Total Amount: \$${gcAdminProvider.selectedAdvisorPageDto!.amountInvested}'),
            SizedBox(height: 8),
            Text('Commission Received: \$${gcAdminProvider.selectedAdvisorPageDto!.commissionAmountReceived}'),
            SizedBox(height: 8),
            Text('Basket: ${gcAdminProvider.selectedAdvisorPageDto!.basketName}'), // Replace with actual basket info
            SizedBox(height: 16),
            TextField(
              controller: _percentageController,
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
              ],
              decoration: InputDecoration(
                labelText: 'Enter Percentage',
                suffixText: '%',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onChanged: (_) {
                  _calculateNewCommission();
             
                 },
            ),
            SizedBox(height: 16),
            Text(
              'New Total Commission: \$${newTotalCommission}',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 24),
            Center(
              child: ElevatedButton(
                onPressed: () => _showConfirmationPopup(
                  double.parse(gcAdminProvider.selectedAdvisorPageDto!.commissionAmountReceived) + 
                  (double.parse(gcAdminProvider.selectedAdvisorPageDto!.amountInvested) * 
                  double.parse(_percentageController.text) / 100),
                  double.parse(gcAdminProvider.selectedAdvisorPageDto!.commissionAmountReceived),
                ),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text('Confirm'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
