import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:gc_admin_app/auth_wrap.dart'; 
import 'package:gc_admin_app/firebase_options.dart';
import 'package:gc_admin_app/login.dart';
import 'package:gc_admin_app/screens/screen/queried_details_page.dart';
import 'package:gc_admin_app/screens/screen/user_transaction_details.dart';
import 'package:provider/provider.dart';   
import 'providers/gc_admin_provider.dart';
import 'screens/widget/card_widget.dart';
import 'screens/widget/count_widget.dart';
import 'styles/styles.dart';

void main() async{  
    WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform,
);
  runApp(
   
    
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => GcAdminProvider.init()),
      ],
      child: MyApp(),
    ),
  );
}
class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => AuthWrapper()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Grade Capital Admin App',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
   
      theme: ThemeData(primarySwatch: Colors.blue),
      home:    SplashScreen(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

GcAdminProvider? gcAdminProvider;

@override
  void didChangeDependencies() {
    gcAdminProvider = Provider.of<GcAdminProvider>(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
     return RefreshIndicator(
      onRefresh: () {
       return Future.delayed(Duration(seconds: 1)).then((value) {
        gcAdminProvider!.initData();
       });
        // { gcAdminProvider!.initData()}; 
      },
       child: Scaffold(
        body: CustomScrollView(
          slivers: [
           
            SliverList.list(
              children: [
                // for (Veggie veggie in veggies.where((v) => v.seasons.contains(getSeason())))
                  Padding(
                    padding: EdgeInsets.symmetric(
                      vertical:8,
                      horizontal: 8,
                    ),
                    child: HomeCard(),
                  ),
              ],
            ),
          ],
        ),
           ),
     );
  }
}



class HomeCard extends StatefulWidget {
    HomeCard({Key? key}) : super(key: key);

  @override
  State<HomeCard> createState() => _HomeCardState();
}

class _HomeCardState extends State<HomeCard> {
  GcAdminProvider? gcAdminProvider;

@override
  void didChangeDependencies() {
       gcAdminProvider = Provider.of<GcAdminProvider>(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    //  print("====>>>>>ppp ${gcAdminProvider!.userTransactions.map((e) => e.user.walletBalance.runtimeType,).toList()}");
   
     return   
      ListView.builder(
        shrinkWrap: true,
       physics: ScrollPhysics(),
        itemCount: gcAdminProvider!.cardData.length,
        itemBuilder: (context, index) {
          final card = gcAdminProvider!.cardData[index];
          return GestureDetector(
            onTap: () {
              if (card.destination != null) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => card.destination!),
                );
              }
            },
            child: CounterCardWidget(cardDto: card.countCardDto),
          );
        },
      );
    
  }
}


class CounterCardWidget extends StatelessWidget {
  CountCardDto cardDto;
    CounterCardWidget({
    super.key,
   required  this.cardDto,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: $styles.containerStyles.rounded(),
      padding: EdgeInsets.all($styles.padding.m),
      margin: EdgeInsets.symmetric(vertical: $styles.padding.s),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           CountWidget(count: cardDto.count,),
          $styles.spacers.s,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                 Text(
                 cardDto.shortDescription,
                  style: $styles.text.subheading2,
                ),
                $styles.spacers.s,

                 CardHeader(name: cardDto.name, ),
               
              ],
            ),
          )
        ],
      ),
    );
  }
}


class CountCardDto {
  final String count;
  final String name;
  final String shortDescription;

  CountCardDto({
    required this.count,
    required this.name,
    required this.shortDescription,
  });
}

class CardDataDto {
  final CountCardDto countCardDto;
  final Widget? destination; // Nullable for cards without navigation

  CardDataDto({
    required this.countCardDto,
    this.destination,
  });
}
