import 'package:flutter/material.dart';

class PowerWidget extends StatelessWidget {
  PowerWidget({
    Key? key,
    required this.power,
    TextStyle? textStyle,
  }) : super(key: key) {
    this.textStyle = textStyle ?? const TextStyle(fontSize: 30.0);
  }
  int power;
  TextStyle textStyle = const TextStyle(fontSize: 30.0);
  double boxHeight = 90.0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: textStyle.fontSize! * 3,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            '$power',
            style: textStyle,
          ),
        ],
      ),
      // width: 30.0,
      // height: 40.0,
    );
  }
}
