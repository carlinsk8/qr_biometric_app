// lib/features/splash/presentation/pages/splash_page.dart

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:qr_biometric_app/core/theme/app_colors.dart';

import '../../../../core/services/secure_storage_service.dart';
import '../../../../injection_container.dart';


class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    _startFlow();
  }

  Future<void> _startFlow() async {
    final tokenResult = await sl<SecureStorageService>().hasAuthToken();
    await Future.delayed(const Duration(seconds: 2));
    
    if (tokenResult) {
      // Si el token existe, redirigir a la página de QR
      if (!mounted) return;
      Navigator.of(context).pushReplacementNamed('/qrList');
    } else {
      // Si no existe, redirigir a la página de selección de acceso
      if (!mounted) return;
      Navigator.of(context).pushReplacementNamed('/accessSelection');
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.qr_code, size: 100, color: AppColors.primary,),
            Text(
              'Escaneo de Códigos QR',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 30),
            const CircularProgressIndicator(color: AppColors.primary),
          ],
        ),
      ),
    );
  }
}
