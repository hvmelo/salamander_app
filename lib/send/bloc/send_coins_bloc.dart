import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import '../../data/repositories/wallet_repository.dart';

part 'send_coins_event.dart';
part 'send_coins_state.dart';

class SendCoinsBloc extends Bloc<SendCoinsEvent, SendCoinsState> {
  SendCoinsBloc({required WalletRepository walletRepository})
      : _walletRepository = walletRepository,
        super(SendCoinsInitial()) {
    on<Init>(_onInit);
    on<ManualEntryRequested>(_onManualEntryRequested);
    on<QRCodeRead>(_onQRCodeRead);
    on<QRViewCreated>(_onQRCodeCreated);
  }

  final WalletRepository _walletRepository;
  QRViewController? _qrViewController;

  void _onInit(Init event, Emitter<SendCoinsState> emit) {}

  void _onManualEntryRequested(
      ManualEntryRequested event, Emitter<SendCoinsState> emit) {}

  void _onQRCodeRead(QRCodeRead event, Emitter<SendCoinsState> emit) {}

  void _onQRCodeCreated(QRViewCreated event, Emitter<SendCoinsState> emit) {
    _qrViewController = event.controller;
    _qrViewController?.scannedDataStream.listen((scanData) {
      emit(SendCoinsQRRead(scanData));
    });
  }

  @override
  Future<void> close() {
    _qrViewController?.dispose();
    return super.close();
  }
}
