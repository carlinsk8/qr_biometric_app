import 'dart:math';

import 'package:flutter/material.dart';

class SecureNumericKeyboard extends StatefulWidget {
  final void Function(String) onNumberPressed;
  final VoidCallback onDelete;

  const SecureNumericKeyboard({
    super.key,
    required this.onNumberPressed,
    required this.onDelete,
  });

  @override
  State<SecureNumericKeyboard> createState() => _SecureNumericKeyboardState();
}

class _SecureNumericKeyboardState extends State<SecureNumericKeyboard> {
  late List<String> shuffledNumbers;

  @override
  void initState() {
    super.initState();
    shuffledNumbers = _generateShuffledNumbers();
  }

  List<String> _generateShuffledNumbers() {
    final numbers = List.generate(10, (index) => index.toString());
    numbers.shuffle(Random());
    return numbers;
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      itemCount: 12, 
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 25,
        crossAxisSpacing: 25,
      ),
      itemBuilder: (context, index) {
        if (index < 9) {
          return _buildNumberButton(shuffledNumbers[index]);
        } else if (index == 9) {
          return const SizedBox.shrink(); // Botón vacío
        } else if (index == 10) {
          return _buildNumberButton(shuffledNumbers[9]);
        } else {
          return _buildDeleteButton();
        }
      },
    );
  }

  Widget _buildNumberButton(String number) {
    return ElevatedButton(
      onPressed: () => widget.onNumberPressed(number),
      child: Text(
        number,
        style: const TextStyle(fontSize: 32),
      ),
    );
  }

  Widget _buildDeleteButton() {
    return ElevatedButton(
      onPressed: widget.onDelete,
      child: const Icon(Icons.backspace_outlined, size: 32),
    );
  }
}
