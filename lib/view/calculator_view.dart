import 'package:flutter/material.dart';

class CalculatorView extends StatefulWidget {
  const CalculatorView({super.key});

  @override
  State<CalculatorView> createState() => _CalculatorViewState();
}

class _CalculatorViewState extends State<CalculatorView> {
  final TextEditingController _textController = TextEditingController();
  final TextEditingController _textController_expression = TextEditingController();
  List<String> lstSymbols = [
    "C", "*", "/", "<-", "1", "2", "3", "+", "4", "5", "6", "-", "7", "8", "9", "*", "%",
    "0", ".", "=",
  ];

  String input = "";
  double firstNum = 0;
  double secondNum = 0;
  String operation = "";
  bool isResultDisplayed = false;

  void _handleButtonPress(String symbol) {

    if (symbol == "C") {
      _textController.clear();
      _textController_expression.clear();
      firstNum = 0;
      secondNum = 0;
      operation = "";
      isResultDisplayed = false;

    } else if (symbol == "<-") {

      String currentText = _textController.text;
      if (currentText.isNotEmpty) {
        _textController.text = currentText.substring(0, currentText.length - 1);
        _textController_expression.text = currentText.substring(0, currentText.length - 1);
      }
    } else if (symbol == "=") {

      _calculateResult();
    } else if (symbol == "+" || symbol == "-" || symbol == "*" || symbol == "/") {
      firstNum = double.tryParse(_textController.text) ?? 0;
      operation = symbol;
      _textController.clear();
      _textController_expression.text += symbol;
    } else {

      if (isResultDisplayed) {
        _textController.text = symbol;
        _textController_expression.text += symbol;
        isResultDisplayed = false;
      } else {
        _textController.text += symbol;
        _textController_expression.text += symbol;
      }
    }
  }

  void _calculateResult() {
    secondNum = double.tryParse(_textController.text) ?? 0;
    double result = 0;


    if (operation == "+") {
      result = firstNum + secondNum;
    } else if (operation == "-") {
      result = firstNum - secondNum;
    } else if (operation == "*") {
      result = firstNum * secondNum;
    } else if (operation == "/") {
      if (secondNum != 0) {
        result = firstNum / secondNum;
      } else {
        _textController.text = "Error";
        isResultDisplayed = true;
        return;
      }
    }


    _textController.text = result.toString();
    isResultDisplayed = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nirakar s Calculator '),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              controller: _textController_expression,
              readOnly: true,
              textDirection: TextDirection.rtl,
              decoration: const InputDecoration(
                // border: OutlineInputBorder(),
              ),
              style: const TextStyle(
                fontSize: 20,
                color: Colors.grey,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _textController,
              readOnly: true,
              textDirection: TextDirection.rtl,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
              ),
              style: const TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),


            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                ),
                itemCount: lstSymbols.length,
                itemBuilder: (context, index) {
                  return ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(165, 75, 255, 160),
                      foregroundColor: const Color.fromARGB(255, 255, 255, 255),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {
                      String symbol = lstSymbols[index];
                      _handleButtonPress(symbol);
                    },
                    child: Text(
                      lstSymbols[index],
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
