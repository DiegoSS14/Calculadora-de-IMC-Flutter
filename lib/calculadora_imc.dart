import 'package:calculadora_imc/buttom_calc.dart';
import 'package:calculadora_imc/info_imc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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

  late double imc = 0;
  late String category = '';
  late Color colorResult = Colors.green;
  late String message = 'Digite o seu peso\ne a sua altura';

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

  double valorPeso = 75;
  double valorAltura = 1.70;

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
            InfoImc(
              colorResult: colorResult,
              category: category,
              imc: imc,
              message: message,
            ),
            SizedBox(height: 40),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                children: [
                  SizedBox(
                    width: 96,
                    height: 40,
                    child: TextField(
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                          RegExp(r'^\d*\.?\d*$'),
                        ),
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
                      keyboardType: TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                    ),
                  ),
                  SliderTheme(
                    data: SliderThemeData(
                      trackHeight: 2,
                      activeTrackColor: Colors.purple,
                    ),
                    child: Slider(
                      value: valorPeso,
                      onChanged: (peso) {
                        setState(() {
                          valorPeso = peso;
                          pesoController.text = valorPeso.toStringAsFixed(1);
                        });
                      },
                      semanticFormatterCallback: (value) =>
                          '${valorPeso.toStringAsFixed(1)}kg',
                      min: 30,
                      max: 300,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 6),
            Expanded(
              child: Column(
                children: [
                  SizedBox(
                    width: 96,
                    height: 40,
                    child: TextField(
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                          RegExp(r'^\d*\.?\d*$'),
                        ),
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
                      keyboardType: TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                    ),
                  ),
                  SliderTheme(
                    data: SliderThemeData(
                      trackHeight: 2,
                      activeTrackColor: Colors.purple,
                    ),
                    child: Slider(
                      value: valorAltura,
                      onChanged: (altura) {
                        setState(() {
                          valorAltura = altura;
                          alturaController.text = valorAltura.toStringAsFixed(
                            2,
                          );
                        });
                      },
                      semanticFormatterCallback: (value) =>
                          '${valorAltura.toStringAsFixed(2)} m',
                      min: 0.6,
                      max: 4.0,
                    ),
                  ),
                ],
              ),
            ),
          ],
          // Text('Seu peso'),
        ),
        SizedBox(height: 16),
        ButtomCalc(
          onPressed: () {
            double peso = double.parse(pesoController.text);
            double altura = double.parse(alturaController.text);
            double calcImc = peso / (altura * altura);
            String categoryFinal = getClassificacaoImc(calcImc);
            setState(() {
              imc = calcImc;
              category = categoryFinal;
              colorResult = getColorFromCategory(categoryFinal);
            });
          },
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
