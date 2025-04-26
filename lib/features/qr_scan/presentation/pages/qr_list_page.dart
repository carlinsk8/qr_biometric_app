import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utils/date_time_format.dart';
import '../../../../core/platform_channels/qr_scanner_channel.dart';
import '../bloc/qr_bloc.dart';
import '../../domain/entities/qr_code.dart';

class QrListPage extends StatefulWidget {
  const QrListPage({super.key});

  @override
  State<QrListPage> createState() => _QrListPageState();
}

class _QrListPageState extends State<QrListPage> {
  bool _isScanning = false;
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      if (!mounted) return;
      context.read<QrBloc>().add(LoadQrCodesEvent());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Historial de Códigos QR')),
      floatingActionButton: FloatingActionButton(
        onPressed: _startScan,
        child: const Icon(Icons.qr_code_scanner),
      ),

      body: BlocBuilder<QrBloc, QrState>(
        builder: (context, state) {
          if (state is QrInitial) {
            return const Center(child: Text('No hay datos'));
          } else if (state is QrLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is QrListLoaded) {
            final qrCodes = state.qrCodes;
            if (qrCodes.isEmpty) {
              return const Center(child: Text('No hay códigos QR guardados'));
            }
            return ListView.builder(
              itemCount: qrCodes.length,
              itemBuilder: (context, index) {
                final qrCode = qrCodes[index];
                return _itemBuilder(qrCode);
              },
            );
          } else if (state is QrErrorList) {
            return const Center(
              child: Text('Ocurrió un error cargando los QR'),
            );
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }

  Card _itemBuilder(QrCode qrCode) {
    return Card(
      color: Colors.black.withAlpha(70),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        title: Text(qrCode.code, style: Theme.of(context).textTheme.bodyLarge),
        subtitle: Text(
          qrCode.timestamp.toFormattedDateTime(),
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        leading: const Icon(Icons.qr_code),
      ),
    );
  }

  Future<void> _startScan() async {
    if (_isScanning) return;

    setState(() {
      _isScanning = true;
    });

    try {
      final result = await QrScannerChannel.scanQrCode();

      if (result != null && result.isNotEmpty) {
        if (!mounted) return;
        context.read<QrBloc>().add(SaveQrCodeEvent(result));
      } else {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('No se detectó un QR válido')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error escaneando el código QR')),
      );
    } finally {
      setState(() {
        _isScanning = false;
      });
    }
  }
}
