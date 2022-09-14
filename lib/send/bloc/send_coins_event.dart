part of 'send_coins_bloc.dart';

abstract class SendCoinsEvent extends Equatable {
  const SendCoinsEvent();

  @override
  List<Object> get props => [];
}

/* QR Scanner events */

class QRScanRequested extends SendCoinsEvent {}

class QRCodeRead extends SendCoinsEvent {
  QRCodeRead(this.code);
  final String code;
}

/* Manual Entry events */

class ManualEntryRequested extends SendCoinsEvent {}

class InputAddressChanged extends SendCoinsEvent {
  InputAddressChanged(this.address);
  final String address;
}

class PasteFromClipboardRequested extends SendCoinsEvent {
  PasteFromClipboardRequested(this.text);
  final String text;
}

class ManualInputConfirmed extends SendCoinsEvent {
  ManualInputConfirmed();
}

class AmountEntered extends SendCoinsEvent {
  AmountEntered(this.amount);
  final num amount;
}

class ConfirmationSubmitted extends SendCoinsEvent {}
