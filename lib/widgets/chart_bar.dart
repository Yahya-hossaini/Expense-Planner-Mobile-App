import 'package:flutter/material.dart';

import '../constants_and_styles.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double spendingAmount;
  final double spendingPctOfTotal;

  const ChartBar(
      {super.key,
      required this.label,
      required this.spendingAmount,
      required this.spendingPctOfTotal});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (ctx, constraint) {
        return Column(
          children: [

            SizedBox(
              height: constraint.maxHeight * 0.15,
              child: FittedBox(
                child: Text('\$${spendingAmount.toStringAsFixed(0)}'),
              ),
            ),

            SizedBox(
              height: constraint.maxHeight * 0.05,
            ),

            SizedBox(
              height: constraint.maxHeight * 0.6,
              width: 10,

              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Container(
                    decoration: kFirstStackChildBoxDecoration,
                  ),

                  //This part will take percentage of the total background as chart
                  FractionallySizedBox(
                    heightFactor: spendingPctOfTotal,
                    child: Container(
                      decoration: kLastStackChildBoxDecoration,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(
              height: constraint.maxHeight * 0.05,
            ),

            SizedBox(
              height: constraint.maxHeight * 0.15,
              child: FittedBox(
                child: Text(label),
              ),
            ),
          ],
        );
      },
    );
  }
}
