import 'package:flutter/material.dart';
import 'package:infinite_calculation/constants.dart';
import 'package:infinite_calculation/screens/practice_calcultion_screens/practice_screen.dart';
import 'package:infinite_calculation/screens/tutorial/subtutorial_screen.dart';
import 'package:infinite_calculation/widget/modeselect_button.dart';

class MainSubScreen extends StatefulWidget {
  @override
  _MainSubScreenState createState() => _MainSubScreenState();
}

class _MainSubScreenState extends State<MainSubScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('뺄셈'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            modeSelectbutton(
              text: '뺄셈 튜토리얼',
              moveScreen: SubTutorialScreen(),
            ),
            modeSelectbutton(
              text: '뺄셈',
              moveScreen: PracticeScreen(
                calculationType: CalculationType.subtraction,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
