import 'package:flutter/material.dart';

class AlertMessage extends StatelessWidget {
  const AlertMessage({super.key, required this.message, this.colorResult});
  final String message;
  final Color? colorResult;

  @override
  Widget build(BuildContext context) {
    return Text(
      message,
      style: TextStyle(
        color: colorResult ?? Colors.grey[300],
        fontSize: 22,
        fontWeight: FontWeight.w500,
      ),
      textAlign: TextAlign.center,
    );
  }
}
