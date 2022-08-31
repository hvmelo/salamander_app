part of 'send_coins_bloc.dart';

abstract class SendCoinsEvent extends Equatable {
  const SendCoinsEvent();

  @override
  List<Object> get props => [];
}

class QRViewCreated extends SendCoinsEvent {
  QRViewCreated(this.controller);
  final QRViewController controller;
}

class QRCodeRead extends SendCoinsEvent {}

class ManualEntryRequested extends SendCoinsEvent {}

class QRScanRequested extends SendCoinsEvent {}

class AddressEntered extends SendCoinsEvent {
  AddressEntered(this.address);
  final String address;
}

class AmountEntered extends SendCoinsEvent {
  AmountEntered(this.amount);
  final num amount;
}

class ConfirmationSubmitted extends SendCoinsEvent {}
