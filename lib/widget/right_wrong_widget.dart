import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class RightWrongWidget extends StatelessWidget {
  RightWrongWidget({required this.iconsize, required this.answerBool});
  double iconsize;
  bool answerBool;

  FaIcon rightIcon = FaIcon(
    FontAwesomeIcons.solidCheckCircle,
    color: Colors.green,
  );
  FaIcon wrongIcon = FaIcon(
    FontAwesomeIcons.solidTimesCircle,
    color: Colors.redAccent,
  );

  Widget build(BuildContext context) {
    rightIcon = FaIcon(
      FontAwesomeIcons.solidCheckCircle,
      color: Colors.green,
      size: iconsize,
    );
    wrongIcon = FaIcon(
      FontAwesomeIcons.solidTimesCircle,
      color: Colors.redAccent,
      size: iconsize,
    );

    if (answerBool) {
      return rightIcon;
    } else {
      return wrongIcon;
    }
  }
}
