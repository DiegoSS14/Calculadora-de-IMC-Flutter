import 'package:calculadora_imc/alert_message.dart';
import 'package:flutter/material.dart';

class InfoImc extends StatelessWidget {
  const InfoImc({
    super.key,
    required this.colorResult,
    required this.imc,
    required this.message,
    required this.category,
  });

  final Color colorResult;
  final double imc;
  final String message;
  final String category;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 300,
      decoration: BoxDecoration(
        border: Border.all(width: 10, color: colorResult),
        borderRadius: BorderRadius.circular(150),
      ), child :
          imc == 0
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  spacing: 6,
                  children: [
                    AlertMessage(message: message, colorResult: colorResult,)
                  ],
                ) :
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                imc.toStringAsFixed(2),
                style: TextStyle(
                  color: colorResult,
                  fontSize: 42,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                category,
                style: TextStyle(color: colorResult, fontSize: 20),
              ),
            ],
          ),
    );
  }
}
