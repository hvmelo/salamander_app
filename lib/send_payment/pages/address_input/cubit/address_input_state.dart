part of 'address_input_cubit.dart';

enum AddressInputStatus {
  initial,
  editing,
  failure,
  successWithAddress,
  successWithInvoice
}

class AddressInputState extends Equatable {
  const AddressInputState._({
    required this.input,
    this.status = AddressInputStatus.initial,
    this.address,
    this.invoice,
    this.errorMessage,
  });

  const AddressInputState.initial() : this._(input: '');
  AddressInputState.successWithAddress(BitcoinAddress address)
      : this._(
            input: address.address,
            address: address,
            status: AddressInputStatus.successWithAddress);
  AddressInputState.successWithInvoice(LightningInvoice invoice)
      : this._(
            input: invoice.paymentRequest,
            invoice: invoice,
            status: AddressInputStatus.successWithInvoice);
  const AddressInputState.failure(String errorMessage)
      : this._(
            input: '',
            status: AddressInputStatus.failure,
            errorMessage: errorMessage);

  final AddressInputStatus status;
  final String input;
  final BitcoinAddress? address;
  final LightningInvoice? invoice;
  final String? errorMessage;

  AddressInputState copyWith(
      {AddressInputStatus? status,
      String? input,
      BitcoinAddress? address,
      LightningInvoice? invoice,
      String? errorMessage}) {
    return AddressInputState._(
        status: status ?? this.status,
        input: input ?? this.input,
        address: address ?? this.address,
        invoice: invoice ?? this.invoice,
        errorMessage: errorMessage ?? this.errorMessage);
  }

  @override
  List<Object?> get props => [status, input, address, invoice, errorMessage];
}
