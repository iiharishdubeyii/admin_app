import 'package:flutter/material.dart';
import 'package:gc_admin_app/providers/gc_admin_provider.dart';
import 'package:provider/provider.dart';
import '../../models/queried_card_data_dto.dart';
import '../widget/query_widget/queries_card.dart';

class QueriedDetailsPage extends StatefulWidget {
  const QueriedDetailsPage({super.key});

  @override
  State<QueriedDetailsPage> createState() => _QueriedDetailsPageState();
}

class _QueriedDetailsPageState extends State<QueriedDetailsPage> {
  bool isSearching = false;
  TextEditingController searchController = TextEditingController();

  List<QueryCardDataDto> tickets = <QueryCardDataDto>[]; // Full list of tickets
  List<QueryCardDataDto> filteredTickets =
      <QueryCardDataDto>[]; // Search results

  late GcAdminProvider ticketProvider;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    ticketProvider = Provider.of<GcAdminProvider>(context);
    tickets = ticketProvider.allTickets();
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
                ticket.reason.toLowerCase().contains(query.toLowerCase()) ||
                ticket.phoneNumber
                    .toLowerCase()
                    .contains(query.toLowerCase()) ||
                ticket.advisorPhoneNumber
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
      length: 4,
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
              : const Text("Query"),
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
          bottom: const TabBar(
            tabs: [
              Tab(text: 'All'),
              Tab(text: 'Queried'),
              Tab(text: 'Solved'),
              Tab(text: 'In Progress'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            TicketListScreen(ticketType: 'All', tickets: filteredTickets),
            TicketListScreen(ticketType: 'Queried', tickets: filteredTickets),
            TicketListScreen(ticketType: 'Solved', tickets: filteredTickets),
            TicketListScreen(
                ticketType: 'In Progress', tickets: filteredTickets),
          ],
        ),
      ),
    );
  }
}

class TicketListScreen extends StatefulWidget {
  final String ticketType;
  final List<QueryCardDataDto> tickets;

  const TicketListScreen({
    required this.ticketType,
    required this.tickets,
  });

  @override
  State<TicketListScreen> createState() => _TicketListScreenState();
}

class _TicketListScreenState extends State<TicketListScreen> {

    late GcAdminProvider gcAdminProvider;
  

@override
  void didChangeDependencies() {
    gcAdminProvider =Provider.of<GcAdminProvider>(context);
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
    List<QueryCardDataDto> ticketsToShow;

    // Filter tickets based on status
    if (widget.ticketType == 'All') {
      ticketsToShow = widget.tickets;
    } else if (widget.ticketType == 'Queried') {
      ticketsToShow =
          gcAdminProvider.queriedTickets();
    } else if (widget.ticketType == 'Solved') {
      ticketsToShow =
          gcAdminProvider.solvedTickets();
    } else if (widget.ticketType == 'In Progress') {
      ticketsToShow =
        gcAdminProvider.inProgressTickets();
    } else {
      ticketsToShow = [];
    }

    return ticketsToShow.isEmpty
        ? const Center(child: Text('No tickets found.'))
        : ListView.builder(
            itemCount: ticketsToShow.length,
            itemBuilder: (ctx, index) {
              final ticket = ticketsToShow[index];

              return QuieryCard(
                queriedDataDto: ticket,
                // dateTime: ticket.dateTime,
                // name: ticket.name,
                // phoneNumber: ticket.phoneNumber,
                // reason: ticket.reason,
                // message: ticket.message,
              );
            },
          );
  }
}
