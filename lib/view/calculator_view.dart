import 'package:flutter/material.dart';

class CalculatorView extends StatefulWidget {
  const CalculatorView({super.key});

  @override
  State<CalculatorView> createState() => _CalculatorViewState();
}

class _CalculatorViewState extends State<CalculatorView> {
  final _textController = TextEditingController();
  String displayInput = ""; // To show the current input for calculation
  bool isNewInput = false; // Flag to track if a new input sequence is starting

  List<String> lstSymbols = [
    "C",
    "*",
    "/",
    "<-",
    "1",
    "2",
    "3",
    "+",
    "4",
    "5",
    "6",
    "-",
    "7",
    "8",
    "9",
    "*",
    "%",
    "0",
    ".",
    "=",
  ];

  final _key = GlobalKey<FormState>();

  // Handles button presses
  void _handleButtonPress(String symbol) {
    setState(() {
      switch (symbol) {
        case "C":
          _textController.clear();
          displayInput = "";
          isNewInput = false; // Reset the flag
          break;

        case "<-":
          if (_textController.text.isNotEmpty) {
            _textController.text = _textController.text.substring(0, _textController.text.length - 1);
          }
          break;

        case "=":
          _textController.text = _calculateResult();
          displayInput = ""; // Clear display after calculation
          isNewInput = true; // Set flag to true after calculation
          break;

        default:
        // Clear input if starting a new sequence
          if (isNewInput) {
            _textController.clear();
            isNewInput = false; // Reset the flag
          }
          _textController.text += symbol;
          displayInput = _textController.text; // Update the displayInput
      }
    });
  }

  String _calculateResult() {
    String input = _textController.text;

    // Check if input contains an operation
    for (String op in ["+", "-", "*", "/", "%"]) {
      if (input.contains(op)) {
        // Split the input into operands based on the operator
        List<String> parts = input.split(op);
        if (parts.length == 2) {
          // Parse the operands
          double firstOperand = double.tryParse(parts[0].trim()) ?? 0;
          double secondOperand = double.tryParse(parts[1].trim()) ?? 0;

          // Perform the calculation based on the operation
          switch (op) {
            case "+":
              return (firstOperand + secondOperand).toString();

            case "-":
              return (firstOperand - secondOperand).toString();

            case "*":
              return (firstOperand * secondOperand).toString();

            case "/":
              return secondOperand != 0
                  ? (firstOperand / secondOperand).toString()
                  : "Error"; // Handle zero division

            case "%":
              return (firstOperand % secondOperand).toString();
          }
        }
      }
    }
    // Invalid operation
    return input;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculator App'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _key,
          child: Column(
            children: [
              // Display the input being stored for calculation
              Text(
                displayInput,
                textAlign: TextAlign.right,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 8),

              // Input field
              TextFormField(
                textDirection: TextDirection.rtl, // Start text input from the right
                controller: _textController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
                style: const TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 8,
              ),

              // Grid of buttons
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
                        backgroundColor: Colors.lightGreen,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0),
                        ),
                      ),
                      onPressed: () {
                        _handleButtonPress(lstSymbols[index]);
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
      ),
    );
  }
}
