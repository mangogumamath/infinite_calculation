import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class TestPage extends StatefulWidget {
  const TestPage({Key? key}) : super(key: key);

  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  // final calBrain = CalculationBrain(calculationType: CalculationType.mix);

  SMIBool? _bump;

  void _onRiveInit(Artboard artboard) {
    final controller =
        StateMachineController.fromArtboard(artboard, 'State Machine 1');
    artboard.addController(controller!);
    _bump = controller.findInput<bool>('Pressed') as SMIBool;
  }

  void _hitBump() {
    if (_bump != null) {
      _bump!.value = !_bump!.value;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: GestureDetector(
          child: RiveAnimation.asset(
            'assets/rive/cool_icon.riv',
            fit: BoxFit.contain,
            onInit: _onRiveInit,
          ),
          onTap: _hitBump,
        ),
      ),
    );
  }
}
