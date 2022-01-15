import 'package:flutter/material.dart';

class ReusableCard extends StatelessWidget {
  ReusableCard(
      {required this.colour, this.cardChild, this.onPress, double? height}) {
    this.height = height ?? 100.0;
  }
  final Color colour;
  final Widget? cardChild;
  final Function()? onPress;
  double height = 100.0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Material(
        borderRadius: BorderRadius.circular(10.0),
        color: colour,
        elevation: 3,
        child: InkWell(
          child: SizedBox(
            height: height,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: cardChild,
            ),
          ),
          onTap: onPress,
        ),
      ),
    );
  }
}
