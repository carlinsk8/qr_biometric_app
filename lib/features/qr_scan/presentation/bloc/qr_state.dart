part of 'qr_bloc.dart';

abstract class QrState extends Equatable {
  const QrState();

  @override
  List<Object> get props => [];
}

class QrInitial extends QrState {}

class QrLoading extends QrState {}

class QrSaved extends QrState {}

class QrError extends QrState {}
class QrListLoaded extends QrState {
  final List<QrCode> qrCodes;

  const QrListLoaded(this.qrCodes);

  @override
  List<Object> get props => [qrCodes];
}

class QrErrorList extends QrState {}