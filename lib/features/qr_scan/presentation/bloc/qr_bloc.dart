import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import '../../domain/entities/qr_code.dart';
import '../../domain/usecases/get_all_qr_codes.dart';
import '../../domain/usecases/save_qr_code.dart';

part 'qr_event.dart';
part 'qr_state.dart';

class QrBloc extends Bloc<QrEvent, QrState> {
  final SaveQrCodeUseCase saveQrCodeUseCase;
  final GetAllQrCodesUseCase getAllQrCodes;


  QrBloc({required this.saveQrCodeUseCase, required this.getAllQrCodes}) : super(QrInitial()) {
    on<SaveQrCodeEvent>((event, emit) async {
      emit(QrLoading());

      try {
        // Aquí puedes guardar el código QR en la base de datos
        await saveQrCodeUseCase.call(event.code);
        // Luego de guardar, puedes cargar todos los códigos QR
        final qrCodes = await getAllQrCodes();
        emit(QrListLoaded(qrCodes));
      } catch (_) {
        emit(QrError());
      }
    });
    on<LoadQrCodesEvent>((event, emit) async {
      emit(QrLoading());
      try {
        final qrCodes = await getAllQrCodes();
        emit(QrListLoaded(qrCodes));
        
      } catch (e) {
        debugPrint('Error cargando QR: $e'); 
        emit(QrErrorList());
      }
    });
  }
}
