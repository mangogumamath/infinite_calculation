import 'package:flutter/material.dart';
import 'package:infinite_calculation/constants.dart';

class LevelBrain {
  LevelBrain({required this.calculationType});
  int quizTimeSecond = 10;
  int scoreMul = 200;
  int minusScore = 100;
  String levelText = '1 Lv';
  Color levelTextColor = Colors.green;
  CalculationType calculationType = CalculationType.sameAdd;

  void levelUpCheck(int score, CalculationType calculationType) {
    if (score < 500) {
      levelText = '1 Lv';
      levelTextColor = Colors.green;
      quizTimeSecond = 10;
      scoreMul = 200;
      minusScore = (1 * scoreMul).round();
    } else if (score < 1000) {
      levelText = '2 Lv';
      levelTextColor = Colors.blueAccent;
      quizTimeSecond = 7;
      scoreMul = 300;
      minusScore = (1 * scoreMul).round();
    } else if (score < 1500) {
      levelText = '3 Lv';
      levelTextColor = Colors.yellow;
      quizTimeSecond = 4;
      scoreMul = 500;
      minusScore = (1 * scoreMul).round();
    } else if (score < 3000) {
      levelText = '4 Lv';
      levelTextColor = Colors.deepPurpleAccent;
      quizTimeSecond = 3;
      scoreMul = 800;
      minusScore = (1 * scoreMul).round();
    } else {
      levelText = 'Max Lv';
      levelTextColor = Colors.red;
      quizTimeSecond = 2;
      scoreMul = 1000;
      minusScore = (1 * scoreMul).round();
    }
    if (calculationType == CalculationType.multiplicationMany) {
      quizTimeSecond = quizTimeSecond * 3;
    }
    if (calculationType == CalculationType.division) {
      quizTimeSecond = quizTimeSecond * 3;
    }
    if (calculationType == CalculationType.mix) {
      quizTimeSecond = quizTimeSecond * 10;
    }
  }
}
