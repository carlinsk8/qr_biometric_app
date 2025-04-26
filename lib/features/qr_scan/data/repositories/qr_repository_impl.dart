import '../../domain/entities/qr_code.dart';
import '../../domain/repositories/qr_repository.dart';
import '../datasources/qr_local_datasource.dart';

class QrRepositoryImpl implements QrRepository {
  final QrLocalDatasource localDatasource;

  QrRepositoryImpl(this.localDatasource);

  @override
  Future<void> saveQrCode(String code) async {
    await localDatasource.saveQrCode(code);
  }
  @override
  Future<List<QrCode>> getAllQrCodes() async {
    final List<QrCode> qrCodeModels = await localDatasource.getAllQrCodes();
    return qrCodeModels;
  }
}
