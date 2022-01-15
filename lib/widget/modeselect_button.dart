import 'package:flutter/material.dart';

class modeSelectbutton extends StatelessWidget {
  modeSelectbutton({required this.moveScreen, required this.text});

  Widget moveScreen;
  String text;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      // style: modeSelectButtonStyle,
      child: SizedBox(
        height: 80.0,
        child: Center(
          child: Text(
            text,
            style: TextStyle(
                fontSize: 30.0, color: Theme.of(context).colorScheme.onSurface),
          ),
        ),
      ),
      onPressed: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => moveScreen));
      },
    );
  }
}
