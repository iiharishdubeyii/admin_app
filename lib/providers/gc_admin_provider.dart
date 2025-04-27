import 'dart:convert';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:gc_admin_app/models/advisor_commision_page_dto.dart';
import 'package:gc_admin_app/models/queried_api_dto.dart';
import 'package:gc_admin_app/screens/screen/advisor_commission_page.dart';
import 'package:gc_admin_app/screens/screen/advisor_withdraw_page.dart';
import 'package:gc_admin_app/screens/screen/issue_usdt_page.dart';
import 'package:intl/intl.dart';

import '../api_service/cloud_service.dart';
import '../main.dart';
import '../models/advisor_withdraw_model.dart';
import '../models/advsor_withdrawal_dto.dart';
import '../models/issue_usdt_dto.dart';
import '../models/queried_card_data_dto.dart';
import '../models/transaction_status.dart';
import '../models/user_model.dart';
import '../models/user_transaction_dto.dart';
import '../screens/screen/queried_details_page.dart';
import '../screens/screen/user_transaction_details.dart';

class GcAdminProvider with ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  List<Map<String, dynamic>> _transactions = [];
  List<UserTransactionDto> get userTransactions => _transactions
      .map(
        (e) => UserTransactionDto.fromJson(e),
      )
      .toList();
  List<Map<String, dynamic>> _queried = [];
  List<QueriedApiDto> get queried => _queried
      .map(
        (e) => QueriedApiDto.fromJson(e),
      )
      .toList();

  List<Map<String, dynamic>> _issuUSdt = [];
  List<IssueUSDTDto> get issueUsdtList => _issuUSdt
      .map(
        (e) => IssueUSDTDto.fromJson(e),
      )
      .toList();

  List<Map<String, dynamic>> _advisorWithdraw = [];
  List<AdvisorWithDrawlApiDto> get advisorWithdrawData => _advisorWithdraw
      .map(
        (e) => AdvisorWithDrawlApiDto.fromJson(e),
      )
      .toList();

  List<Map<String, dynamic>> _advisorCommision = [];
  List<AdvisorCommisionPageDto> get advisorCommisionData => _advisorCommision
      .map(
        (e) => AdvisorCommisionPageDto(
          advisorName: e['advisorUserData']['firstName'] ?? '',
          advisorPhoneNumber: e['advisorUserData']['phoneNumber'] ?? '',
          amountInvested:
              "${e['transactionData']['transactionDetails']['investmentAmount']}",
          basketName:
              "${e['transactionData']['transactionDetails']['investmentPlan']['basketName']}",
          commissionAmountReceived: "${e['transactionData']['amount']}",
          dateTime: e['transactionData']['createdAt'],
          id: e['userId'],
          phoneNumber: "${e['advisorUserData']['phoneNumber']}",
          transactionStatus: e['transactionData']['transactionStatus'] == AdvisorCommisionPageDtoEnum.processed.name? AdvisorCommisionPageDtoEnum.processed: e['transactionData']['transactionStatus'] == AdvisorCommisionPageDtoEnum.toCheck.name? AdvisorCommisionPageDtoEnum.toCheck: AdvisorCommisionPageDtoEnum.newQ,
          transactionCustName: "${e['transactionData']['name']}",
          transactionId: e['transactionId'],
          percentageCommission: e['transactionData']['transactionDetails']['investmentPlan']['advisorCommissionSales']
        ),
      )
      .toList();
  // .map(

  //   (e) => UserTransactionDto.fromJson(e),
  // )
  // .toList();

  TransactionStatus? selectedUserTransactionStatus;
  QueryCardDataDto? selectedQueriedData;

  IssueUsdtDto? selectedIssueUsdt;
  AdvisorWithdrawDto? selectedAdvisorWithdraw;
   AdvisorCommisionPageDto? selectedAdvisorPageDto;
//  List<Ticket> _tickets =  [
//     Ticket(id: '1', title: 'Login Issue', status: TicketStatus.queried),
//     Ticket(id: '2', title: 'App Crash on Start', status: TicketStatus.solved),
//     Ticket(id: '3', title: 'Payment Failed', status: TicketStatus.inProgress),
//     Ticket(id: '4', title: 'Feature Request', status: TicketStatus.queried),
//     Ticket(id: '5', title: 'UI Bug', status: TicketStatus.solved),
//   ];

//Query
  List<QueryCardDataDto> _ticketList = [
    QueryCardDataDto(
      dateTime: "${DateTime.now()}",
      name: "Mr. Virat Kohli",
      phoneNumber: "+91 9876543210",
      reason: "Playing Cricket",
      message: "Ahhahahahahahhaha",
      status: TicketStatus.queried,
      advisorName: "Rahul Dravid",
      advisorPhoneNumber: "+91 8765432101",
    ),
    QueryCardDataDto(
      dateTime: "${DateTime.now().subtract(const Duration(days: 1))}",
      name: "Ms. Anushka Sharma",
      phoneNumber: "+91 8765432109",
      reason: "Watching a Movie",
      message: "Great experience!",
      status: TicketStatus.solved,
      advisorName: "Kapil Dev",
      advisorPhoneNumber: "+91 7654321092",
    ),
    QueryCardDataDto(
      dateTime: "${DateTime.now().subtract(const Duration(days: 2))}",
      name: "Mr. Rohit Sharma",
      phoneNumber: "+91 7654321098",
      reason: "Attending Meeting",
      message: "Need details urgently.",
      status: TicketStatus.inProgress,
      advisorName: "Sourav Ganguly",
      advisorPhoneNumber: "+91 6543210983",
    ),
    QueryCardDataDto(
      dateTime: "${DateTime.now().subtract(const Duration(days: 3))}",
      name: "Ms. Priyanka Chopra",
      phoneNumber: "+91 6543210987",
      reason: "Event Management",
      message: "Excited about the project.",
      status: TicketStatus.queried,
      advisorName: "Ravi Shastri",
      advisorPhoneNumber: "+91 5432109874",
    ),
    QueryCardDataDto(
      dateTime: "${DateTime.now().subtract(const Duration(days: 4))}",
      name: "Mr. Sachin Tendulkar",
      phoneNumber: "+91 5432109876",
      reason: "Fitness Training",
      message: "Requesting a change in schedule.",
      status: TicketStatus.solved,
      advisorName: "Anil Kumble",
      advisorPhoneNumber: "+91 4321098765",
    ),
    QueryCardDataDto(
      dateTime: "${DateTime.now().subtract(const Duration(days: 5))}",
      name: "Ms. Deepika Padukone",
      phoneNumber: "+91 4321098765",
      reason: "Product Inquiry",
      message: "Need a demo session.",
      status: TicketStatus.inProgress,
      advisorName: "Javagal Srinath",
      advisorPhoneNumber: "+91 3210987656",
    ),
    QueryCardDataDto(
      dateTime: "${DateTime.now().subtract(const Duration(days: 6))}",
      name: "Mr. Mahendra Singh Dhoni",
      phoneNumber: "+91 3210987654",
      reason: "Business Collaboration",
      message: "Let's discuss further.",
      status: TicketStatus.queried,
      advisorName: "VVS Laxman",
      advisorPhoneNumber: "+91 2109876547",
    ),
    QueryCardDataDto(
      dateTime: "${DateTime.now().subtract(const Duration(days: 7))}",
      name: "Ms. Katrina Kaif",
      phoneNumber: "+91 2109876543",
      reason: "Marketing Strategy",
      message: "Awaiting your feedback.",
      status: TicketStatus.solved,
      advisorName: "Ashish Nehra",
      advisorPhoneNumber: "+91 1098765438",
    ),
    QueryCardDataDto(
      dateTime: "${DateTime.now().subtract(const Duration(days: 8))}",
      name: "Mr. Salman Khan",
      phoneNumber: "+91 1098765432",
      reason: "Charity Event",
      message: "Please confirm the dates.",
      status: TicketStatus.inProgress,
      advisorName: "Harbhajan Singh",
      advisorPhoneNumber: "+91 0198765429",
    ),
    QueryCardDataDto(
      dateTime: "${DateTime.now().subtract(const Duration(days: 9))}",
      name: "Ms. Alia Bhatt",
      phoneNumber: "+91 0987654321",
      reason: "Photo Shoot",
      message: "Schedule confirmation required.",
      status: TicketStatus.queried,
      advisorName: "Yuvraj Singh",
      advisorPhoneNumber: "+91 9876543210",
    ),
  ];

//Advisor Withdraw
  // List<AdvisorWithdrawDto> _advisorWithdraw = [
  //   AdvisorWithdrawDto(
  //       dateTime: '1',
  //       name: 'Login Issue',
  //       phoneNumber: "+91 1234567890",
  //       totalNalance: "1200",
  //       status: AdvisorWithdrawEnum.completed,
  //       withdrawl: "120"),
  //   AdvisorWithdrawDto(
  //       dateTime: '2',
  //       name: 'App Crash on Start',
  //       phoneNumber: "+91 1234567890",
  //       totalNalance: "1200",
  //       status: AdvisorWithdrawEnum.inProgress,
  //       withdrawl: "120"),
  //   AdvisorWithdrawDto(
  //       dateTime: '3',
  //       name: 'Payment Failed',
  //       phoneNumber: "+91 1234567890",
  //       totalNalance: "1200",
  //       status: AdvisorWithdrawEnum.processing,
  //       withdrawl: "120"),
  //   AdvisorWithdrawDto(
  //       dateTime: '4',
  //       name: 'Feature Request',
  //       phoneNumber: "+91 1234567890",
  //       totalNalance: "1200",
  //       status: AdvisorWithdrawEnum.rejected,
  //       withdrawl: "120"),
  //   AdvisorWithdrawDto(
  //       dateTime: '5',
  //       name: 'UI Bug',
  //       phoneNumber: "+91 1234567890",
  //       totalNalance: "1200",
  //       status: AdvisorWithdrawEnum.rejected,
  //       withdrawl: "120"),
  // ];

  //transactionSatus
  List<TransactionStatus> _transactionStatus = [
    TransactionStatus(
      dateTime: "23 Nov 2024, 10:30 AM",
      userName: "John Doe",
      phoneNumber: "+91 9876543210",
      advisorName: "Harish",
      chain: "Ethereum",
      txnHash: "0xabc123...",
      amount: "\$500",
      status: TransactionStatusEnum.processing,
    ),
    TransactionStatus(
      dateTime: "22 Nov 2024, 09:00 PM",
      userName: "Jane Smith",
      phoneNumber: "+91 8765432109",
      advisorName: "Rajesh",
      chain: "Binance",
      txnHash: "0xdef456...",
      amount: "\$300",
      status: TransactionStatusEnum.completed,
    ),
    TransactionStatus(
      dateTime: "21 Nov 2024, 07:45 PM",
      userName: "Emily Davis",
      phoneNumber: "+91 7654321098",
      advisorName: "Amit",
      chain: "Polygon",
      txnHash: "0xghi789...",
      amount: "\$800",
      status: TransactionStatusEnum.rejected,
    ),
  ];
//Adddvisorcommission
  List<AdvisorCommisionPageDto> _advisorCommisionStatus = [];
  //   AdvisorCommisionPageDto(
  //       dateTime: '1',
  //       name: 'Review Project Proposal',
  //       status: AdvisorCommisionPageDtoEnum.toCheck),
  //   AdvisorCommisionPageDto(
  //       dateTime: '2',
  //       name: 'Submit Financial Report',
  //       status: AdvisorCommisionPageDtoEnum.newQ),
  //   AdvisorCommisionPageDto(
  //       dateTime: '3',
  //       name: 'Fix Login Issue',
  //       status: AdvisorCommisionPageDtoEnum.newQ),
  //   AdvisorCommisionPageDto(
  //       dateTime: '4',
  //       name: 'UI Design Feedback',
  //       status: AdvisorCommisionPageDtoEnum.processed),
  //   AdvisorCommisionPageDto(
  //       dateTime: '5',
  //       name: 'Server Maintenance',
  //       status: AdvisorCommisionPageDtoEnum.processed),
  // ];

  List<CardDataDto> cardData = [];
//issue usdt
  List<IssueUsdtDto> issueUsdtdataList = [];

  GcAdminProvider.init() {
    initData();
    //
  }

  initData() async {
    fetchTransactions();
    fetchQuried();
    fetchIssueUSDT();
    fetchAdvisorWithdraw();
    fetchAdvisorCommisionData();
  }

  fetchIssueUSDT() async {
    QuerySnapshot querySnapshot = await _firestore
        .collection('users')
        .where('advisor',
            isNotEqualTo: null) // Check if advisor field is not null
        .get();

    _issuUSdt = await Future.wait(querySnapshot.docs.map((doc) async {
      return {
        'user': doc.data(),
        'udocId': doc.id,
      };
    }));
    issueUsdtdataList = issueUsdtList.map(
      (e) {
        return IssueUsdtDto(
          advisorName:
              "${e.user.advisor?.firstName ?? ''} ${e.user.advisor?.lastName}",
          name: "${e.user.firstName} ${e.user.lastName}",
          number: e.user.phoneNumber ?? '',
          email: e.user.email ?? '',
          walletBalance: "${e.user.walletBalance}",
          dateTime: "",
          issueUsdtid: e.userDocId,
          amountTobeAdded: "",
        );
      },
    ).toList();
    if (selectedIssueUsdt == null) {
      selectedIssueUsdt = issueUsdtdataList.first;
    }

    notifyListeners();
  }

  Future<void> fetchTransactions() async {
    try {
      final querySnapshot = await _firestore
          .collection('transactions')
          .where('transactionType', isEqualTo: 'deposit')
          .get();

      _transactions = await Future.wait(querySnapshot.docs.map((doc) async {
        var userId = doc['userId'];
        var userSnapshot =
            await _firestore.collection('users').doc(userId).get();
        var user = userSnapshot.data();
        return {
          'transaction': doc.data(),
          'tdocId': doc.id,
          'udocId': userId,
          'user': user,
        };
      }));
      DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss.SSS");
      _transactions.sort((a, b) {
        DateTime dateA = dateFormat.parse(a['transaction']['createdAt']);
        DateTime dateB = dateFormat.parse(b['transaction']['createdAt']);
        return dateB.compareTo(dateA);
      });

      if (selectedUserTransactionStatus == null) {
        var data = userTransactions
            .where(
              (element) =>
                  element.tdocId == selectedUserTransactionStatus!.orderId,
            )
            .first;

        selectedUserTransactionStatus = TransactionStatus(
          advisorName: data.user.advisor == null
              ? ""
              : "${data.user.advisor!.firstName} ${data.user.advisor!.lastName}",
          amount: "${data.transaction.amount}",
          chain: "${data.transaction.chain}",
          dateTime: "${data.transaction.createdAt}",
          phoneNumber: "${data.user.phoneNumber}",
          status: data.transaction.status!.toLowerCase().contains('processing')
              ? TransactionStatusEnum.processing
              : data.transaction.status!.toLowerCase().contains('completed')
                  ? TransactionStatusEnum.completed
                  : TransactionStatusEnum.rejected,
          txnHash: "${data.transaction.transactionHash!}",
          userName: "${data.user.firstName!} ${data.user.lastName!} ",
          walletBalance: "${data.user.walletBalance}",
          orderId: "${data.tdocId}",
          uid: '${data.userDocId}',
        );
      }
      notifyListeners();
    } catch (e) {
      print('Error fetching transactions: $e');
    }
    cardDataLoader();
  }

  Future<void> fetchQuried() async {
    try {
      // Query the GradeCapital_ContactUs collection
      QuerySnapshot querySnapshot = await _firestore
          .collection('GradeCapital_ContactUs')
          //  .orderBy('timestamp', descending: true)
          .where('isRegistered', isEqualTo: 'true')
          //  .limit(4)
          // .where('userType', isEqualTo: 'Advisor')
          .get();
      print("===> query ${querySnapshot.docs.map(
            (e) => "$e",
          ).toList()}");
      _queried = await Future.wait(querySnapshot.docs.map((doc) async {
        print("object description ${doc['description']}");
        // var userData;

        Map<String, dynamic>? userData;

        // if("${doc['description']}".("{")){
        // (doc['description'].toString().startsWith('{'))
        try {
          userData = jsonDecode(doc['description']);
        } catch (e) {
          userData = {
            'firstName': doc['name'] ?? '',
            'lastName': '',
            'title': doc['description'] ?? '',
            'dateOfBirth': '',
          };
        }
        print("=>: =>${userData}");
        // userData = jsonDecode(doc['description']);
        // }
        var userSnapshot = await _firestore
            .collection('users')
            .where("phoneNumber", isEqualTo: doc['phoneNo'])
            .get();
        // print("==>>> ${userSnapshot.docs.first.data()}");

        if (userSnapshot.docs.isNotEmpty) {
          var advisorQData = userSnapshot.docs.first.data()['advisor'];
          print("object advisorQData ${advisorQData}");
          return {
            'quriedData': doc.data(),
            'docId': doc.id,
            'userData': userData,
            'avisorQData': advisorQData,
          };
        } else {
          return {
            'quriedData': doc.data(),
            'docId': "Not Available in user and advisor data",
            'userData': userData,
            'avisorQData': null,
          };
        }
      }));
      if (selectedQueriedData == null) {
        var data = queried
            .where(
              (element) => element.docId == selectedQueriedData!.queryId,
            )
            .first;
        selectedQueriedData = QueryCardDataDto(
          queryId: data.docId ?? '',
          advisorName: data.avisorQData == null
              ? ""
              : "${data.avisorQData!.firstName} ${data.avisorQData!.lastName}",
          dateTime: "${data.userData?.dateOfBirth}",
          phoneNumber: "${data.quriedData?.phoneNo}",
          status: TicketStatus.all,
          advisorPhoneNumber: " ",
          message: "${data.userData?.title}",
          name: "${data.userData?.firstName}",
          reason: "${data.quriedData?.reason}",
        );
      }
      print("object >>> ${queried.map(
            (e) => e.toJson(),
          ).toList()}");
    } catch (e) {
      print("Error fetching data: $e");
    }
    cardDataLoader();
    notifyListeners();
  }

  Future<void> fetchAdvisorWithdraw() async {
    try {
      final querySnapshot = await _firestore
          .collection('advisor_transactions')
          .where('transactionType', isEqualTo: 'withdraw')
          .get();

      _advisorWithdraw = await Future.wait(querySnapshot.docs.map((doc) async {
        var userId = doc['userId'];
        var userSnapshot =
            await _firestore.collection('users_advisors').doc(userId).get();
        var user = userSnapshot.data();
        return {
          'transaction': doc.data(),
          'tdocId': doc.id,
          'udocId': userId,
          'user': user,
        };
      }));
      DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss.SSS");
      _advisorWithdraw.sort((a, b) {
        DateTime dateA = dateFormat.parse(a['transaction']['createdAt']);
        DateTime dateB = dateFormat.parse(b['transaction']['createdAt']);
        return dateB.compareTo(dateA);
      });
      if (selectedAdvisorWithdraw == null) {
        var data = advisorWithdrawData
            .where(
              (element) => element.tdocId == selectedAdvisorWithdraw!,
            )
            .first;
        selectedAdvisorWithdraw = AdvisorWithdrawDto(
          advisorTrId: data.tdocId,
          advisorName: data.user.advisor == null
              ? ""
              : "${data.user.advisor!.firstName} ${data.user.advisor!.lastName}",
          advisorPhoneNumber: data.user.phoneNumber ?? '',
          name: "${data.user.firstName} ${data.user.lastName}",
          status: data.transaction.status!.toLowerCase().contains('processing')
              ? AdvisorWithdrawEnum.processing
              : data.transaction.status!.toLowerCase().contains('completed')
                  ? AdvisorWithdrawEnum.completed
                  : data.transaction.status!.toLowerCase().contains('rejected')
                      ? AdvisorWithdrawEnum.rejected
                      : AdvisorWithdrawEnum.inProgress,
          totalNalance: "${data.user.walletBalance}",
          withdrawl: "${data.transaction.amount}",
          // amount: "${data.transaction.amount}",
          // chain: "${data.transaction.chain}",
          dateTime: "${data.transaction.createdAt}",
          phoneNumber: "${data.user.phoneNumber}",
          // status: data.transaction.status!.toLowerCase().contains('processing')
          //     ? TransactionStatusEnum.processing
          //     : data.transaction.status!.toLowerCase().contains('completed')
          //         ? TransactionStatusEnum.completed
          //         : TransactionStatusEnum.rejected,
          // txnHash: "${data.transaction.transactionHash!}",
          // userName: "${data.user.firstName!} ${data.user.lastName!} ",
          // orderId: "${data.tdocId}",
          // uid: '${data.userDocId}',
        );
      }
      notifyListeners();
    } catch (e) {
      print('Error fetching transactions: $e');
    }
    cardDataLoader();
    notifyListeners();
  }

  cardDataLoader() {
    cardData = [
      CardDataDto(
        countCardDto: CountCardDto(
          count: "${queried.length}",
          name: 'Queries',
          shortDescription: 'All Queries of Customer',
        ),
        destination: QueriedDetailsPage(),
      ),
      CardDataDto(
        countCardDto: CountCardDto(
          count: "${userTransactions.length}",
          name: 'User Transaction',
          shortDescription: 'All Queries of Customer',
        ),
        destination: UserTransactionDetailsScreenState(),
      ),
      CardDataDto(
          countCardDto: CountCardDto(
            count: '${issueUsdtdataList.length}',
            name: 'Issue USDT',
            shortDescription: 'All Queries of Customer',
          ),
          destination: IssueUsdtPage()),
      CardDataDto(
          countCardDto: CountCardDto(
            count: '${advisorWithdrawData.length}',
            name: 'Advisor Withdraw',
            shortDescription: 'All Queries of Customer',
          ),
          destination: AdvisorWithdrawPage()),
      CardDataDto(
          countCardDto: CountCardDto(
            count: '${advisorCommisionData.length}',
            name: 'Advisor Commissions',
            shortDescription: 'All Queries of Customer',
          ),
          destination: AdvisorCommissionPage()),
    ];
    notifyListeners();
  }

  setSelectedAmountTobeAdded(String amountTobeAdded) {
    selectedUserTransactionStatus!.amountTobeAdded = amountTobeAdded;
    notifyListeners();
  }

  Future<void> updateTransactionStatusByOrderId(
      String orderId, double amount) async {
    print(
        "selected data ${selectedUserTransactionStatus!.walletBalance} ${selectedUserTransactionStatus!.amountTobeAdded.runtimeType}");
    print("${double.parse(selectedUserTransactionStatus!.amountTobeAdded)}");
    print("${double.parse("${selectedUserTransactionStatus!.walletBalance}")}");
    try {
      final DocumentReference transactionsCollection =
          FirebaseFirestore.instance.collection('transactions').doc(orderId);
      final DocumentReference userCollection = FirebaseFirestore.instance
          .collection('users')
          .doc(selectedUserTransactionStatus!.uid);
      final DocumentSnapshot docSnapshot = await transactionsCollection.get();

      if (docSnapshot.exists) {
        await transactionsCollection
            .update({'status': "completed", 'amount': amount});
        await userCollection.update({
          'walletBalance':
              '${double.parse("${selectedUserTransactionStatus!.walletBalance}") + double.parse(selectedUserTransactionStatus!.amountTobeAdded)}',
        });
        // await userCollection.update({'walletBalance': amount});
        print(
            'Updated document $orderId with new key reason and value: $amount');
      } else {
        print('Document with ID $orderId does not exist.');
      }
    } catch (e) {
      print('Error updating transaction status: $e');
    }
    fetchTransactions();
  }

  Future<void> updateReasonToTransaction(dynamic value) async {
    print(selectedUserTransactionStatus!.orderId);
    try {
      final DocumentReference transactionsCollection = FirebaseFirestore
          .instance
          .collection('transactions')
          .doc(selectedUserTransactionStatus!.orderId);
      final DocumentReference userCollection = FirebaseFirestore.instance
          .collection('users')
          .doc(selectedUserTransactionStatus!.uid);
      final DocumentSnapshot docSnapshot = await transactionsCollection.get();

      if (docSnapshot.exists) {
        await transactionsCollection
            .update({'status': "rejected", 'reason': value});
        if (selectedUserTransactionStatus!.status ==
            TransactionStatusEnum.completed) {
          await userCollection.update({
            'walletBalance':
                '${double.parse("${selectedUserTransactionStatus!.walletBalance}") - double.parse(selectedUserTransactionStatus!.amountTobeAdded)}',
          });
        }
        print(
            'Updated document ${selectedUserTransactionStatus!.orderId} with new key reason and value: $value');
      } else {
        print(
            'Document with ID ${selectedUserTransactionStatus!.orderId} does not exist.');
      }
    } catch (e) {
      print('Error adding new key to transaction: $e');
    }
    fetchTransactions();
    notifyListeners();
  }

  void changeQueriedStatus(String val) async {
    print(val);
    try {
      final DocumentReference transactionsCollection = FirebaseFirestore
          .instance
          .collection('GradeCapital_ContactUs')
          .doc(selectedQueriedData!.queryId);

      final DocumentSnapshot docSnapshot = await transactionsCollection.get();

      if (docSnapshot.exists) {
        await transactionsCollection.update({
          'status': val,
        });
        print('Updated document $val with new key reason and value: value');
      } else {
        print('Document with ID $val does not exist.');
      }
    } catch (e) {
      print('Error adding new key to transaction: $e');
    }
    fetchQuried();
  }

  Future<void> updateUsdtIssued() async {
    print(selectedIssueUsdt!.issueUsdtid);
    try {
      final DocumentReference userCollection = FirebaseFirestore.instance
          .collection('users')
          .doc(selectedIssueUsdt!.issueUsdtid);

      await userCollection.update({
        'walletBalance': double.parse(
            '${double.parse(selectedIssueUsdt!.walletBalance) + double.parse(selectedIssueUsdt!.amountTobeAdded)}'),
      });
      // await userCollection.update({'walletBalance': {selectedIssueUsdt}});
      print(
          'Updated document orderId with new key reason and value: ${selectedIssueUsdt!.toJson()}');
    } catch (e) {
      print('Error updating transaction status: $e');
    }
   
    updateBalance();
     await fetchIssueUSDT();
  }

  updateBalance() async {
    await cloneTransactionWithNewData(selectedIssueUsdt!.issueUsdtid,
        double.parse(selectedIssueUsdt!.amountTobeAdded));
    selectedIssueUsdt = IssueUsdtDto(
      advisorName: selectedIssueUsdt!.advisorName,
      name: selectedIssueUsdt!.name,
      number: selectedIssueUsdt!.number,
      email: selectedIssueUsdt!.email,
      walletBalance:
          "${double.parse(selectedIssueUsdt!.walletBalance) + double.parse(selectedIssueUsdt!.amountTobeAdded)}",
      dateTime: selectedIssueUsdt!.dateTime,
      issueUsdtid: selectedIssueUsdt!.issueUsdtid,
      amountTobeAdded: "",
    );

    notifyListeners();
  }

  Future<void> cloneTransactionWithNewData(
      String issueUsdtid, double newAmount) async {
        String randomNumber = DateTime.now().millisecondsSinceEpoch.toString();
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    print('issueUsdtid $issueUsdtid');
    // try {
      QuerySnapshot querySnapshot = await firestore
          .collection('transactions')
          .where('userId', isEqualTo: issueUsdtid)
          .get();

      Map<String, dynamic> newTransaction;

      if (querySnapshot.docs.isNotEmpty) {
        List<DocumentSnapshot> transactions = querySnapshot.docs;

        transactions.sort((a, b) {
          DateTime dateA =
              DateTime.parse(a['createdAt']);
          DateTime dateB =
              DateTime.parse(b['createdAt']);
          return dateB.compareTo(dateA); // Sort descending
        });

        // Get the latest transaction data
        Map<String, dynamic> latestData =
            transactions.first.data() as Map<String, dynamic>;

        // Get the latest transaction data

        // DocumentSnapshot latestTransaction = querySnapshot.docs.first;
        // Map<String, dynamic> latestData = latestTransaction.data() as Map<String, dynamic>;
print("---> ${latestData}  ${latestData['orderId']}");
        // Clone the transaction with updated values
        newTransaction = {
          ...latestData,
          'amount': newAmount,
          'cryptoAmount': newAmount,
          'transactionType': 'deposit',
          'provider':"Bank Deposit",
          'status': 'completed',
          'orderId':latestData.containsKey('orderId') && latestData['orderId'] != null && latestData['orderId'].isNotEmpty?"${int.parse(latestData['orderId'])+1}":randomNumber,
          'createdAt': DateTime.now().toString(),
        };

        print('Cloned transaction from latest data.');
      } else {
        // No transaction exists; create a new one with default or specified values
        newTransaction = {
          'phoneNumber': selectedIssueUsdt!.number,
          'amount': newAmount,
          'userId': issueUsdtid,
          'orderId':randomNumber,
          'transactionType': 'deposit',
           'provider':"Bank Deposit",
          'createdAt': DateTime.now().toString(),
          'status': 'completed', // Example of a default field
        };

        print('Created new transaction with default data.');
      }

      // Add the new transaction to the collection
      await firestore.collection('transactions').add(newTransaction);

      print('New transaction created successfully!');
    // } catch (e) {
    //   print('Error:--> $e');
    // }
  }
  // List<UserModel> users = await CloudService.fetchDataByField<UserModel>(
  //   collectionName: collectionName,
  //   fieldName: fieldName,
  //   value: fieldValue,
  //   fromJson: (data) => UserModel.fromJson(data),
  // );

  // for (var user in users) {
  //   print('User: ${user.firstName}, Age: ${user.phoneNumber}');
  // }
  // }

  getAllAdvisorRecords() {}

 
//queried
  List<QueryCardDataDto> allTickets() {
    List<QueryCardDataDto> userTemp = [];
    for (var i = 0; i < queried.length; i++) {
      userTemp.add(QueryCardDataDto(
        queryId: queried[i].docId ?? '',
        advisorName: queried[i].avisorQData == null
            ? ""
            : "${queried[i].avisorQData!.firstName} ${queried[i].avisorQData!.lastName}",
        dateTime: "${queried[i].userData?.dateOfBirth}",
        phoneNumber: "${queried[i].quriedData?.phoneNo}",
        status: TicketStatus.all,
        advisorPhoneNumber: " ",
        message: "${queried[i].userData?.title}",
        name: "${queried[i].userData?.firstName}",
        reason: "${queried[i].quriedData?.reason}",
      ));
    }
    return userTemp;
  }

  //  => _ticketList;

  List<QueryCardDataDto> queriedTickets() {
    List<QueryCardDataDto> userTemp = [];
    for (var i = 0; i < queried.length; i++) {
      if (queried[i].quriedData?.status == "Queried") {
        userTemp.add(QueryCardDataDto(
          queryId: queried[i].docId ?? '',
          advisorName: queried[i].avisorQData == null
              ? ""
              : "${queried[i].avisorQData!.firstName} ${queried[i].avisorQData!.lastName}",
          dateTime: "${queried[i].userData?.dateOfBirth}",
          phoneNumber: "${queried[i].quriedData?.phoneNo}",
          status: TicketStatus.queried,
          advisorPhoneNumber: " ",
          message: "${queried[i].userData?.title}",
          name: "${queried[i].userData?.firstName}",
          reason: "${queried[i].quriedData?.reason}",
        ));
      }
    }
    return userTemp;
  }
  // => _ticketList
  //     .where((ticket) => ticket.status == TicketStatus.queried)
  //     .toList();

  List<QueryCardDataDto> solvedTickets() {
    List<QueryCardDataDto> userTemp = [];
    for (var i = 0; i < queried.length; i++) {
      if (queried[i].quriedData?.status == "Solved") {
        userTemp.add(QueryCardDataDto(
          queryId: queried[i].docId ?? '',
          advisorName: queried[i].avisorQData == null
              ? ""
              : "${queried[i].avisorQData!.firstName} ${queried[i].avisorQData!.lastName}",
          dateTime: "${queried[i].userData?.dateOfBirth}",
          phoneNumber: "${queried[i].quriedData?.phoneNo}",
          status: TicketStatus.solved,
          advisorPhoneNumber: " ",
          message: "${queried[i].userData?.title}",
          name: "${queried[i].userData?.firstName}",
          reason: "${queried[i].quriedData?.reason}",
        ));
      }
    }
    return userTemp;
  }
  //  => _ticketList
  //     .where((ticket) => ticket.status == TicketStatus.solved)
  //     .toList();

  List<QueryCardDataDto> inProgressTickets() {
    List<QueryCardDataDto> userTemp = [];
    for (var i = 0; i < queried.length; i++) {
      if (queried[i].quriedData?.status == "In Process") {
        userTemp.add(QueryCardDataDto(
          queryId: queried[i].docId ?? '',
          advisorName: queried[i].avisorQData == null
              ? ""
              : "${queried[i].avisorQData!.firstName} ${queried[i].avisorQData!.lastName}",
          dateTime: "${queried[i].userData?.dateOfBirth}",
          phoneNumber: "${queried[i].quriedData?.phoneNo}",
          status: TicketStatus.inProgress,
          advisorPhoneNumber: " ",
          message: "${queried[i].userData?.title}",
          name: "${queried[i].userData?.firstName}",
          reason: "${queried[i].quriedData?.reason}",
        ));
      }
    }
    return userTemp;
  }

  // _ticketList
  //     .where((ticket) => ticket.status == TicketStatus.inProgress)
  //     .toList();
//advisor withdraw
  List<AdvisorWithdrawDto> awcompletedTickets() {
    List<AdvisorWithdrawDto> userTemp = [];
    for (var i = 0; i < advisorWithdrawData.length; i++) {
      if (advisorWithdrawData[i]
          .transaction
          .status!
          .toLowerCase()
          .contains('completed')) {
        userTemp.add(AdvisorWithdrawDto(
          advisorTrId: advisorWithdrawData[i].tdocId,
          advisorName: advisorWithdrawData[i].user.advisor == null
              ? ""
              : "${advisorWithdrawData[i].user.advisor!.firstName} ${advisorWithdrawData[i].user.advisor!.lastName}",
          name:
              "${advisorWithdrawData[i].user.firstName} ${advisorWithdrawData[i].user.lastName}",

          totalNalance: "${advisorWithdrawData[i].user.walletBalance}",
          withdrawl: "${advisorWithdrawData[i].transaction.amount}",
          dateTime: "${advisorWithdrawData[i].transaction.createdAt}",
          phoneNumber: "${advisorWithdrawData[i].user.phoneNumber}",
          status: AdvisorWithdrawEnum.completed,

          // txnHash: "${advisorWithdrawData[i].transaction.transactionHash!}",
          // userName:
          //     "${advisorWithdrawData[i].user.firstName!} ${advisorWithdrawData[i].user.lastName!} ",
          // orderId: "${advisorWithdrawData[i].tdocId}",
          // uid: "${advisorWithdrawData[i].userDocId}",
        ));
      }
    }
    return userTemp;
  }
  // => _advisorWithdraw
  //     .where((ticket) => ticket.status == AdvisorWithdrawEnum.completed)
  //     .toList();

  List<AdvisorWithdrawDto> awinprogressTickets() {
    List<AdvisorWithdrawDto> userTemp = [];
    for (var i = 0; i < advisorWithdrawData.length; i++) {
      if (advisorWithdrawData[i]
          .transaction
          .status!
          .toLowerCase()
          .contains('inprocess')) {
        userTemp.add(AdvisorWithdrawDto(
          advisorTrId: advisorWithdrawData[i].tdocId,
          advisorName: advisorWithdrawData[i].user.advisor == null
              ? ""
              : "${advisorWithdrawData[i].user.advisor!.firstName} ${advisorWithdrawData[i].user.advisor!.lastName}",
          name:
              "${advisorWithdrawData[i].user.firstName} ${advisorWithdrawData[i].user.lastName}",

          totalNalance: "${advisorWithdrawData[i].user.walletBalance}",
          withdrawl: "${advisorWithdrawData[i].transaction.amount}",

          dateTime: "${advisorWithdrawData[i].transaction.createdAt}",
          phoneNumber: "${advisorWithdrawData[i].user.phoneNumber}",
          status: AdvisorWithdrawEnum.inProgress,
          // txnHash: "${advisorWithdrawData[i].transaction.transactionHash!}",
          // userName:
          //     "${advisorWithdrawData[i].user.firstName!} ${advisorWithdrawData[i].user.lastName!} ",
          // orderId: "${advisorWithdrawData[i].tdocId}",
          // uid: "${advisorWithdrawData[i].userDocId}",
        ));
      }
    }
    return userTemp;
  }
  //  => _advisorWithdraw
  //     .where((ticket) => ticket.status == AdvisorWithdrawEnum.inProgress)
  //     .toList();

  List<AdvisorWithdrawDto> awprocessTickets() {
    List<AdvisorWithdrawDto> userTemp = [];
    for (var i = 0; i < advisorWithdrawData.length; i++) {
      if (advisorWithdrawData[i]
          .transaction
          .status!
          .toLowerCase()
          .contains('proccessing')) {
        userTemp.add(AdvisorWithdrawDto(
          advisorTrId: advisorWithdrawData[i].tdocId,
          advisorName: advisorWithdrawData[i].user.advisor == null
              ? ""
              : "${advisorWithdrawData[i].user.advisor!.firstName} ${advisorWithdrawData[i].user.advisor!.lastName}",
          name:
              "${advisorWithdrawData[i].user.firstName} ${advisorWithdrawData[i].user.lastName}",

          totalNalance: "${advisorWithdrawData[i].user.walletBalance}",
          withdrawl: "${advisorWithdrawData[i].transaction.amount}",

          dateTime: "${advisorWithdrawData[i].transaction.createdAt}",
          phoneNumber: "${advisorWithdrawData[i].user.phoneNumber}",
          status: AdvisorWithdrawEnum.processing,
          // txnHash: "${advisorWithdrawData[i].transaction.transactionHash!}",
          // userName:
          //     "${advisorWithdrawData[i].user.firstName!} ${advisorWithdrawData[i].user.lastName!} ",
          // orderId: "${advisorWithdrawData[i].tdocId}",
          // uid: "${advisorWithdrawData[i].userDocId}",
        ));
      }
    }
    return userTemp;
  }
  //  => _advisorWithdraw
  //     .where((ticket) => ticket.status == AdvisorWithdrawEnum.processing)
  //     .toList();

  List<AdvisorWithdrawDto> awrejectedTickets() {
    List<AdvisorWithdrawDto> userTemp = [];
    for (var i = 0; i < advisorWithdrawData.length; i++) {
      if (advisorWithdrawData[i]
          .transaction
          .status!
          .toLowerCase()
          .contains('rejected')) {
        userTemp.add(AdvisorWithdrawDto(
          advisorTrId: advisorWithdrawData[i].tdocId,
          advisorName: advisorWithdrawData[i].user.advisor == null
              ? ""
              : "${advisorWithdrawData[i].user.advisor!.firstName} ${advisorWithdrawData[i].user.advisor!.lastName}",
          name:
              "${advisorWithdrawData[i].user.firstName} ${advisorWithdrawData[i].user.lastName}",

          totalNalance: "${advisorWithdrawData[i].user.walletBalance}",
          withdrawl: "${advisorWithdrawData[i].transaction.amount}",

          dateTime: "${advisorWithdrawData[i].transaction.createdAt}",
          phoneNumber: "${advisorWithdrawData[i].user.phoneNumber}",
          status: AdvisorWithdrawEnum.rejected,
          // txnHash: "${advisorWithdrawData[i].transaction.transactionHash!}",
          // userName:
          //     "${advisorWithdrawData[i].user.firstName!} ${advisorWithdrawData[i].user.lastName!} ",
          // orderId: "${advisorWithdrawData[i].tdocId}",
          // uid: "${advisorWithdrawData[i].userDocId}",
        ));
      }
    }
    return userTemp;
  }

  // => _advisorWithdraw
  //     .where((ticket) => ticket.status == AdvisorWithdrawEnum.rejected)
  //     .toList();
//user transaction
  //  processingTasks = []
  List<TransactionStatus> processingTasks() {
    List<TransactionStatus> userTemp = [];
    for (var i = 0; i < userTransactions.length; i++) {
      if (userTransactions[i]
          .transaction
          .status!
          .toLowerCase()
          .contains('processing')) {
        userTemp.add(TransactionStatus(
          advisorName: userTransactions[i].user.advisor == null
              ? ""
              : "${userTransactions[i].user.advisor!.firstName} ${userTransactions[i].user.advisor!.lastName}",
          amount: "${userTransactions[i].transaction.amount}",
          chain: "${userTransactions[i].transaction.chain}",
          dateTime: "${userTransactions[i].transaction.createdAt}",
          phoneNumber: "${userTransactions[i].user.phoneNumber}",
          status: TransactionStatusEnum.processing,
          txnHash: "${userTransactions[i].transaction.transactionHash!}",
          userName:
              "${userTransactions[i].user.firstName!} ${userTransactions[i].user.lastName!} ",
          orderId: "${userTransactions[i].tdocId}",
          uid: "${userTransactions[i].userDocId}",
          walletBalance: "${userTransactions[i].user.walletBalance}",
          amountTobeAdded: "${userTransactions[i].transaction.amount}",
        ));
      }
    }
    return userTemp;
  }

  // List<TransactionStatus> get completedTransactionStatus => _transactionStatus
  //     .where((transactionStatus) =>
  //         transactionStatus.status == TransactionStatusEnum.completed)
  //     .toList();
  List<TransactionStatus> completedTransactionStatus() {
    List<TransactionStatus> userTemp = [];
    for (var i = 0; i < userTransactions.length; i++) {
      if (userTransactions[i]
          .transaction
          .status!
          .toLowerCase()
          .contains('completed')) {
        userTemp.add(TransactionStatus(
          advisorName: userTransactions[i].user.advisor == null
              ? ""
              : "${userTransactions[i].user.advisor!.firstName} ${userTransactions[i].user.advisor!.lastName}",
          amount: "${userTransactions[i].transaction.amount}",
          chain: "${userTransactions[i].transaction.chain}",
          dateTime: "${userTransactions[i].transaction.createdAt}",
          phoneNumber: "${userTransactions[i].user.phoneNumber}",
          status: TransactionStatusEnum.completed,
          txnHash: "${userTransactions[i].transaction.transactionHash!}",
          orderId: "${userTransactions[i].tdocId}",
          uid: "${userTransactions[i].userDocId}",
          userName:
              "${userTransactions[i].user.firstName!} ${userTransactions[i].user.lastName!} ",
          walletBalance: "${userTransactions[i].user.walletBalance}",
          amountTobeAdded: "${userTransactions[i].transaction.amount}",
        ));
      }
    }
    return userTemp;
  }

  // List<TransactionStatus> get rejectedTransactionStatus => _transactionStatus
  //     .where((transactionStatus) =>
  //         transactionStatus.status == TransactionStatusEnum.rejected)
  //     // .toList();
  List<TransactionStatus> rejectedTransactionStatus() {
    List<TransactionStatus> userTemp = [];
    for (var i = 0; i < userTransactions.length; i++) {
      if (userTransactions[i]
          .transaction
          .status!
          .toLowerCase()
          .contains('rejected')) {
        userTemp.add(TransactionStatus(
          advisorName: userTransactions[i].user.advisor == null
              ? ""
              : "${userTransactions[i].user.advisor!.firstName} ${userTransactions[i].user.advisor!.lastName}",
          amount: "${userTransactions[i].transaction.amount}",
          chain: "${userTransactions[i].transaction.chain}",
          dateTime: "${userTransactions[i].transaction.createdAt}",
          phoneNumber: "${userTransactions[i].user.phoneNumber}",
          status: TransactionStatusEnum.rejected,
          txnHash: "${userTransactions[i].transaction.transactionHash!}",
          orderId: "${userTransactions[i].tdocId}",
          uid: "${userTransactions[i].userDocId}",
          userName:
              "${userTransactions[i].user.firstName!} ${userTransactions[i].user.lastName!} ",
          walletBalance: "${userTransactions[i].user.walletBalance}",
          amountTobeAdded: "${userTransactions[i].transaction.amount}",
        ));
      }
    }
    return userTemp;
  }

  setSelectedUserTransactionData(TransactionStatus transactionStatus) {
    selectedUserTransactionStatus = transactionStatus;

    notifyListeners();
  }

  setSelectedQueried(QueryCardDataDto queriedData) {
    selectedQueriedData = queriedData;
    notifyListeners();
  }

  setSelectedIssueUsdtDto(IssueUsdtDto issueData) {
    selectedIssueUsdt = issueData;
    notifyListeners();
  }

  setSelectedIssueUsdtAmountTobeAdd(String amountTobeAdded) {
    selectedIssueUsdt!.amountTobeAdded = amountTobeAdded;
    notifyListeners();
  }

  setSelectedAdvisorWithdrawDto(AdvisorWithdrawDto advisorWithdrawDto) {
    selectedAdvisorWithdraw = advisorWithdrawDto;
    notifyListeners();
  }

  Future<void> updateAdvisorStatusByOrderId(String status) async {
    print("${selectedAdvisorWithdraw!.advisorTrId}");
    try {
      final DocumentReference transactionsCollection = FirebaseFirestore
          .instance
          .collection('advisor_transactions')
          .doc(selectedAdvisorWithdraw!.advisorTrId);
      // final DocumentReference userCollection = FirebaseFirestore.instance
      //     .collection('users')
      //     .doc(selectedUserTransactionStatus!.uid);
      final DocumentSnapshot docSnapshot = await transactionsCollection.get();

      if (docSnapshot.exists) {
        await transactionsCollection.update({
          'status': "$status",
        });
        // await userCollection.update({
        //   'walletBalance': FieldValue.increment(amount),
        // });
        // await userCollection.update({'walletBalance': amount});
        print(
            'Updated document orderId with new key reason and value: $status');
      } else {
        print('Document with ID orderId does not exist.');
      }
    } catch (e) {
      print('Error updating transaction status: $e');
    }
    fetchAdvisorWithdraw();
  }

//Advisor Commision
  List<AdvisorCommisionPageDto>
      get newAdvisorCommisionTasks => advisorCommisionData
          .where((transactionStatus) =>
              transactionStatus.transactionStatus.name ==
              AdvisorCommisionPageDtoEnum.newQ.name)
          .toList();

  List<AdvisorCommisionPageDto> get toCheckAdvisorCommisionTasks =>
      advisorCommisionData
          .where((transactionStatus) =>
              transactionStatus.transactionStatus.name ==
              AdvisorCommisionPageDtoEnum.toCheck.name)
          .toList();

  List<AdvisorCommisionPageDto> get processedAdvisorCommisionTasks =>
      advisorCommisionData
          .where((transactionStatus) =>
              transactionStatus.transactionStatus.name ==
              AdvisorCommisionPageDtoEnum.processed.name)
          .toList();

  void fetchAdvisorCommisionData() async {
    try {
      // Query advisor_transactions where transactionType is "Sales Commission"
      QuerySnapshot transactionSnapshot = await _firestore
          .collection('advisor_transactions')
          .where('transactionType', isEqualTo: 'Sales Commission')
          .get();

      // // Prepare a list to store combined data
      // List<Map<String, dynamic>> combinedData = [];

      for (QueryDocumentSnapshot transactionDoc in transactionSnapshot.docs) {
        Map<String, dynamic> transactionData =
            transactionDoc.data() as Map<String, dynamic>;
        String userId = transactionData['userId'];

        // Fetch the corresponding user data
        DocumentSnapshot userDoc =
            await _firestore.collection('users_advisors').doc(userId).get();
        Map<String, dynamic> userData =
            userDoc.data() as Map<String, dynamic>? ?? {};

        // Combine transaction data, user data, transaction ID, and user ID
        _advisorCommision.add({
          'transactionId': transactionDoc.id,
          'userId': userId,
          'transactionData': transactionData,
          'advisorUserData': userData,
        });

       selectedAdvisorPageDto=  advisorCommisionData.first;
        //  print("object advisorCommisionData ${_advisorCommision[0]['transactionData']['status']}");
        cardDataLoader();
        notifyListeners();
      }
    } catch (e) {
      print('Error fetching or creating JSON: $e');
    }
  }
  setSelectedAdvisorCommisionData(AdvisorCommisionPageDto advisorCommisionPageDto) {
    selectedAdvisorPageDto = advisorCommisionPageDto;
    notifyListeners();
  }

    updateAdvisorCommisionStatusByOrderId(
      String orderId, String status) async {
    try {
      final DocumentReference transactionsCollection =
          FirebaseFirestore.instance.collection('advisor_transactions').doc(orderId);

      final DocumentSnapshot docSnapshot = await transactionsCollection.get();

      if (docSnapshot.exists) {
        await transactionsCollection.update({
          'transactionStatus': status,
        });
        print('Updated document $orderId with new key reason and value: $status');
      } else {
        print('Document with ID $orderId does not exist.');
      }
    } catch (e) {
      print('Error updating transaction status: $e');
    }
    fetchAdvisorCommisionData();
  }
Future<void> createNewEntryOfAdvisorTransactionWithPreviousTransaction(
    String transactionId, double newAmount, double newAdvisorCommissionSales) async {
  try {
    final DocumentReference transactionDoc =
        FirebaseFirestore.instance.collection('advisor_transactions').doc(transactionId);

    final DocumentSnapshot docSnapshot = await transactionDoc.get();

    if (docSnapshot.exists) {
      Map<String, dynamic> transactionData =
          docSnapshot.data() as Map<String, dynamic>;

      // Modify the necessary fields
      transactionData['amount'] = newAmount;
      if (transactionData.containsKey('orderId') && transactionData['orderId'] != null && transactionData['orderId'].isNotEmpty) {
        transactionData['orderId'] = "${int.parse(transactionData['orderId']) + 1}";
      } else {
        transactionData['orderId'] = "${DateTime.now().millisecondsSinceEpoch}";
      }
      transactionData['cryptoAmount'] = newAmount;
      transactionData['createdAt'] = DateTime.now().toString();
      transactionData['transactionDetails']['investmentPlan']
          ['advisorCommissionSales'] = "${newAdvisorCommissionSales}";

      // Create a new transaction with the modified data
      await FirebaseFirestore.instance.collection('advisor_transactions').add(transactionData);
final DocumentReference userCollection = FirebaseFirestore.instance
  .collection('users_advisors')
  .doc(transactionData['userId']);
await userCollection.get().then((doc) {
  if (doc.exists) {
    double currentBalance = double.parse(doc['walletBalance'].toString());
    double updatedBalance = currentBalance + newAmount;
    userCollection.update({
      'walletBalance': updatedBalance.toString(),
    });
    print('Updated wallet balance: $updatedBalance');
  }
});
      print('New transaction created successfully with updated data.');
    } else {
      print('Document with ID $transactionId does not exist.');
    }
  } catch (e) {
    print('Error creating new transaction: $e');
  }
   fetchAdvisorCommisionData();
}

}
