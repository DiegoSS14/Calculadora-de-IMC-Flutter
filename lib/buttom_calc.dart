import 'package:flutter/material.dart';

class ButtomCalc extends StatelessWidget {
  const ButtomCalc({
    super.key, 
    required this.onPressed
    });

  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
          width: 220,
          height: 52,
          child: FilledButton(
            onPressed: () => onPressed(),
            style: FilledButton.styleFrom(
              backgroundColor: Colors.purple,
              elevation: 4,
              shadowColor: Colors.grey[100],
            ),
            child: Text('Calcular'),
          ),
        );
  }
}