import 'package:flutter/material.dart';
import 'package:fraction/fraction.dart';
import 'package:infinite_calculation/constants.dart';
import 'package:infinite_calculation/model/config_data.dart';
import 'package:provider/provider.dart';

class FractionWidget extends StatelessWidget {
  FractionWidget(this.numerator, this.dinominator,
      {TextStyle? textStyle, Color? dividerColor, double? dividerWidth}) {
    fraction = Fraction(numerator, dinominator);
    sign = fraction.isNegative ? '-' : '';
    this.textStyle = textStyle ?? TextStyle(fontSize: 40.0);
    this.dividerColor = dividerColor ?? Colors.white;
    this.dividerWidth = dividerWidth ?? 40.0;
  }
  int numerator;
  int dinominator;
  Fraction fraction = Fraction(1, 2);
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
          children: [
            Text(
              sign,
              style: textStyle,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  fraction.numerator.abs().toString(),
                  style: textStyle,
                ),
                Container(
                  color: dividerColor,
                  width: dividerWidth,
                  height: dividerWidth * 0.15,
                ),
                Text(
                  fraction.denominator.abs().toString(),
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
