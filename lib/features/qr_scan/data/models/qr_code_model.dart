import '../../domain/entities/qr_code.dart';

class QrCodeModel extends QrCode {
  const QrCodeModel({
    super.id,
    required super.code,
    required super.timestamp,
  });

  factory QrCodeModel.fromMap(Map<String, dynamic> map) {
    return QrCodeModel(
      id: map['id'] as int?,
      code: map['code']?.toString() ?? '',
      timestamp: map['timestamp']?.toString() ?? '',
    );
  }



  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'code': code,
      'timestamp': timestamp,
    };
  }
}
