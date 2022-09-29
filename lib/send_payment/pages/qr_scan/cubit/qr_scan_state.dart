import 'package:equatable/equatable.dart';
import 'package:salamander_app/util/btc_input_parser.dart';

enum QRScanStatus { initial, failure, successWithAddress, successWithInvoice }

class QRScanState extends Equatable {
  const QRScanState._(
      {this.status = QRScanStatus.initial,
      this.address,
      this.invoice,
      this.errorMessage});

  const QRScanState.initial() : this._();
  const QRScanState.successWithAddress(BitcoinAddress address)
      : this._(status: QRScanStatus.successWithAddress, address: address);
  const QRScanState.successWithInvoice(LightningInvoice invoice)
      : this._(status: QRScanStatus.successWithInvoice, invoice: invoice);
  const QRScanState.failure(String errorMessage)
      : this._(status: QRScanStatus.failure, errorMessage: errorMessage);

  final QRScanStatus status;
  final BitcoinAddress? address;
  final LightningInvoice? invoice;
  final String? errorMessage;

  QRScanState copyWith(
      {QRScanStatus? status,
      BitcoinAddress? address,
      LightningInvoice? invoice,
      String? errorMessage}) {
    return QRScanState._(
        status: status ?? this.status,
        address: address ?? this.address,
        invoice: invoice ?? this.invoice,
        errorMessage: errorMessage ?? this.errorMessage);
  }

  @override
  List<Object?> get props => [status, address, invoice, errorMessage];
}
