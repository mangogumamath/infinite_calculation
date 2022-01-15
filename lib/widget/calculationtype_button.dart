import 'package:flutter/material.dart';

class CalculationTypeButton extends StatelessWidget {
  const CalculationTypeButton({
    Key? key,
    required this.backgroundColor,
    required this.topColor,
    required this.screen,
    required this.topChild,
    required this.bottomChild,
  }) : super(key: key);

  final Color backgroundColor;
  final Color topColor;
  final Widget screen;
  final Widget topChild;
  final Widget bottomChild;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Material(
        clipBehavior: Clip.antiAlias,
        borderRadius: BorderRadius.circular(10.0),
        color: backgroundColor,
        elevation: 3,
        child: InkWell(
          child: SizedBox(
            height: 300.0,
            width: 250.0,
            child: Column(
              children: [
                Expanded(
                  flex: 2,
                  child: Container(
                    height: double.infinity,
                    width: double.infinity,
                    color: topColor,
                    child: Center(child: topChild),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: bottomChild,
                  ),
                ),
              ],
            ),
          ),
          onTap: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => screen));
          },
        ),
      ),
    );
  }
}
