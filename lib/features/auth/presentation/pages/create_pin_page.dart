import 'package:flutter/material.dart';
import '../../../../core/platform_channels/biometric_auth_api.dart';
import '../../../qr_scan/presentation/pages/qr_list_page.dart';

import '../../../../core/services/secure_storage_service.dart';
import '../../../../core/widgets/secure_numeric_keyboard.dart';

class CreatePinPage extends StatefulWidget {
  const CreatePinPage({super.key});

  @override
  State<CreatePinPage> createState() => _CreatePinPageState();
}

class _CreatePinPageState extends State<CreatePinPage> {
  final List<String> _pin = [];
  final SecureStorageService _storageService = SecureStorageService.instance;
  final BiometricAuthApi _biometricAuthApi = BiometricAuthApi(); 

  void _onNumberPressed(String number) {
    if (_pin.length < 4) {
      setState(() {
        _pin.add(number);
      });

      if (_pin.length == 4) {
        _savePin();
      }
    }
  }

  void _onDelete() {
    if (_pin.isNotEmpty) {
      setState(() {
        _pin.removeLast();
      });
    }
  }

  Future<void> _savePin() async {
    final pin = _pin.join();
    await _storageService.savePin(pin);

    if (!mounted) return;

    final isAvailable = await _biometricAuthApi.authenticate();
    if (isAvailable) {
      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const QrListPage()),
      );
    } else {
      if (!mounted) return;
      Navigator.of(context).pushReplacementNamed('/pinAuth');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Crear PIN')),
      body: Padding(
        padding: const EdgeInsets.all(50),
        child: Column(
          children: [
            const Text(
              'Crea tu PIN',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            _buildPinDisplay(),
            const SizedBox(height: 40),
            SecureNumericKeyboard(
              onNumberPressed: _onNumberPressed,
              onDelete: _onDelete,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPinDisplay() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        4,
        (index) => Container(
          margin: const EdgeInsets.symmetric(horizontal: 10),
          width: 30,
          height: 30,
          decoration: BoxDecoration(
            color: index < _pin.length ? Theme.of(context).primaryColor : Colors.grey,
            shape: BoxShape.circle,
          ),
        ),
      ),
    );
  }
}
