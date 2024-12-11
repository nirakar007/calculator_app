import 'package:calculator_app/view/calculator_view.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: true,
      initialRoute: '/calculator-app',

      routes: {
        '/calculator-app': (context) => const CalculatorView(),
      },

    );
  }
}
