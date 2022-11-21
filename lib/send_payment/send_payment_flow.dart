import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:salamander_app/send_payment/pages/payment_confirmation/on_chain/on_chain_payment_confirmation_page.dart';
import 'package:salamander_app/send_payment/send_payment.dart';
import 'package:salamander_app/util/page_routes.dart';

List<Page<dynamic>> onGenerateLocationPages(
  PaymentFlowData paymentFlowData,
  List<Page<dynamic>> pages,
) {
  final useQRCode = paymentFlowData.useQRCode;
  final bitcoinAddress = paymentFlowData.address;
  final lightningInvoice = paymentFlowData.invoice;
  final amountInSats = paymentFlowData.amountInSats;
  final selectedFeePriority = paymentFlowData.selectedFeePriority;
  final contractedTxFee = paymentFlowData.contractedTxFee;
  final contractedTotalFee = paymentFlowData.contractedTotalFee;

  return [
    QRScanPage.page(),
    if (!useQRCode) AddressInputPage.page(),
    if (!useQRCode && bitcoinAddress != null) AmountInputPage.page(),
    if (bitcoinAddress != null &&
        amountInSats != null &&
        selectedFeePriority != null &&
        contractedTxFee != null &&
        contractedTotalFee != null)
      OnChainPaymentConfirmationPage.page(
        address: bitcoinAddress,
        amountInSats: amountInSats,
        selectedFeePriority: selectedFeePriority,
        contractedTxFee: contractedTxFee,
        contractedTotalFee: contractedTotalFee,
      )
  ];
}

class SendPaymentFlow extends StatelessWidget {
  const SendPaymentFlow._();

  static Route<PaymentFlowData> route() {
    return BottomUpPageRoute(builder: (_) => const SendPaymentFlow._());
  }

  @override
  Widget build(BuildContext context) {
    return const FlowBuilder<PaymentFlowData>(
      state: PaymentFlowData(),
      onGeneratePages: onGenerateLocationPages,
    );
  }
}
