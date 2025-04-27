import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import '../../../../core/widgets/secure_numeric_keyboard.dart';
import '../../../../core/services/secure_storage_service.dart';


class PinAuthPage extends StatefulWidget {
  const PinAuthPage({super.key});

  @override
  State<PinAuthPage> createState() => _PinAuthPageState();
}

class _PinAuthPageState extends State<PinAuthPage> {
  final List<String> _pin = [];
  String? _savedPin;
  String? _errorMessage;
  final sl = GetIt.instance;

  @override
  void initState() {
    super.initState();
    _loadSavedPin();
  }

  Future<void> _loadSavedPin() async {
    _savedPin = await sl<SecureStorageService>().getPin();
  }

  void _onKeyPressed(String value) {
    if (_pin.length < 4) {
      setState(() {
        _pin.add(value);
      });

      if (_pin.length == 4) {
        _validatePin();
      }
    }
  }

  void _validatePin() {
    final enteredPin = _pin.join();
    if (enteredPin == _savedPin) {
      Navigator.of(context).pushReplacementNamed('/qrList');
    } else {
      setState(() {
        _errorMessage = 'PIN incorrecto';
        _pin.clear();
      });
    }
  }

  void _onBackspacePressed() {
    if (_pin.isNotEmpty) {
      setState(() {
        _pin.removeLast();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Autenticación con PIN')),
      body: Padding(
        padding: const EdgeInsets.all(50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Ingrese su PIN', style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                4,
                (index) => Container(
                  margin: const EdgeInsets.all(8),
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: index < _pin.length ? Theme.of(context).primaryColor : Colors.grey,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 40),
            if (_errorMessage != null) ...[
              Text(_errorMessage!, style: const TextStyle(color: Colors.red)),
              const SizedBox(height: 10),
            ],
            SecureNumericKeyboard(
              onNumberPressed: _onKeyPressed,
              onDelete: _onBackspacePressed,
            ),
        
          ],
        ),
      ),
    );
  }
}
