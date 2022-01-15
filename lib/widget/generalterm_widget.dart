import 'package:flutter/material.dart';
import 'package:fraction/fraction.dart';
import 'package:infinite_calculation/widget/fraction_reduced_widget.dart';
import 'package:infinite_calculation/widget/powerwidget.dart';

class GeneralTermWidget extends StatelessWidget {
  GeneralTermWidget(this.numerator, this.denominator, this.power,
      {double? fontsize}) {
    frac = Fraction(numerator, denominator).reduce();
    this.fontsize = fontsize == null ? 40.0 : fontsize;
  }
  int numerator;
  int denominator;
  int power;
  double fontsize = 40.0;

  Fraction frac = Fraction(1);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: power == 1 // p가 1인가?
          ? (frac.isNegative // p가 1이고 분수가 음수인가?
              ? [
                  Text(
                    '(',
                    style: TextStyle(
                      fontSize: fontsize,
                    ),
                  ),
                  FractionReducedWidget(
                    frac.numerator,
                    frac.denominator,
                    textStyle: TextStyle(fontSize: fontsize),
                    dividerWidth: fontsize * 1,
                  ),
                  Text(
                    ')',
                    style: TextStyle(
                      fontSize: fontsize,
                    ),
                  ),
                ] //괄호를 쳐라
              : [
                  FractionReducedWidget(
                    frac.numerator,
                    frac.denominator,
                    textStyle: TextStyle(fontSize: fontsize),
                    dividerWidth: fontsize * 1,
                  ),
                ]) //p가 1이고 분수가 음수가 아니므로 그냥 써라
          : (frac.isNegative // p가 1이 아니고 분수가 음수인가?
              ? [
                  Text(
                    '(',
                    style: TextStyle(
                      fontSize: fontsize,
                    ),
                  ),
                  FractionReducedWidget(
                    frac.numerator,
                    frac.denominator,
                    textStyle: TextStyle(fontSize: fontsize),
                    dividerWidth: fontsize * 1,
                  ),
                  Text(
                    ')',
                    style: TextStyle(
                      fontSize: fontsize,
                    ),
                  ),
                  PowerWidget(
                    power: power,
                    textStyle: TextStyle(
                      fontSize: fontsize * 0.75,
                    ),
                  ),
                ] // 괄호를 쳐라
              : frac.isWhole //p가 1이 아니고 분수가 음수가 아닌데 정수인가?
                  ? [
                      FractionReducedWidget(
                        frac.numerator,
                        frac.denominator,
                        textStyle: TextStyle(fontSize: fontsize),
                        dividerWidth: fontsize * 1,
                      ),
                      PowerWidget(
                        power: power,
                        textStyle: TextStyle(
                          fontSize: fontsize * 0.75,
                        ),
                      ),
                    ] // 정수면 괄호를 치지 마라.
                  : [
                      Text(
                        '(',
                        style: TextStyle(
                          fontSize: fontsize,
                        ),
                      ),
                      FractionReducedWidget(
                        frac.numerator,
                        frac.denominator,
                        textStyle: TextStyle(fontSize: fontsize),
                        dividerWidth: fontsize * 1,
                      ),
                      Text(
                        ')',
                        style: TextStyle(
                          fontSize: fontsize,
                        ),
                      ),
                      PowerWidget(
                        power: power,
                        textStyle: TextStyle(
                          fontSize: fontsize * 0.75,
                        ),
                      ),
                    ] // p가 1이 아니고 분수가 음수가 아닌데 정수가 아니면 괄호 쳐라
          ),
    );
  }
}
