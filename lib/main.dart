import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculadora de IMC',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: CalculadoraImc(),
    );
  }
}

class CalculadoraImc extends StatefulWidget{
  const CalculadoraImc({super.key});
  @override
  State<CalculadoraImc> createState() {
    return _CalculadoraImcState();
  }
}

class _CalculadoraImcState extends State<CalculadoraImc> {
  @override
  Widget build(BuildContext context) => Scaffold(
    body: Container(),
  );
}