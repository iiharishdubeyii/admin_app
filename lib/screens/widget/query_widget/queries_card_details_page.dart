import 'package:flutter/material.dart';
import 'package:gc_admin_app/models/queried_card_data_dto.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../providers/gc_admin_provider.dart';

class QueryCardDetailsPage extends StatefulWidget {
  QueryCardDataDto queryCardDataDto;
  // final String dateTime;
  // final String name;
  // final String phoneNumber;
  // final String reason;
  // final String message;
  // final String advisorName;
  // final String advisorPhoneNumber;

    QueryCardDetailsPage({
    Key? key,
    required this.queryCardDataDto
    // required this.dateTime,
    // required this.name,
    // required this.phoneNumber,
    // required this.reason,
    // required this.message,
    // required this.advisorName,
    // required this.advisorPhoneNumber,
  }) : super(key: key);

  @override
  _QueryCardDetailsPageState createState() => _QueryCardDetailsPageState();
}

class _QueryCardDetailsPageState extends State<QueryCardDetailsPage> {
  String? status;
List<String> statusList = [TicketStatus.all.name,TicketStatus.inProgress.name,TicketStatus.queried.name,TicketStatus.solved.name];
    late GcAdminProvider gcAdminProvider;

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    
  }  

@override
  void didChangeDependencies() {
    gcAdminProvider =Provider.of<GcAdminProvider>(context);
    status = gcAdminProvider.selectedQueriedData!.status.name;
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) { 
    return Scaffold(
      appBar: AppBar(
        title: const Text('Query'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Right Query Label
            // Align(
            //   alignment: Alignment.topRight,
            //   child: Container(
            //     padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            //     decoration: BoxDecoration(
            //       color: Colors.blue,
            //       borderRadius: BorderRadius.circular(5),
            //     ),
            //     child: const Text(
            //       'Query',
            //       style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            //     ),
            //   ),
            // ),
            // const SizedBox(height: 16),

            // Card Details (7 Children)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
               Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                     "${widget.queryCardDataDto.dateTime.split(" ").first}",
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold,color: Colors.red),
                  ),
                  SizedBox(width: 16,),
                   Text(
                     "${widget.queryCardDataDto.dateTime.split(" ").last}",
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  
                ],
              ),
                const Divider(),
                Text(
                  widget.queryCardDataDto.name,
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  widget.queryCardDataDto.phoneNumber,
                  style: const TextStyle(fontSize: 16, color: Colors.blueAccent),
                ),
                Text(
                  'Reason: ${widget.queryCardDataDto.reason}',
                  style: const TextStyle(fontSize: 16),
                ),
                const Text(
                  'Message:',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Text(
                  widget.queryCardDataDto.message,
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Additional Advisor Details (4 More Children)
            const Text(
              'Advisor Details:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Text(
              'Name: ${widget.queryCardDataDto.advisorName}',
              style: const TextStyle(fontSize: 16),
            ),
            Text(
              'Mob. No.: ${widget.queryCardDataDto.advisorPhoneNumber}',
              style: const TextStyle(fontSize: 16, color: Colors.blueAccent),
            ),
            const SizedBox(height: 16),

            // Status Dropdown
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Text(
                  'Status:',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
               const SizedBox(width: 16*8,),
               DropdownButton<String>(
          // Value must match exactly one item in the dropdown
          value: status,
          hint: Text("Select an item"),
          items: statusList.map((String item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Text(item),
            );
          }).toList(),
          onChanged: (newValue) {
            setState(() {
              status = newValue!;
            });
          gcAdminProvider.changeQueriedStatus(status??"");
                    Navigator.pop(context);
          },
          // Styling (optional)
          
        ),
                // DropdownButton<String>(
                //   value: status,
                //   items: const [
                //     DropdownMenuItem(value: "New", child: Text("New")),
                //     DropdownMenuItem(value: "In Process", child: Text("In Process")),
                //     DropdownMenuItem(value: "Solved", child: Text("Solved")),
                //   ],
                //   onChanged: (value) {
                //     setState(() {
                //       status = value!;
                //     });
                    // gcAdminProvider.changeQueriedStatus(value??"");
                    // Navigator.pop(context);
                //   },
                // ),

              ],
            ),
          ],
        ),
      ),
    );
  }
}
