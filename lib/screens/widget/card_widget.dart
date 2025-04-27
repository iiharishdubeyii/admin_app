import 'package:flutter/widgets.dart';

import '../../styles/styles.dart';


class CardHeader extends StatelessWidget {
  const CardHeader({super.key, required this.name, });
 final String name;
  // final Size size;


  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          flex: 5,
          child: Text(
            name,
            style: $styles.text.heading2,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
        ),
        // VeggieCardSeasons(
        //   veggie: veggie,
        //   size: size,
        // )
      ],
    );
  }
}
