part of 'send_coins_bloc.dart';

enum AddressType { onchain, lightning }

enum AddressEntryType { qrcode, manual }

class SendCoinsState extends Equatable {
  const SendCoinsState({this.entryType = AddressEntryType.qrcode});

  final AddressEntryType entryType;

  @override
  List<Object> get props => [entryType];

  SendCoinsState copyWith({
    AddressEntryType? entryType,
    bool? shouldEndFlow,
  }) {
    return SendCoinsState(entryType: entryType ?? this.entryType);
  }
}

class SendCoinsOnChainState extends SendCoinsState {
  SendCoinsOnChainState({required this.address, this.amountInSats});
  final String address;
  final num? amountInSats;

  @override
  List<Object> get props => [address, amountInSats ?? 0, entryType];
}

class SendCoinsLightningState extends SendCoinsState {
  SendCoinsLightningState({required this.invoice});
  final String invoice;

  @override
  List<Object> get props => [invoice, entryType];
}

class EnterAddressInitial extends SendCoinsState {}

class EnterAmountInitial extends SendCoinsState {}

class ConfirmationInitial extends SendCoinsState {}
