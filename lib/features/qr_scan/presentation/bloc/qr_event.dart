part of 'qr_bloc.dart';

abstract class QrEvent extends Equatable {
  const QrEvent();

  @override
  List<Object> get props => [];
}

class SaveQrCodeEvent extends QrEvent {
  final String code;

  const SaveQrCodeEvent(this.code);

  @override
  List<Object> get props => [code];
}
class LoadQrCodesEvent extends QrEvent {
  const LoadQrCodesEvent();
}