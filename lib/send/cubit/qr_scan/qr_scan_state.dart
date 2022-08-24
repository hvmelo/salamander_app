part of 'qr_scan_cubit.dart';

abstract class QRScanState extends Equatable {
  QRScanState();
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  @override
  List<Object> get props => [qrKey];
}

class QRScanInitial extends QRScanState {}

class QRScanCodeRead extends QRScanState {
  QRScanCodeRead(this.qrResult);
  final Barcode qrResult;
}

class QRScanInvalidAddress extends QRScanState {}
