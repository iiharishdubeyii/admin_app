import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gc_admin_app/models/advisor_withdraw_model.dart';
import 'package:gc_admin_app/providers/gc_admin_provider.dart';
import 'package:gc_admin_app/screens/widget/advisor_withdraw_widget/advisor_withdraw_card.dart';
import 'package:provider/provider.dart';
 

class AdvisorWithdrawPage extends StatefulWidget {
  const AdvisorWithdrawPage({super.key});

  @override
  State<AdvisorWithdrawPage> createState() => _AdvisorWithdrawPageState();
}

class _AdvisorWithdrawPageState extends State<AdvisorWithdrawPage> {
   bool isSearching = false;
  TextEditingController searchController = TextEditingController();

  List<AdvisorWithdrawDto> tickets = <AdvisorWithdrawDto>[]; // Full list of tickets
  List<AdvisorWithdrawDto> filteredTickets =
      <AdvisorWithdrawDto>[]; // Search results

  late GcAdminProvider ticketProvider;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    ticketProvider = Provider.of<GcAdminProvider>(context);
    tickets = [...ticketProvider.awinprogressTickets(),...ticketProvider.awprocessTickets(),...ticketProvider.awcompletedTickets(),...ticketProvider.awrejectedTickets()];
    filteredTickets = tickets;
  }

  void filterSearchResults(String query) {
    setState(() {
      if (query.isEmpty) {
        filteredTickets = tickets; // Reset to all tickets if search is cleared
      } else {
        filteredTickets = tickets
            .where((ticket) =>
                ticket.name.toLowerCase().contains(query.toLowerCase()) ||
                ticket.phoneNumber.toLowerCase().contains(query.toLowerCase()) ||
                ticket.withdrawl
                    .toLowerCase()
                    .contains(query.toLowerCase()) ||
                ticket.totalNalance
                    .toLowerCase()
                    .contains(query.toLowerCase()) ||
                ticket.status.name.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
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
              :Text('Advisor Withdraw'),
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
            tabs:  [
              Tab(text: 'Processing'),
              Tab(text: 'In-Process'),
              Tab(text: 'Completed'),
              Tab(text: 'Rejected'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            TicketListScreen(ticketType: AdvisorWithdrawEnum.processing.name,tickets: filteredTickets,),
            TicketListScreen(ticketType: AdvisorWithdrawEnum.inProgress.name,tickets: filteredTickets,),
            TicketListScreen(ticketType: AdvisorWithdrawEnum.completed.name,tickets: filteredTickets,),
            TicketListScreen(ticketType: AdvisorWithdrawEnum.rejected.name,tickets: filteredTickets,),
          ],
        ),
      ),
    );
  }
}
 

class TicketListScreen extends StatelessWidget {
  final String ticketType;
final List<AdvisorWithdrawDto> tickets;

  TicketListScreen({required this.ticketType, required this.tickets,});

  @override
  Widget build(BuildContext context) {
    List<AdvisorWithdrawDto> ticketsToShow;
    final ticketProvider = Provider.of<GcAdminProvider>(context);

    // Determine the list of tickets based on the tab
    // if (ticketType == 'Processing') {
    //   tickets = ticketProvider.awprocessTickets;
    // } else if (ticketType == 'In-Process') {
    //   tickets = ticketProvider.awinprogressTickets;
    // } else if (ticketType == 'Completed') {
    //   tickets = ticketProvider.awcompletedTickets;
    // } else if (ticketType == 'Rejected') {
    //   tickets = ticketProvider.awrejectedTickets;
    // } else {
    //   tickets = [];
    // }
      if (ticketType == AdvisorWithdrawEnum.processing.name) {
      ticketsToShow =ticketProvider.awprocessTickets();//tickets.where((ticket) => ticket.status.name == ticketType).toList();
    } else if (ticketType == AdvisorWithdrawEnum.inProgress.name) {
      ticketsToShow =ticketProvider.awinprogressTickets();
          // tickets.where((ticket) => ticket.status.name == ticketType).toList();
    } else if (ticketType == AdvisorWithdrawEnum.completed.name) {
      ticketsToShow =ticketProvider.awcompletedTickets();
          // tickets.where((ticket) => ticket.status.name == ticketType).toList();
    } else if (ticketType == AdvisorWithdrawEnum.rejected.name) {
      ticketsToShow =ticketProvider.awrejectedTickets();
          // tickets.where((ticket) => ticket.status.name == ticketType).toList();
    } else {
      ticketsToShow = [];
    }


    return tickets.isEmpty
        ? Center(
            child: Text('No tickets found.'),
          )
        : ListView.builder(
            itemCount: ticketsToShow.length,
            itemBuilder: (ctx, index) {
              final ticket = ticketsToShow[index];
              return  AdvisorWithdrawCard(advisorWithdrawDto: ticket,);
            },
          );
  }
}
