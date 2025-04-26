import 'package:equatable/equatable.dart';

class QrCode extends Equatable {
  final int? id; // Puede ser nulo porque en SQLite el ID se genera automáticamente
  final String code; // El contenido del QR
  final String timestamp; // Fecha y hora cuando se escaneó

  const QrCode({
    this.id,
    required this.code,
    required this.timestamp,
  });

  @override
  List<Object?> get props => [id, code, timestamp];
}
