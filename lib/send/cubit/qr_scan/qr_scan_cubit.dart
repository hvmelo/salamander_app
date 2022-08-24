import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

part 'qr_scan_state.dart';

class QRScanCubit extends Cubit<QRScanState> {
  QRScanCubit() : super(QRScanInitial());

  QRViewController? _qrViewController;

  void qrViewCreated(QRViewController? qrViewController) async {
    _qrViewController = qrViewController;
    await _qrViewController?.resumeCamera();
    _qrViewController?.scannedDataStream.listen(handleScanData);
  }

  void handleScanData(Barcode scanData) {}
}
