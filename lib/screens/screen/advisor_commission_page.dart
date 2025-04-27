import 'package:flutter/material.dart';
import 'package:gc_admin_app/models/advisor_commision_page_dto.dart';
import 'package:gc_admin_app/screens/widget/advisor_commision_widget/advisor_commision_card.dart';
import 'package:provider/provider.dart';

import '../../providers/gc_admin_provider.dart';

class AdvisorCommissionPage extends StatefulWidget {
  @override
  State<AdvisorCommissionPage> createState() => _AdvisorCommissionPageState();
}

class _AdvisorCommissionPageState extends State<AdvisorCommissionPage> {
  bool isSearching = false;

  TextEditingController searchController = TextEditingController();

  List<AdvisorCommisionPageDto> tickets = <AdvisorCommisionPageDto>[]; 
 // Full list of tickets
  List<AdvisorCommisionPageDto> filteredTickets =
      <AdvisorCommisionPageDto>[]; 
 // Search results
  late GcAdminProvider ticketProvider;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    ticketProvider = Provider.of<GcAdminProvider>(context);
    // tickets = [...ticketProvider.newAdvisorCommisionTasks,...ticketProvider.processedAdvisorCommisionTasks,...ticketProvider.toCheckAdvisorCommisionTasks];
     tickets = [...ticketProvider.advisorCommisionData];
    filteredTickets = tickets;
  }

  void filterSearchResults(String query) {
    setState(() {
      if (query.isEmpty) {
        filteredTickets = tickets; // Reset to all tickets if search is cleared
      } else {
        filteredTickets = tickets
            .where((ticket) =>
                ticket.advisorName.toLowerCase().contains(query.toLowerCase()) ||
                ticket.phoneNumber.toLowerCase().contains(query.toLowerCase()) ||
                ticket.commissionAmountReceived
                    .toLowerCase()
                    .contains(query.toLowerCase()) ||
                ticket.phoneNumber
                    .toLowerCase()
                    .contains(query.toLowerCase()) ||
                ticket.transactionStatus.name.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar:  AppBar(
          
          title:  isSearching
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
              :Text('Advisor Commision'),
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
          bottom: TabBar(
            tabs: [
              Tab(text: 'New'),
              Tab(text: 'Processed'),
              Tab(text: 'to check'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            TaskListScreen(taskType: AdvisorCommisionPageDtoEnum.newQ.name,tickets: filteredTickets,),
            TaskListScreen(taskType: AdvisorCommisionPageDtoEnum.processed.name,tickets: filteredTickets,),
            TaskListScreen(taskType: AdvisorCommisionPageDtoEnum.toCheck.name,tickets: filteredTickets,),
          ],
        ),
      ),
    );
  }
}
 
class TaskListScreen extends StatelessWidget {
   final String taskType;
final List<AdvisorCommisionPageDto> tickets;
 
  TaskListScreen({required this.taskType,required this.tickets});

  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<GcAdminProvider>(context);
    List<AdvisorCommisionPageDto> tasks;

    // Get tasks based on status
    if (taskType == AdvisorCommisionPageDtoEnum.newQ.name) {
      tasks = tickets.where((ticket) => ticket.transactionStatus.name == taskType).toList();;
    } else if (taskType == AdvisorCommisionPageDtoEnum.processed.name) {
      tasks = tickets.where((ticket) => ticket.transactionStatus.name == taskType).toList();;
    } else {
      tasks =tickets.where((ticket) => ticket.transactionStatus .name == taskType).toList();;
    }

    return tasks.isEmpty
        ? Center(child: Text('No tasks found.'))
        : ListView.builder(
            itemCount: tasks.length,
            itemBuilder: (ctx, index) {
              final task = tasks[index];
              return AdvisorCommssionCard(dateTime: task.dateTime, advisorName: task.advisorName, commissionAmountReceived: task.commissionAmountReceived, advisorPhoneNumber: task.phoneNumber, transactionCustName: task.transactionCustName, transactionStatus: task.transactionStatus.name, amountInvested: task.amountInvested, basketName: task.basketName,
                percentageCommission: task.percentageCommission,
              id: task.id, transactionId: task.transactionId,
              );
            },
          );
  }
}
