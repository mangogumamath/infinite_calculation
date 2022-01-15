import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:fraction/fraction.dart';
import 'package:infinite_calculation/constants.dart';
import 'package:infinite_calculation/model/generalterm_brain.dart';
import 'package:infinite_calculation/widget/fraction_reduced_widget.dart';
import 'package:infinite_calculation/widget/generalterm_widget.dart';
import 'package:math_parser/math_parser.dart';

//여기가 주방. 계산은 여기서 처리하기.
class CalculationBrain {
  CalculationBrain({required this.calculationType});
  CalculationType calculationType;
  int x = 0;
  int y = 0;
  int z = 0;
  int w = 0;
  String str_x = '';
  String str_y = '';
  String str_z = '';
  String str_w = '';

  int a = 0;
  int b = 0;
  int c = 0;
  int d = 0;

  int frac_x_numerator = 1;
  int frac_x_denominator = 1;
  int frac_y_numerator = 1;
  int frac_y_denominator = 1;
  int frac_z_numerator = 1;
  int frac_z_denominator = 1;
  int frac_w_numerator = 1;
  int frac_w_denominator = 1;
  int frac_x_power = 1;
  int frac_y_power = 1;
  int frac_z_power = 1;
  int frac_w_power = 1;
  Fraction frac_x = Fraction(1);
  Fraction frac_y = Fraction(1);
  Fraction frac_z = Fraction(1);
  Fraction frac_w = Fraction(1);

  dynamic realAnswer;

  dynamic choiceA_value;
  dynamic choiceB_value;
  dynamic choiceC_value;
  dynamic choiceD_value;
  List choiceList = [];
  String choiceA_text = 'A';
  String choiceB_text = 'B';
  String choiceC_text = 'C';
  String choiceD_text = 'D';

  bool checkBool = true;
  int correctCount = 0;
  int score = 0;

  String questionText = '';
  Widget questionWidget = Text('');
  Widget questionRow = Row();

  GeneralTermBrain generalTermBrain_x = GeneralTermBrain();
  GeneralTermBrain generalTermBrain_y = GeneralTermBrain();
  GeneralTermBrain generalTermBrain_z = GeneralTermBrain();
  GeneralTermBrain generalTermBrain_w = GeneralTermBrain();

  List<String> calList = ['+', '-', '*', '/'];
  String cal1 = '+';
  String cal2 = '+';
  String cal3 = '+';
  List<String> calExpression_List1 = [];
  List<String> calExpression_List2 = [];
  String calExpression1 = '';
  String calExpression2 = '';

  String cal1_string = '';
  String cal2_string = '';

  void resetNumber() {
    choiceList.clear();

    Set choiceSet = {};
    bool randomSignBool = Random().nextBool();

    //sameAdd
    if (calculationType == CalculationType.sameAdd) {
      x = Random().nextInt(10) + 1;
      y = Random().nextInt(10) + 1;

      x = randomSignBool ? x : -x;
      y = randomSignBool ? y : -y;

      questionText = randomSignBool
          ? '(+${x.toString()})+(+${y.toString()}) ='
          : '(${x.toString()})+(${y.toString()}) =';
      questionWidget = Text(
        questionText,
        style: TextStyle(
          fontSize: 50.0,
        ),
      ); //문제 텍스트 위젯 입력
      realAnswer = x + y;
      choiceSet.add(realAnswer);

      while (choiceSet.length < 4) {
        choiceSet.add(x + y + Random().nextInt(20) - 10);
      }
      choiceList = [...choiceSet];
      choiceList.shuffle();

      choiceA_value = choiceList[0];
      choiceB_value = choiceList[1];
      choiceC_value = choiceList[2];
      choiceD_value = choiceList[3];

      choiceA_text = choiceA_value > 0
          ? '+${choiceA_value.toString()}'
          : choiceA_value.toString();
      choiceB_text = choiceB_value > 0
          ? '+${choiceB_value.toString()}'
          : choiceB_value.toString();
      choiceC_text = choiceC_value > 0
          ? '+${choiceC_value.toString()}'
          : choiceC_value.toString();
      choiceD_text = choiceD_value > 0
          ? '+${choiceD_value.toString()}'
          : choiceD_value.toString();
    }

    //diffAdd
    if (calculationType == CalculationType.diffAdd) {
      x = Random().nextInt(10) + 1;
      y = Random().nextInt(10) + 1;

      x = randomSignBool ? x : -x;
      y = randomSignBool ? -y : y;

      questionText = randomSignBool
          ? '(+${x.toString()})+(${y.toString()}) ='
          : '(${x.toString()})+(+${y.toString()}) =';
      questionWidget = Text(
        questionText,
        style: TextStyle(
          fontSize: 50.0,
        ),
      ); //문제 텍스트 위젯 입력
      realAnswer = x + y;
      choiceSet.add(realAnswer);

      while (choiceSet.length < 4) {
        choiceSet.add(x + y + Random().nextInt(20) - 10);
      }
      choiceList = [...choiceSet];
      choiceList.shuffle();

      choiceA_value = choiceList[0];
      choiceB_value = choiceList[1];
      choiceC_value = choiceList[2];
      choiceD_value = choiceList[3];

      choiceA_text = choiceA_value > 0
          ? '+${choiceA_value.toString()}'
          : choiceA_value.toString();
      choiceB_text = choiceB_value > 0
          ? '+${choiceB_value.toString()}'
          : choiceB_value.toString();
      choiceC_text = choiceC_value > 0
          ? '+${choiceC_value.toString()}'
          : choiceC_value.toString();
      choiceD_text = choiceD_value > 0
          ? '+${choiceD_value.toString()}'
          : choiceD_value.toString();
    }

    //subtraction
    if (calculationType == CalculationType.subtraction) {
      x = Random().nextInt(20) - 10;
      y = Random().nextInt(20) - 10;

      str_x = x > 0 ? '(+${x.toString()})' : '(${x.toString()})';
      str_y = y > 0 ? '(+${y.toString()})' : '(${y.toString()})';
      str_x = str_x == '(0)' ? '0' : str_x;
      str_y = str_y == '(0)' ? '0' : str_y;

      questionText = str_x + '-' + str_y + '=';
      questionWidget = Text(
        questionText,
        style: TextStyle(
          fontSize: 50.0,
        ),
      ); //문제 텍스트 위젯 입력
      realAnswer = x - y;
      choiceSet.add(realAnswer);

      while (choiceSet.length < 4) {
        choiceSet.add(x - y + Random().nextInt(20) - 10);
      }
      choiceList = [...choiceSet];
      choiceList.shuffle();

      choiceA_value = choiceList[0];
      choiceB_value = choiceList[1];
      choiceC_value = choiceList[2];
      choiceD_value = choiceList[3];

      choiceA_text = choiceA_value > 0
          ? '+${choiceA_value.toString()}'
          : choiceA_value.toString();
      choiceB_text = choiceB_value > 0
          ? '+${choiceB_value.toString()}'
          : choiceB_value.toString();
      choiceC_text = choiceC_value > 0
          ? '+${choiceC_value.toString()}'
          : choiceC_value.toString();
      choiceD_text = choiceD_value > 0
          ? '+${choiceD_value.toString()}'
          : choiceD_value.toString();
    }

    //addSub
    if (calculationType == CalculationType.addSub) {
      x = Random().nextInt(20) - 10;
      y = Random().nextInt(20) - 10;

      questionText = y >= 0
          ? '${x.toString()}+${y.toString()} ='
          : '${x.toString()}' + '${y.toString()} =';
      questionWidget = Text(
        questionText,
        style: TextStyle(
          fontSize: 50.0,
        ),
      ); //문제 텍스트 위젯 입력
      realAnswer = x + y;
      choiceSet.add(realAnswer);

      while (choiceSet.length < 4) {
        choiceSet.add(x + y + Random().nextInt(10) - 5);
      }
      choiceList = [...choiceSet];
      choiceList.shuffle();

      choiceA_value = choiceList[0];
      choiceB_value = choiceList[1];
      choiceC_value = choiceList[2];
      choiceD_value = choiceList[3];

      choiceA_text = choiceA_value.toString();
      choiceB_text = choiceB_value.toString();
      choiceC_text = choiceC_value.toString();
      choiceD_text = choiceD_value.toString();
    }

    //multiplicationTwo
    if (calculationType == CalculationType.multiplicationTwo) {
      x = Random().nextInt(20) - 10;
      y = Random().nextInt(20) - 10;

      str_x = x > 0 ? '(+${x.toString()})' : '(${x.toString()})';
      str_y = y > 0 ? '(+${y.toString()})' : '(${y.toString()})';
      str_x = str_x == '(0)' ? '0' : str_x;
      str_y = str_y == '(0)' ? '0' : str_y;

      questionText = str_x + '×' + str_y + '=';
      questionWidget = Text(
        questionText,
        style: TextStyle(
          fontSize: 50.0,
        ),
      ); //문제 텍스트 위젯 입력
      realAnswer = x * y;
      choiceSet.add(realAnswer);

      while (choiceSet.length < 4) {
        choiceSet.add(Random().nextBool()
            ? (x * y + Random().nextInt(20) - 10)
            : (x * y + Random().nextInt(20) - 10) * -1);
      }
      choiceList = [...choiceSet];
      choiceList.shuffle();

      choiceA_value = choiceList[0];
      choiceB_value = choiceList[1];
      choiceC_value = choiceList[2];
      choiceD_value = choiceList[3];

      choiceA_text = choiceA_value > 0
          ? '+${choiceA_value.toString()}'
          : choiceA_value.toString();
      choiceB_text = choiceB_value > 0
          ? '+${choiceB_value.toString()}'
          : choiceB_value.toString();
      choiceC_text = choiceC_value > 0
          ? '+${choiceC_value.toString()}'
          : choiceC_value.toString();
      choiceD_text = choiceD_value > 0
          ? '+${choiceD_value.toString()}'
          : choiceD_value.toString();
    }

    //multiplicationMany
    if (calculationType == CalculationType.multiplicationMany) {
      x = Random().nextBool()
          ? Random().nextInt(7) + 1
          : (Random().nextInt(7) + 1) * -1;
      y = Random().nextBool()
          ? Random().nextInt(7) + 1
          : (Random().nextInt(7) + 1) * -1;
      z = Random().nextBool()
          ? Random().nextInt(7) + 1
          : (Random().nextInt(7) + 1) * -1;
      w = Random().nextBool()
          ? Random().nextInt(7) + 1
          : (Random().nextInt(7) + 1) * -1;

      str_x = x > 0 ? '(+${x.toString()})' : '(${x.toString()})';
      str_y = y > 0 ? '(+${y.toString()})' : '(${y.toString()})';
      str_x = str_x == '(0)' ? '0' : str_x;
      str_y = str_y == '(0)' ? '0' : str_y;
      str_z = z > 0 ? '(+${z.toString()})' : '(${z.toString()})';
      str_w = w > 0 ? '(+${w.toString()})' : '(${w.toString()})';
      str_z = str_z == '(0)' ? '0' : str_z;
      str_w = str_w == '(0)' ? '0' : str_w;

      questionText = randomSignBool
          ? str_x + '×' + str_y + '\n' + '×' + str_z + '×' + str_w + '='
          : str_x + '×' + str_y + '\n' + '×' + str_z + '=';
      questionWidget = Text(
        questionText,
        style: TextStyle(
          fontSize: 50.0,
        ),
      ); //문제 텍스트 위젯 입력
      realAnswer = randomSignBool ? x * y * z * w : x * y * z;
      choiceSet.add(realAnswer);

      while (choiceSet.length < 4) {
        choiceSet.add(Random().nextBool()
            ? (realAnswer + Random().nextInt(20) - 10)
            : ((realAnswer + Random().nextInt(20) - 10) * -1));
      }
      choiceList = [...choiceSet];
      choiceList.shuffle();

      choiceA_value = choiceList[0];
      choiceB_value = choiceList[1];
      choiceC_value = choiceList[2];
      choiceD_value = choiceList[3];

      choiceA_text = choiceA_value > 0
          ? '+${choiceA_value.toString()}'
          : choiceA_value.toString();
      choiceB_text = choiceB_value > 0
          ? '+${choiceB_value.toString()}'
          : choiceB_value.toString();
      choiceC_text = choiceC_value > 0
          ? '+${choiceC_value.toString()}'
          : choiceC_value.toString();
      choiceD_text = choiceD_value > 0
          ? '+${choiceD_value.toString()}'
          : choiceD_value.toString();
    }

    //division
    if (calculationType == CalculationType.division) {
      a = Random().nextBool()
          ? Random().nextInt(9) + 1
          : (Random().nextInt(9) + 1) * -1;
      b = Random().nextInt(9) + 1;
      c = Random().nextBool()
          ? Random().nextInt(9) + 1
          : (Random().nextInt(9) + 1) * -1;
      d = Random().nextInt(9) + 1;

      frac_x = Fraction(a, b).reduce();
      frac_y = Fraction(c, d).reduce();

      questionWidget = Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: !frac_y.isNegative
            ? [
                FractionReducedWidget(frac_x.numerator, frac_x.denominator),
                Text(
                  '÷',
                  style: TextStyle(
                    fontSize: 40.0,
                  ),
                ),
                FractionReducedWidget(frac_y.numerator, frac_y.denominator)
              ]
            : [
                FractionReducedWidget(frac_x.numerator, frac_x.denominator),
                Text(
                  '÷',
                  style: TextStyle(
                    fontSize: 40.0,
                  ),
                ),
                Text(
                  '(',
                  style: TextStyle(
                    fontSize: 40.0,
                  ),
                ),
                FractionReducedWidget(frac_y.numerator, frac_y.denominator),
                Text(
                  ')',
                  style: TextStyle(
                    fontSize: 40.0,
                  ),
                ),
              ],
      ); //문제 로우 위젯
      realAnswer = frac_x / frac_y;
      choiceSet.add(realAnswer);

      while (choiceSet.length < 4) {
        choiceSet.add(
          Random().nextBool()
              ? Fraction(frac_x.numerator + Random().nextInt(20) - 10,
                  frac_x.denominator + Random().nextInt(5) + 1)
              : Fraction((frac_y.numerator + Random().nextInt(20) - 10) * -1,
                  frac_y.denominator + Random().nextInt(5) + 1),
        );
      }
      choiceList = [...choiceSet];
      choiceList.shuffle();

      choiceA_value = choiceList[0];
      choiceB_value = choiceList[1];
      choiceC_value = choiceList[2];
      choiceD_value = choiceList[3];

      choiceA_text = !choiceA_value.isNegative
          ? '+${choiceA_value.toString()}'
          : choiceA_value.toString();
      choiceB_text = !choiceB_value.isNegative
          ? '+${choiceB_value.toString()}'
          : choiceB_value.toString();
      choiceC_text = !choiceC_value.isNegative
          ? '+${choiceC_value.toString()}'
          : choiceC_value.toString();
      choiceD_text = !choiceD_value.isNegative
          ? '+${choiceD_value.toString()}'
          : choiceD_value.toString();
    }

    //mixCalculation
    if (calculationType == CalculationType.mix) {
      calExpression_List1.clear();
      calExpression_List2.clear();
      calExpression1 = '';
      calExpression2 = '';
      generalTermBrain_x.resetNumber();
      generalTermBrain_y.resetNumber();
      generalTermBrain_z.resetNumber();
      generalTermBrain_w.resetNumber();

      frac_x_numerator = generalTermBrain_x.numerator;
      frac_x_denominator = generalTermBrain_x.denominator;
      frac_y_numerator = generalTermBrain_y.numerator;
      frac_y_denominator = generalTermBrain_y.denominator;
      frac_z_numerator = generalTermBrain_z.numerator;
      frac_z_denominator = generalTermBrain_z.denominator;
      frac_w_numerator = generalTermBrain_w.numerator;
      frac_w_denominator = generalTermBrain_w.denominator;

      frac_x_power = generalTermBrain_x.power;
      frac_y_power = generalTermBrain_y.power;
      frac_z_power = generalTermBrain_z.power;
      frac_w_power = generalTermBrain_w.power;

      cal1 = calList[Random().nextInt(4)];
      cal2 = calList[Random().nextInt(4)];
      cal3 = calList[Random().nextInt(4)];

      cal1_string = cal1;
      cal2_string = cal2;

      if (cal1 == '*') {
        cal1_string = '×';
      }
      if (cal1 == '/') {
        cal1_string = '÷';
      }
      if (cal2 == '*') {
        cal2_string = '×';
      }
      if (cal2 == '/') {
        cal2_string = '÷';
      }

      calExpression_List1.add('(');
      calExpression_List1.add('($frac_x_numerator/$frac_x_denominator)');
      calExpression_List1.add('^$frac_x_power');
      calExpression_List1.add(cal1);
      calExpression_List1.add('($frac_y_numerator/$frac_y_denominator)');
      calExpression_List1.add('^$frac_y_power');
      calExpression_List1.add(')');
      calExpression_List1.add(cal2);
      calExpression_List1.add('($frac_z_numerator/$frac_z_denominator)');
      calExpression_List1.add('^$frac_z_power');

      // calExpression_List.add(cal3);
      // calExpression_List.add('($frac_w_numerator/$frac_w_denominator)');
      for (String string in calExpression_List1) {
        calExpression1 = calExpression1 + string;
      }

      calExpression_List2.add('($frac_x_numerator/$frac_x_denominator)');
      calExpression_List2.add('^$frac_x_power');
      calExpression_List2.add(cal1);
      calExpression_List2.add('(');
      calExpression_List2.add('($frac_y_numerator/$frac_y_denominator)');
      calExpression_List2.add('^$frac_y_power');
      calExpression_List2.add(cal2);
      calExpression_List2.add('($frac_z_numerator/$frac_z_denominator)');
      calExpression_List2.add('^$frac_z_power');
      calExpression_List2.add(')');

      for (String string in calExpression_List2) {
        calExpression2 = calExpression2 + string;
      }

      bool random_bool = Random().nextBool();
      // if (random_bool) {
      //   print(calExpression1);
      // } else {
      //   print(calExpression2);
      // }

      realAnswer = random_bool
          ? MathNodeExpression.fromString(calExpression1)
              .calc(MathVariableValues({'x': 0}))
              .toFraction()
          : MathNodeExpression.fromString(calExpression2)
              .calc(MathVariableValues({'x': 0}))
              .toFraction();

      if (realAnswer.numerator.abs() >= 100 ||
          realAnswer.denominator.abs() >= 100) {
        // print('reset done');
        resetNumber();
        return;
      }

      questionWidget = Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: random_bool
            ? [
                Text(
                  '(',
                  style: TextStyle(fontSize: 30.0),
                ),
                GeneralTermWidget(
                  frac_x_numerator,
                  frac_x_denominator,
                  frac_x_power,
                  fontsize: 30.0,
                ),
                Text(
                  cal1_string,
                  style: TextStyle(fontSize: 30.0),
                ),
                GeneralTermWidget(
                  frac_y_numerator,
                  frac_y_denominator,
                  frac_y_power,
                  fontsize: 30.0,
                ),
                Text(
                  ')',
                  style: TextStyle(fontSize: 30.0),
                ),
                Text(
                  cal2_string,
                  style: TextStyle(fontSize: 30.0),
                ),
                GeneralTermWidget(
                  frac_z_numerator,
                  frac_z_denominator,
                  frac_z_power,
                  fontsize: 30.0,
                ),
                Text(
                  '=',
                  style: TextStyle(fontSize: 30.0),
                ),
              ]
            : [
                GeneralTermWidget(
                  frac_x_numerator,
                  frac_x_denominator,
                  frac_x_power,
                  fontsize: 30.0,
                ),
                Text(
                  cal1_string,
                  style: TextStyle(fontSize: 30.0),
                ),
                Text(
                  '(',
                  style: TextStyle(fontSize: 30.0),
                ),
                GeneralTermWidget(
                  frac_y_numerator,
                  frac_y_denominator,
                  frac_y_power,
                  fontsize: 30.0,
                ),
                Text(
                  cal2_string,
                  style: TextStyle(fontSize: 30.0),
                ),
                GeneralTermWidget(
                  frac_z_numerator,
                  frac_z_denominator,
                  frac_z_power,
                  fontsize: 30.0,
                ),
                Text(
                  ')',
                  style: TextStyle(fontSize: 30.0),
                ),
                Text(
                  '=',
                  style: TextStyle(fontSize: 30.0),
                ),
              ],
      );

      choiceSet.add(realAnswer);

      // print(realAnswer);

      while (choiceSet.length < 4) {
        choiceSet.add(
          Random().nextBool()
              ? Fraction(realAnswer.numerator + Random().nextInt(20) - 10,
                      realAnswer.denominator + Random().nextInt(5) + 1)
                  .reduce()
              : Fraction(
                      (realAnswer.numerator + Random().nextInt(20) - 10) * -1,
                      realAnswer.denominator + Random().nextInt(5) + 1)
                  .reduce(),
        );
      }

      choiceList = [...choiceSet];
      choiceList.shuffle();
      // print(choiceList);

      choiceA_value = choiceList[0];
      choiceB_value = choiceList[1];
      choiceC_value = choiceList[2];
      choiceD_value = choiceList[3];

      choiceA_text = !choiceA_value.isNegative
          ? '+${choiceA_value.toString()}'
          : choiceA_value.toString();
      choiceB_text = !choiceB_value.isNegative
          ? '+${choiceB_value.toString()}'
          : choiceB_value.toString();
      choiceC_text = !choiceC_value.isNegative
          ? '+${choiceC_value.toString()}'
          : choiceC_value.toString();
      choiceD_text = !choiceD_value.isNegative
          ? '+${choiceD_value.toString()}'
          : choiceD_value.toString();
    }
  }

  //답 확인과 점수 관리 함수
  void checkAnswer(dynamic submittedAnswer, int plusScore, int minusScore) {
    checkBool = submittedAnswer == realAnswer ? true : false;
    if (checkBool) {
      score += plusScore;
      resetNumber();
    } else {
      if (score >= minusScore) {
        score -= minusScore;
      } else {
        score = 0;
      }
    }
  }
}
