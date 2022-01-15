import 'package:flutter/material.dart';
import 'package:infinite_calculation/constants.dart';
import 'package:infinite_calculation/screens/practice_calcultion_screens/practice_screen.dart';
import 'package:infinite_calculation/screens/tutorial/multutorial_screen.dart';
import 'package:infinite_calculation/widget/modeselect_button.dart';

class MainMulScreen extends StatefulWidget {
  @override
  _MainMulScreenState createState() => _MainMulScreenState();
}

class _MainMulScreenState extends State<MainMulScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('곱셈'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            modeSelectbutton(
              text: '곱셈 튜토리얼',
              moveScreen: MulTutorialScreen(),
            ),
            modeSelectbutton(
              text: '두 수의 곱셈',
              moveScreen: PracticeScreen(
                  calculationType: CalculationType.multiplicationTwo),
            ),
            modeSelectbutton(
              text: '세 개 이상의 수의 곱셈',
              moveScreen: PracticeScreen(
                  calculationType: CalculationType.multiplicationMany),
            ),
          ],
        ),
      ),
    );
  }
}
