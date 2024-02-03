import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: "Calculator",
      home: Inicio(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class Inicio extends StatefulWidget {
  const Inicio({Key? key}) : super(key: key);

  @override
  _InicioState createState() => _InicioState();
}

class _InicioState extends State<Inicio> {
  TextEditingController controlainput = TextEditingController();
  double resultado = 0;
  String inputqueve = "";
  String operador = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 191, 191, 191),
      appBar: AppBar(
        title: const Text("Calculadora Basica"),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: controlainput,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
              ),
              textAlign: TextAlign.right,
              readOnly: true,
            ),
          ),
          const SizedBox(height: 20),
          misbotonsotes(["AC", "^", "%", "/"]),
          const SizedBox(height: 20),
          misbotonsotes(["7", "8", "9", "*"]),
          const SizedBox(height: 20),
          misbotonsotes(["4", "5", "6", "-"]),
          const SizedBox(height: 20),
          misbotonsotes(["1", "2", "3", "+"]),
          const SizedBox(height: 20),
          misbotonsotes([".", "0", "="]),
        ],
      ),
    );
  }

  Widget misbotonsotes(List<String> buttons) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: buttons
          .map((button) => SizedBox(
                height: 90,
                width: button == "=" ? 210 : 90,
                child: ElevatedButton(
                  onPressed: () {
                    agarrayverifica(button);
                  },
                  child: _buildButtonChild(button),
                ),
              ))
          .toList(),
    );
  }

  Widget _buildButtonChild(String buttonText) {
    switch (buttonText) {
      case "AC":
        return const Icon(Icons.refresh);
      case "^":
        return const Icon(Icons.exposure_plus_1);
      case "%":
        return const Icon(Icons.percent_outlined);
      case "/":
        return const Icon(Icons.sign_language);
      case "*":
        return const Icon(Icons.close);
      case "-":
        return const Icon(Icons.remove);
      case "+":
        return const Icon(Icons.add);
      case "=":
        return const Icon(Icons.check);
      default:
        return Text(buttonText);
    }
  }

  void agarrayverifica(String botonpresionado) {
    if (botonpresionado == "AC") {
      borrador();
    } else if (botonpresionado == "=") {
      calcuresultado();
    } else if (botonpresionado == "+" ||
        botonpresionado == "-" ||
        botonpresionado == "*" ||
        botonpresionado == "/" ||
        botonpresionado == "^") {
      daoperador(botonpresionado);
    } else {
      inputqueve += botonpresionado;
      controlainput.text = inputqueve;
    }
  }

  void daoperador(String operadorasig) {
    if (inputqueve.isNotEmpty) {
      operador = operadorasig;
      resultado = double.parse(inputqueve);
      inputqueve = "";
      controlainput.text = "";
    }
  }

  void borrador() {
    setState(() {
      inputqueve = "";
      resultado = 0;
      operador = "";
      controlainput.text = "";
    });
  }

  void calcuresultado() {
    if (inputqueve.isNotEmpty) {
      double input = double.parse(inputqueve);

      switch (operador) {
        case "+":
          resultado += input;
          break;
        case "-":
          resultado -= input;
          break;
        case "*":
          resultado *= input;
          break;
        case "/":
          resultado /= input;
          break;
        case "^":
          resultado = pow(resultado as num, input as num) as double;
          break;
        default:
          resultado = input;
      }

      setState(() {
        inputqueve = "";
        operador = "";
        controlainput.text = resultado.toString();
      });
    }
  }
}
