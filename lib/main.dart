import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculadora de IMC',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      home: CalculadoraImc(),
    );
  }
}

class CalculadoraImc extends StatefulWidget {
  const CalculadoraImc({super.key});
  @override
  State<CalculadoraImc> createState() {
    return _CalculadoraImcState();
  }
}

class _CalculadoraImcState extends State<CalculadoraImc> {
  late final TextEditingController pesoController;
  late final TextEditingController alturaController;

  @override
  void initState() {
    pesoController = TextEditingController(text: '');
    alturaController = TextEditingController(text: '');
    super.initState();
  }

  @override
  void dispose() {
    pesoController.dispose();
    alturaController.dispose();
    super.dispose();
  }

  double? imc;
  String? category;
  Color colorResult = Colors.green;
  String message = 'Digite o seu peso\ne a sua altura';

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: Colors.grey[200],
    body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                border: Border.all(width: 10, color: colorResult),
                borderRadius: BorderRadius.circular(150),
              ),
              child: imc == null
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      spacing: 6,
                      children: [
                        // Icon(
                        //   Icons.play_circle,
                        //   size: 60,
                        //   color: Colors.grey[400],
                        // ),
                        Text(
                          message,
                          style: TextStyle(
                            color: colorResult,
                            fontSize: 22,
                            fontWeight: FontWeight.w500,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          '${imc?.toStringAsFixed(2)}',
                          style: TextStyle(
                            color: colorResult,
                            fontSize: 42,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '$category',
                          style: TextStyle(color: colorResult, fontSize: 20),
                        ),
                      ],
                    ),
            ),
            SizedBox(height: 40),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 85,
              height: 40,
              child: TextField(
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*$')),
                  LengthLimitingTextInputFormatter(4),
                ],
                controller: pesoController,
                style: TextStyle(fontSize: 16),
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(150),
                  ),
                  // labelText: 'Peso',
                  labelText: 'Peso',
                  suffixText: 'kg',
                ),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
              ),
            ),
            SizedBox(width: 32, child: Icon(Icons.arrow_forward, size: 22)),
            SizedBox(
              width: 85,
              height: 40,
              child: TextField(
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*$')),
                  LengthLimitingTextInputFormatter(4),
                ],
                controller: alturaController,
                style: TextStyle(fontSize: 16),
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(150),
                  ),
                  // labelText: 'Peso',
                  labelText: 'Altura',
                  suffixText: 'm',
                ),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
              ),
            ),
          ],
          // Text('Seu peso'),
        ),
        SizedBox(height: 16),
        SizedBox(
          width: 220,
          height: 52,
          child: FilledButton(
            onPressed: () {
              try {
                double peso = double.parse(pesoController.text);
                double altura = double.parse(alturaController.text);
                double calcImc = peso / (altura * altura);
                String categoryFinal = getClassificacaoImc(calcImc);
                setState(() {
                  imc = calcImc;
                  category = categoryFinal;
                  colorResult = getColorFromCategory(categoryFinal);
                });
              } on Exception {
                setState(() {
                  message = 'Digite os valores';
                  colorResult = Colors.red;
                  imc = null;
                  category = null;
                });
              }
            },
            child: Text('Calcular'),
          ),
        ),
      ],
    ),
  );

  String getClassificacaoImc(double imc) {
    if (imc < 18.5) {
      return 'Abaixo do peso';
    } else if (imc >= 18.5 && imc <= 24.9) {
      return 'Peso normal';
    } else if (imc >= 25 && imc <= 29.9) {
      return 'Sobrepeso';
    } else if (imc >= 30 && imc <= 34.9) {
      return 'Obesidade grau I';
    } else if (imc >= 35 && imc <= 39.9) {
      return 'Obesidade grau II';
    } else {
      return 'Obesidade grau III';
    }
  }

  Color getColorFromCategory(String category) {
    switch (category) {
      case 'Abaixo do peso':
        return Colors.blue;
      case 'Peso normal':
        return Colors.green;
      case 'Sobrepeso':
        return Colors.amber;
      case 'Obesidade grau I':
        return Colors.grey;
      case 'Obesidade grau II':
        return Colors.blueGrey;
      case 'Obesidade grau III':
        return Colors.red;
    }
    return Colors.green;
  }
}
