part of 'send_coins_bloc.dart';

enum AddressType { onchain, lightning }

enum AddressEntryType { qrcode, manual }

class SendCoinsState extends Equatable {
  const SendCoinsState();

  @override
  List<Object> get props => [];
}

class SendCoinsQRReadState extends SendCoinsState {
  const SendCoinsQRReadState();
  static const initial = SendCoinsQRReadState();
}

class SendCoinsManualEntryState extends SendCoinsState {
  const SendCoinsManualEntryState({required this.value});
  final String value;

  static const initial = SendCoinsManualEntryState(value: '');

  SendCoinsManualEntryState copyWith({
    String? value,
  }) {
    return SendCoinsManualEntryState(
      value: value ?? this.value,
    );
  }

  @override
  List<Object> get props => [value];
}

class SendCoinsOnChainState extends SendCoinsState {
  SendCoinsOnChainState({required this.address, this.amountInSats});
  final String address;
  final num? amountInSats;

  @override
  List<Object> get props => [address, amountInSats ?? 0];
}

class SendCoinsLightningState extends SendCoinsState {
  SendCoinsLightningState({required this.invoice});
  final String invoice;

  @override
  List<Object> get props => [invoice];
}

class EnterAmountInitial extends SendCoinsState {}

class ConfirmationInitial extends SendCoinsState {}
