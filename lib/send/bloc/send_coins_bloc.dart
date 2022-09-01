import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:salamander_app/data/repositories/wallet_repository.dart';

part 'send_coins_event.dart';
part 'send_coins_state.dart';

class SendCoinsBloc extends Bloc<SendCoinsEvent, SendCoinsState> {
  SendCoinsBloc({required WalletRepository walletRepository})
      : _walletRepository = walletRepository,
        super(const SendCoinsState()) {
    on<ManualEntryRequested>(_onManualEntryRequested);
    on<QRScanRequested>(_onQRScanRequested);
    on<QRCodeRead>(_onQRCodeRead);
    on<QRViewCreated>(_onQRCodeCreated);
    on<InputAddressChanged>(_onInputAddressChanged);
    on<PasteFromClipboardRequested>(_onPasteFromClipboardRequested);
  }

  final WalletRepository _walletRepository;
  QRViewController? _qrViewController;

  void _onManualEntryRequested(
      ManualEntryRequested event, Emitter<SendCoinsState> emit) {
    _qrViewController?.stopCamera();
    emit(SendCoinsManualEnterState.initial);
  }

  void _onQRScanRequested(QRScanRequested event, Emitter<SendCoinsState> emit) {
    emit(SendCoinsQRReadState.initial);
  }

  void _onQRCodeRead(QRCodeRead event, Emitter<SendCoinsState> emit) {}

  void _onInputAddressChanged(
      InputAddressChanged event, Emitter<SendCoinsState> emit) {
    var theState = state as SendCoinsManualEnterState;
    emit(theState.copyWith(value: event.address));
  }

  void _onPasteFromClipboardRequested(
      PasteFromClipboardRequested event, Emitter<SendCoinsState> emit) {
    var copiedtext = event.text;
    var theState = state as SendCoinsManualEnterState;
    emit(theState.copyWith(value: copiedtext));
  }

  Future<void> _onQRCodeCreated(
      QRViewCreated event, Emitter<SendCoinsState> emit) async {
    _qrViewController = event.controller;
    _qrViewController?.scannedDataStream.listen(handleScanData);
  }

  void handleScanData(Barcode scanData) {}
}
