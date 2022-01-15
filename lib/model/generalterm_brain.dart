import 'dart:math';

import 'package:fraction/fraction.dart';

//여기가 주방. 계산은 여기서 처리하기.

class GeneralTermBrain {
  int numerator = 1;
  int denominator = 1;
  int power = 1;

  Fraction frac_x = Fraction(1);
  Fraction generalTerm_after = Fraction(1);

  void resetNumber() {
    // bool randomSignBool = Random().nextBool();

    numerator = Random().nextBool()
        ? Random().nextInt(9) + 1
        : (Random().nextInt(9) + 1) * -1;
    denominator = Random().nextInt(9) + 1;
    power = Random().nextInt(3) + 1 <= 1 ? 2 : 1;

    frac_x = Fraction(numerator, denominator).reduce();
    generalTerm_after = pow(frac_x.toDouble(), power).toFraction().reduce();
  }
}
