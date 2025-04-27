import 'package:flutter/material.dart';
import 'package:gc_admin_app/providers/gc_admin_provider.dart';
import 'package:gc_admin_app/screens/widget/user_transaction_widget/user_transaction_card.dart';
import 'package:provider/provider.dart';

import '../../models/transaction_status.dart';
import '../widget/query_widget/queries_card.dart';

// class UserTransactionDetailsScreenState extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return DefaultTabController(
//       length: 3,
//       child: Scaffold(
//         appBar: AppBar(
//           title: Text('Task Manager'),
//           bottom: TabBar(
//             tabs: [
//               Tab(text: 'Processing'),
//               Tab(text: 'Completed'),
//               Tab(text: 'Rejected'),
//             ],
//           ),
//         ),
//         body: TabBarView(
//           children: [
//             TaskListScreen(taskType: TransactionStatusEnum.processing),
//             TaskListScreen(taskType: TransactionStatusEnum.completed),
//             TaskListScreen(taskType: TransactionStatusEnum.rejected),
//           ],
//         ),
//       ),
//     );
//   }
// }
 
// class TaskListScreen extends StatelessWidget {
//   final TransactionStatusEnum taskType;

//   TaskListScreen({required this.taskType});

//   @override
//   Widget build(BuildContext context) {
//     final taskProvider = Provider.of<GcAdminProvider>(context);
//     List<TransactionStatus> tasks;

//     // Get tasks based on status
//     if (taskType == TransactionStatusEnum.processing) {
//       tasks = taskProvider.processingTasks;
//     } else if (taskType == TransactionStatusEnum.completed) {
//       tasks = taskProvider.completedTransactionStatus;
//     } else {
//       tasks = taskProvider.rejectedTransactionStatus;
//     }

//     return tasks.isEmpty
//         ? Center(child: Text('No tasks found.'))
//         : ListView.builder(
//             itemCount: tasks.length,
//             itemBuilder: (ctx, index) {
//               final task = tasks[index];
//               return ListTile(
//                 title: Text(task.title),
//                 leading: CircleAvatar(
//                   child: Text(task.id),
//                 ),
//               );
//             },
//           );
//   }
// } 
class UserTransactionDetailsScreenState extends StatefulWidget {
  const UserTransactionDetailsScreenState({super.key});

  @override
  State<UserTransactionDetailsScreenState> createState() => _UserTransactionDetailsScreenStateState();
}

class _UserTransactionDetailsScreenStateState extends State<UserTransactionDetailsScreenState> {
  bool isSearching = false;
  TextEditingController searchController = TextEditingController();

  List<TransactionStatus> tickets = <TransactionStatus>[]; // Full list of tickets
  List<TransactionStatus> filteredTickets =
      <TransactionStatus>[]; // Search results

  late GcAdminProvider ticketProvider;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    ticketProvider = Provider.of<GcAdminProvider>(context);
    tickets = [...ticketProvider.processingTasks(),...ticketProvider.completedTransactionStatus(),...ticketProvider.rejectedTransactionStatus(),];
    filteredTickets = tickets;
  }

  void filterSearchResults(String query) {
    setState(() {
      if (query.isEmpty) {
        filteredTickets = tickets; // Reset to all tickets if search is cleared
      } else {
        filteredTickets = tickets
            .where((ticket) =>
                ticket.userName.toLowerCase().contains(query.toLowerCase()) ||
                ticket.phoneNumber
                    .toLowerCase()
                    .contains(query.toLowerCase()) ||
                ticket.advisorName
                    .toLowerCase()
                    .contains(query.toLowerCase()) ||
                ticket.advisorName.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: isSearching
              ? TextField(
                  controller: searchController,
                  autofocus: true,
                  decoration: const InputDecoration(
                    hintText: "Search...",
                    hintStyle: TextStyle(color: Colors.black),
                    border: InputBorder.none,
                  ),
                  style: const TextStyle(color: Colors.black),
                  onChanged: filterSearchResults,
                )
              : const Text("User transaction"),
          actions: [
            IconButton(
              icon: Icon(isSearching ? Icons.close : Icons.search),
              onPressed: () {
                setState(() {
                  isSearching = !isSearching;
                  if (!isSearching) {
                    searchController.clear();
                    filteredTickets = tickets;
                  }
                });
              },
            ),
          ],
          bottom:   TabBar(
            tabs: [
               Tab(text: '${TransactionStatusEnum.processing.name}'),
              Tab(text: '${TransactionStatusEnum.completed.name}'),
              Tab(text: '${TransactionStatusEnum.rejected.name}'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            TicketListScreen(ticketType: '${TransactionStatusEnum.processing.name}', tickets: filteredTickets),
            TicketListScreen(ticketType: '${TransactionStatusEnum.completed.name}', tickets: filteredTickets),
            TicketListScreen(ticketType: '${TransactionStatusEnum.rejected.name}', tickets: filteredTickets), 
          ],
        ),
      ),
    );
  }
}

class TicketListScreen extends StatelessWidget {
  final String ticketType;
  final List<TransactionStatus> tickets;

  const TicketListScreen({
    required this.ticketType,
    required this.tickets,
  });

  @override
  Widget build(BuildContext context) {
    List<TransactionStatus> ticketsToShow;

    // Filter tickets based on status
    if (ticketType == TransactionStatusEnum.processing.name) {
      ticketsToShow = tickets.where((ticket) => ticket.status.name == ticketType).toList();
    } else if (ticketType == TransactionStatusEnum.completed.name) {
      ticketsToShow =
          tickets.where((ticket) => ticket.status.name == ticketType).toList();
    } else if (ticketType == TransactionStatusEnum.rejected.name) {
      ticketsToShow =
          tickets.where((ticket) => ticket.status.name == ticketType).toList();
    } else {
      ticketsToShow = [];
    }

    return ticketsToShow.isEmpty
        ? const Center(child: Text('No tickets found.'))
        : ListView.builder(
            itemCount: ticketsToShow.length,
            itemBuilder: (ctx, index) {
              final ticket = ticketsToShow[index];

              return UserTransactionCard(
                transactionStatus: ticket,
                // dateTime: ticket.dateTime,
                // name: ticket.userName,
                // phoneNumber: ticket.phoneNumber,
                // usdt: ticket.amount,
                // advisorName: ticket.advisorName,
                // advisorPhoneNumber: ticket.phoneNumber,
                // amount: ticket.amount,
                // chain: ticket.chain,
                // txnHash: ticket.txnHash,
                // orderId: ticket.orderId,
                 
              );
            },
          );
  }
}
