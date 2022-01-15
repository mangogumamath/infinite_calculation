import 'package:flutter/material.dart';
import 'package:fraction/fraction.dart';
import 'package:infinite_calculation/constants.dart';
import 'package:infinite_calculation/model/config_data.dart';
import 'package:provider/provider.dart';

class FractionReducedWidget extends StatelessWidget {
  FractionReducedWidget(this.numerator, this.dinominator,
      {TextStyle? textStyle, Color? dividerColor, double? dividerWidth}) {
    fraction_reduced = Fraction(numerator, dinominator).reduce();
    sign = fraction_reduced.isNegative ? '-' : '';
    whole = fraction_reduced.isWhole;
    this.textStyle = textStyle == null ? TextStyle(fontSize: 40.0) : textStyle;
    this.dividerColor = dividerColor == null ? Colors.white : dividerColor;
    this.dividerWidth = dividerWidth == null ? 40.0 : dividerWidth;
  }
  int numerator;
  int dinominator;
  bool whole = false;
  Fraction fraction_reduced = Fraction(1);
  String sign = '';
  TextStyle textStyle = TextStyle(fontSize: 40.0);
  Color dividerColor = Colors.white;
  double dividerWidth = 40.0;
  bool _isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    _isDarkMode = Provider.of<ConfigData>(context).isDarkMode;
    if (dividerColor == Colors.white) {
      dividerColor = !_isDarkMode ? workShopBlack : Color(0xffffffff);
    }
    return Container(
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: whole
              ? [
                  Text(
                    sign,
                    style: textStyle,
                  ),
                  Text(
                    fraction_reduced.numerator.abs().toString(),
                    style: textStyle,
                  ),
                ]
              : [
                  Text(
                    sign,
                    style: textStyle,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        fraction_reduced.numerator.abs().toString(),
                        style: textStyle,
                      ),
                      Container(
                        color: dividerColor,
                        width: dividerWidth,
                        height: dividerWidth * 0.15,
                      ),
                      Text(
                        fraction_reduced.denominator.abs().toString(),
                        style: textStyle,
                      ),
                    ],
                  )
                ],
        ),
      ),
      // width: 30.0,
      // height: 40.0,
    );
  }
}
