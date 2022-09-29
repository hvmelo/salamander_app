part of 'send_payment_bloc.dart';

enum AddressType { onchain, lightning }

enum AddressEntryType { qrcode, manual }

class SendPaymentState extends Equatable {
  const SendPaymentState();

  @override
  List<Object> get props => [];
}

class SendPaymentQRReadState extends SendPaymentState {
  const SendPaymentQRReadState();
  static const initial = SendPaymentQRReadState();
}

enum SendPaymentAddressFormStatus {
  /// The form has not been touched.
  editing,

  /// The form has been submitted successfully.
  submissionSuccess,

  /// The form submission failed.
  submissionFailure,

  /// The form submission has been canceled.
  submissionCanceled
}

class SendPaymentEnterAddressState extends SendPaymentState {
  const SendPaymentEnterAddressState(
      {required this.address,
      this.status = SendPaymentAddressFormStatus.editing,
      this.errorMessage});

  final String address;
  final SendPaymentAddressFormStatus status;
  final String? errorMessage;

  static const initial = SendPaymentEnterAddressState(
      address: '', status: SendPaymentAddressFormStatus.editing);

  SendPaymentEnterAddressState copyWith({
    String? address,
    SendPaymentAddressFormStatus? status,
    String? errorMessage,
  }) {
    return SendPaymentEnterAddressState(
      address: address ?? this.address,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object> get props => [address, status];
}

class SendPaymentEnterAmountState extends SendPaymentState {
  SendPaymentEnterAmountState(
      {required this.address, required this.amountInSats});
  final String address;
  final int amountInSats;

  @override
  List<Object> get props => [address, amountInSats];
}
