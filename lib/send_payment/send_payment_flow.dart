import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:salamander_app/send_payment/models/payment_flow_data.dart';
import 'package:salamander_app/send_payment/pages/address_input/address_input_page.dart';
import 'package:salamander_app/send_payment/pages/address_input/cubit/address_input_cubit.dart';
import 'package:salamander_app/send_payment/pages/qr_scan/qr_scan_page.dart';
import 'package:salamander_app/util/btc_input_parser/bitcoin_address.dart';
import 'package:salamander_app/util/btc_input_parser/lightning_invoice.dart';

List<Page<dynamic>> onGenerateLocationPages(
  PaymentFlowData paymentFlowData,
  List<Page<dynamic>> pages,
) {
  final userQRCode = paymentFlowData.useQRCode;
  final bitcoinAddress = paymentFlowData.address;
  final LightningInvoice = paymentFlowData.invoice;

  return [
    QRScanPage.page(),
    if (!userQRCode) AddressInputPage.page(),
  ];
}

class SendPaymentFlow extends StatelessWidget {
  const SendPaymentFlow._();

  static Route<PaymentFlowData> route() {
    return MaterialPageRoute(builder: (_) => const SendPaymentFlow._());
  }

  @override
  Widget build(BuildContext context) {
    return const FlowBuilder<PaymentFlowData>(
      state: PaymentFlowData(),
      onGeneratePages: onGenerateLocationPages,
    );
  }
}
