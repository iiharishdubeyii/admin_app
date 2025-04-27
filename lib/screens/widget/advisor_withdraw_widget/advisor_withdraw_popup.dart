import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
 
class AdvisorWithdrawPopup extends StatefulWidget {
  @override
  _AdvisorWithdrawPopupState createState() => _AdvisorWithdrawPopupState();
}

class _AdvisorWithdrawPopupState extends State<AdvisorWithdrawPopup> {
  final TextEditingController _amountController = TextEditingController();
 String? _selectedReason; // To store the selected value from dropdown
  final List<String> _reasons = [
    'Proccessing',
    'InProcess',
    'Completed',
    'Rejected',
  ]; // List of dropdown items

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12), // Rounded edges
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Change Status to',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
                  SizedBox(height: 16),
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                labelText: 'Status',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              value: _selectedReason,
              items: _reasons.map((reason) {
                return DropdownMenuItem(
                  value: reason,
                  child: Text(reason),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedReason = value;
                });
              },
            ),
              SizedBox(height: 16), 
            // Row(
            //   children: [
           
            //     Expanded(
            //       child: TextField(
            //         controller: _amountController,
            //         keyboardType: TextInputType.number,
            //         inputFormatters: [
            //           FilteringTextInputFormatter.digitsOnly, // Allow numbers only
            //         ],
            //         decoration: InputDecoration(
            //           labelText: 'Amount',
            //           border: OutlineInputBorder(
            //             borderRadius: BorderRadius.circular(12),
            //           ),
            //         ),
            //       ),
            //     ),
            //     SizedBox(width: 8),
            //     Text(
            //       'USDT',
            //       style: TextStyle(
            //         fontSize: 16,
            //         fontWeight: FontWeight.bold,
            //       ),
            //     ),
            //   ],
            // ),
            SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(_selectedReason);
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text('Change'),
            ),
          ],
        ),
      ),
    );
  }
}
