import 'package:flutter/material.dart';
import 'package:gc_admin_app/screens/widget/issue_usdt_widget/issue_usdt_card.dart';
import 'package:provider/provider.dart';

import '../../models/issue_usdt_dto.dart';
import '../../providers/gc_admin_provider.dart';
import '../widget/issue_usdt_widget/issue_usdt_card_details.dart';

class IssueUsdtPage extends StatefulWidget {
  const IssueUsdtPage({super.key});

  @override
  State<IssueUsdtPage> createState() => _IssueUsdtPageState();
}

class _IssueUsdtPageState extends State<IssueUsdtPage> {
  bool isSearching = false;
  TextEditingController searchController = TextEditingController();

  List<IssueUsdtDto> tickets = <IssueUsdtDto>[]; // Full list of tickets
  List<IssueUsdtDto> filteredTickets =
      <IssueUsdtDto>[]; // Search results

  late GcAdminProvider ticketProvider;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    ticketProvider = Provider.of<GcAdminProvider>(context);
    tickets = ticketProvider.issueUsdtdataList;
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
                ticket.advisorName
                    .toLowerCase()
                    .contains(query.toLowerCase()) ||
                ticket.number
                    .toLowerCase()
                    .contains(query.toLowerCase()) ||
                ticket.advisorName.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar:  AppBar(
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
              : const Text("Issue USDT"),
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
        
        ),
      body: ListView.builder(
        itemCount: filteredTickets.length,
        itemBuilder: (context, index) {
          final item = filteredTickets[index];
          return IssueUsdtCardWidget(issueUsdtCard: item);
    
        },
      ),
    );
  }
}