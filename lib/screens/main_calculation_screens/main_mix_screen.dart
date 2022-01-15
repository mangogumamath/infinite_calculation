import 'package:flutter/material.dart';
import 'package:infinite_calculation/constants.dart';
import 'package:infinite_calculation/screens/practice_calcultion_screens/practice_screen.dart';
import 'package:infinite_calculation/screens/tutorial/mixtutorial_screen.dart';
import 'package:infinite_calculation/widget/modeselect_button.dart';

class MainMixScreen extends StatefulWidget {
  @override
  _MainMixScreenState createState() => _MainMixScreenState();
}

class _MainMixScreenState extends State<MainMixScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('혼합 계산'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            modeSelectbutton(
              text: '혼합 계산 튜토리얼',
              moveScreen: MixTutorialScreen(),
            ),
            modeSelectbutton(
              text: '혼합 계산',
              moveScreen: PracticeScreen(
                calculationType: CalculationType.mix,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
