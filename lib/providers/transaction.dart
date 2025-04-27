import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TransactionProvider extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  List<Map<String, dynamic>> _transactions = [];
  List<Map<String, dynamic>> get transactions => _transactions;

  // Function to fetch all transactions of type "USDT Deposit"
  Future<void> fetchTransactions() async {
    try {
      final querySnapshot = await _firestore
          .collection('transactions')
          .where('provider',
              isEqualTo: 'USDT Deposit') // Filter by "USDT Deposit"
          .orderBy('createdAt', descending: true) // Sort by createdAt
          .get();

      _transactions = await Future.wait(querySnapshot.docs.map((doc) async {
        var userId = doc['userId'];
        var userSnapshot =
            await _firestore.collection('users').doc(userId).get();
        var user = userSnapshot.data();
        return {
          'transaction': doc.data(),
          'user': user,
        };
      }));

      notifyListeners(); // Notify listeners when data changes
    } catch (e) {
      print('Error fetching transactions: $e');
    }
  }
}


// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'transaction_provider.dart';

// class TransactionListScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Transaction List")),
//       body: ChangeNotifierProvider(
//         create: (_) => TransactionProvider(),
//         child: Consumer<TransactionProvider>(
//           builder: (context, provider, child) {
//             // Fetch transactions when the screen is first loaded
//             if (provider.transactions.isEmpty) {
//               provider.fetchTransactions();
//             }

//             return provider.transactions.isEmpty
//                 ? Center(child: CircularProgressIndicator())
//                 : ListView.builder(
//                     itemCount: provider.transactions.length,
//                     itemBuilder: (context, index) {
//                       var transactionData = provider.transactions[index];
//                       var transaction = transactionData['transaction'];
//                       var user = transactionData['user'];

//                       return ListTile(
//                         title: Text('Transaction at: ${transaction['createdAt']}'),
//                         subtitle: Text('User: ${user['name']}'),
//                         onTap: () {
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                               builder: (context) => TransactionDetailScreen(
//                                 transactionId: transaction['transactionId'],
//                               ),
//                             ),
//                           );
//                         },
//                       );
//                     },
//                   );
//           },
//         ),
//       ),
//     );
//   }
// }


// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// class TransactionDetailScreen extends StatelessWidget {
//   final String transactionId;

//   TransactionDetailScreen({required this.transactionId});

//   @override
//   Widget build(BuildContext context) {
//     final FirebaseFirestore _firestore = FirebaseFirestore.instance;

//     return Scaffold(
//       appBar: AppBar(title: Text("Transaction Details")),
//       body: FutureBuilder<DocumentSnapshot>(
//         future: _firestore.collection('transactions').doc(transactionId).get(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           }

//           if (snapshot.hasError) {
//             return Center(child: Text('Error loading transaction details'));
//           }

//           var transaction = snapshot.data;

//           // Display transaction details
//           return Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text('Transaction ID: ${transaction?['transactionId']}'),
//                 Text('Amount: \\$${transaction?['amount']}'),
//                 Text('Date: ${transaction?['createdAt']}'),
//                 // Add more fields as required
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
