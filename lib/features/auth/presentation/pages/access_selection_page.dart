// lib/features/auth/presentation/pages/access_selection_page.dart

import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

import '../../../../core/platform_channels/biometric_auth_api.dart';
import '../../../../core/services/secure_storage_service.dart';


class AccessSelectionPage extends StatefulWidget {
  const AccessSelectionPage({super.key});

  @override
  State<AccessSelectionPage> createState() => _AccessSelectionPageState();
}

class _AccessSelectionPageState extends State<AccessSelectionPage> {
  bool _hasPin = false;

  @override
  void initState() {
    super.initState();
    _checkHasPin();
  }

  Future<void> _checkHasPin() async {
    final result = await SecureStorageService.instance.hasPin();
    setState(() {
      _hasPin = result;
    });
  }

  void _onBiometricPressed() async {
    final isAvailable = await BiometricAuthApi().authenticate();

    if (!mounted) return;

    if (isAvailable) {
      Navigator.of(context).pushReplacementNamed('/qrList');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Falló la autenticación biométrica')),
      );
    }
  }

  void _onPinPressed() {
    Navigator.of(context).pushReplacementNamed('/pinAuth');
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32.0),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.fingerprint, size: 100, color: theme.primaryColor),
              const SizedBox(height: 24),
              Text(
                'Bienvenido a\nEscaneo de Códigos QR',
                style: theme.textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                  color: AppColors.textPrimary,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Text(
                'Accede de forma segura usando tu huella digital o PIN.',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: AppColors.textSecondary,
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: _onBiometricPressed,
                child: const Text('Autenticar con biometría'),
              ),
              if (_hasPin) ...[
                const SizedBox(height: 16),
                TextButton(
                  onPressed: _onPinPressed,
                  child: const Text('¿Prefieres usar PIN?'),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
