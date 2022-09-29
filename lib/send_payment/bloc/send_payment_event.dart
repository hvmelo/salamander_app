part of 'send_payment_bloc.dart';

abstract class SendPaymentEvent extends Equatable {
  const SendPaymentEvent();

  @override
  List<Object> get props => [];
}

/* QR Scanner events */

class QRScanRequested extends SendPaymentEvent {}

class QRCodeRead extends SendPaymentEvent {
  QRCodeRead(this.code);
  final String code;
}

/* Enter Address events */

class ManualAddressEntryRequested extends SendPaymentEvent {
  ManualAddressEntryRequested(this.address);
  final String? address;
}

class InputAddressChanged extends SendPaymentEvent {
  InputAddressChanged(this.address);
  final String address;
}

class PasteFromClipboardRequested extends SendPaymentEvent {
  PasteFromClipboardRequested(this.text);
  final String text;
}

class SubmissionFailureMessageDisplayed extends SendPaymentEvent {
  SubmissionFailureMessageDisplayed();
}

class InputAddressSubmitted extends SendPaymentEvent {
  InputAddressSubmitted();
}

/* Enter Amount events */

class InputAmountChanged extends SendPaymentEvent {
  InputAmountChanged(this.amountInSats);
  final String amountInSats;
}

class InputAmountSubmitted extends SendPaymentEvent {
  InputAmountSubmitted();
}
