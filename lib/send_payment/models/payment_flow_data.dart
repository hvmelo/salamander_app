import 'package:equatable/equatable.dart';
import 'package:salamander_app/util/btc_input_parser.dart';

class PaymentFlowData extends Equatable {
  const PaymentFlowData(
      {this.addressOrInvoiceInput,
      this.address,
      this.invoice,
      this.amountInSats,
      this.useQRCode = true});

  final String? addressOrInvoiceInput;
  final BitcoinAddress? address;
  final LightningInvoice? invoice;
  final int? amountInSats;
  final bool useQRCode;

  @override
  List<Object?> get props =>
      [addressOrInvoiceInput, address, invoice, amountInSats, useQRCode];

  PaymentFlowData copyWith({
    String? addressOrInvoiceInput,
    BitcoinAddress? address,
    LightningInvoice? invoice,
    int? amountInSats,
    bool? useQRCode,
  }) {
    return PaymentFlowData(
      addressOrInvoiceInput:
          addressOrInvoiceInput ?? this.addressOrInvoiceInput,
      address: address ?? this.address,
      invoice: invoice ?? this.invoice,
      amountInSats: amountInSats ?? this.amountInSats,
      useQRCode: useQRCode ?? this.useQRCode,
    );
  }
}
