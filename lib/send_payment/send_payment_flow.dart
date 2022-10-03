import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:salamander_app/send_payment/send_payment.dart';
import 'package:salamander_app/util/page_routes.dart';

List<Page<dynamic>> onGenerateLocationPages(
  PaymentFlowData paymentFlowData,
  List<Page<dynamic>> pages,
) {
  final useQRCode = paymentFlowData.useQRCode;
  final bitcoinAddress = paymentFlowData.address;
  final lightningInvoice = paymentFlowData.invoice;

  return [
    QRScanPage.page(),
    if (!useQRCode) AddressInputPage.page(),
    if (!useQRCode && bitcoinAddress != null) AmountInputPage.page()
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
