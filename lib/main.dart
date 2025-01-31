import 'package:flutter/material.dart';
import 'package:expressions/expressions.dart';

void main() {
  runApp(const CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  const CalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculator - Jad Albatal',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String _expression = '';
  String _accumulator = '';

  void _onButtonPressed(String value) {
    setState(() {
      if (value == 'C') {
        _expression = '';
        _accumulator = '';
      } else if (value == '=') {
        try {
          final parsedExpression = Expression.parse(_expression);
          final evaluator = const ExpressionEvaluator();
          final result = evaluator.eval(parsedExpression, {});
          _accumulator = '$_expression = $result';
          _expression = result.toString();
        } catch (e) {
          _accumulator = 'Error';
          _expression = '';
        }
      } else {
        _expression += value;
      }
    });
  }

  Widget _buildButton(String label) {
    return ElevatedButton(
      onPressed: () => _onButtonPressed(label),
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.all(20),
        textStyle: const TextStyle(fontSize: 24),
      ),
      child: Text(label),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Calculator - Jad Albatal')),
      body: Column(
        children: [
          Expanded(
            child: Container(
              alignment: Alignment.bottomRight,
              padding: const EdgeInsets.all(24),
              child: Text(
                _accumulator,
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Expanded(
            child: Container(
              alignment: Alignment.bottomRight,
              padding: const EdgeInsets.all(24),
              child: Text(
                _expression,
                style: const TextStyle(fontSize: 32),
              ),
            ),
          ),
          Container(
            width: 300,
            child: GridView.count(
              shrinkWrap: true,
              crossAxisCount: 4,
              children: [
                _buildButton('7'), _buildButton('8'), _buildButton('9'), _buildButton('/'),
                _buildButton('4'), _buildButton('5'), _buildButton('6'), _buildButton('*'),
                _buildButton('1'), _buildButton('2'), _buildButton('3'), _buildButton('-'),
                _buildButton('0'), _buildButton('C'), _buildButton('='), _buildButton('+'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
