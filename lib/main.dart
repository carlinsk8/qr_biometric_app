import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/routes/app_routes.dart';
import 'core/theme/app_theme.dart';
import 'injection_container.dart' as di;

import 'features/auth/presentation/bloc/auth_bloc.dart';
import 'features/qr_scan/presentation/bloc/qr_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (_) => di.sl<AuthBloc>(),
        ),
        BlocProvider<QrBloc>(
          create: (_) => di.sl<QrBloc>(),
        ),
      ],
      child: MaterialApp(
        title: 'Escaneo de Códigos QR',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        initialRoute: '/splash',
        routes: AppRoutes.routes,
      ),
    );
  }
}
