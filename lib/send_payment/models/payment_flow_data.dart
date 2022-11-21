import 'package:equatable/equatable.dart';
import 'package:salamander_app/data/repositories/transaction_fees_repository.dart';
import 'package:salamander_app/util/btc_input_parser.dart';

class PaymentFlowData extends Equatable {
  const PaymentFlowData(
      {this.addressOrInvoiceInput,
      this.address,
      this.invoice,
      this.amountInSats,
      this.selectedFeePriority,
      this.contractedTxFee,
      this.contractedTotalFee,
      this.useQRCode = true});

  final String? addressOrInvoiceInput;
  final BitcoinAddress? address;
  final LightningInvoice? invoice;
  final int? amountInSats;
  final FeePriority? selectedFeePriority;
  final int? contractedTxFee;
  final int? contractedTotalFee;
  final bool useQRCode;

  @override
  List<Object?> get props => [
        addressOrInvoiceInput,
        address,
        invoice,
        amountInSats,
        selectedFeePriority,
        contractedTxFee,
        contractedTotalFee,
        useQRCode
      ];

  PaymentFlowData copyWith({
    String? addressOrInvoiceInput,
    BitcoinAddress? address,
    LightningInvoice? invoice,
    int? amountInSats,
    FeePriority? selectedFeePriority,
    int? contractedTxFee,
    int? contractedTotalFee,
    bool? useQRCode,
  }) {
    return PaymentFlowData(
      addressOrInvoiceInput:
          addressOrInvoiceInput ?? this.addressOrInvoiceInput,
      address: address ?? this.address,
      invoice: invoice ?? this.invoice,
      amountInSats: amountInSats ?? this.amountInSats,
      selectedFeePriority: selectedFeePriority ?? this.selectedFeePriority,
      contractedTxFee: contractedTxFee ?? this.contractedTxFee,
      contractedTotalFee: contractedTotalFee ?? this.contractedTotalFee,
      useQRCode: useQRCode ?? this.useQRCode,
    );
  }
}
