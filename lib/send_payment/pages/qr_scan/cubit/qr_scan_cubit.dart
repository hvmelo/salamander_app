import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:salamander_app/util/btc_input_parser.dart';

part 'qr_scan_state.dart';

class QRScanCubit extends Cubit<QRScanState> {
  QRScanCubit() : super(const QRScanState.initial());

  void qrCodeRead(String code) {
    if (code.isNotEmpty) {
      var parsedInput = BTCInputParser.parseInput(code);
      if (parsedInput != null) {
        if (parsedInput is BitcoinAddress) {
          emit(QRScanState.successWithAddress(parsedInput));
        } else if (parsedInput is LightningInvoice) {
          emit(QRScanState.successWithInvoice(parsedInput));
        }
      } else {
        // Could't parse. Should emit an error message
        emit(
          state.copyWith(
              status: QRScanStatus.failure,
              errorMessage: 'The input format is invalid. '),
        );
      }
    }
  }
}
