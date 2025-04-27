import 'package:flutter/widgets.dart';
import '../../styles/styles.dart';

class CountWidget extends StatelessWidget {
  const CountWidget({super.key, required this.count, });
  final String count; 

  @override
  Widget build(BuildContext context) {
   

    return Container(
      width: 100,
      height: 100,
      decoration: $styles.containerStyles.rounded(
        
      ),
      child: Center(child: Text(count,style: $styles.text.heading1,)),
    );
  }
}
