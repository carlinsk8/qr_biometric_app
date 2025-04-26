import 'package:flutter/material.dart';

class BiometricButton extends StatelessWidget {
  final VoidCallback onPressed;

  const BiometricButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      icon: const Icon(Icons.fingerprint, size: 32),
      label: const Text(
        'Iniciar sesión con biometría',
        style: TextStyle(fontSize: 18),
      ),
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      ),
      onPressed: onPressed,
    );
  }
}
