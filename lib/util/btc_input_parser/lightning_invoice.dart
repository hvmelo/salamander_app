import 'package:fixnum/fixnum.dart';

enum LightningNetwork { mainnet, testnet }

class LightningInvoice {
  const LightningInvoice(
      {required this.paymentRequest,
      required this.network,
      required this.amount,
      required this.timestamp,
      this.description});

  final String paymentRequest;
  final LightningNetwork network;
  final BigInt amount;
  final Int64 timestamp;
  final String? description;
}
