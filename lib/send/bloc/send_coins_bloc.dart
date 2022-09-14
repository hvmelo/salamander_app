import 'package:bloc/bloc.dart';
import 'package:coinslib/coinslib.dart';
import 'package:equatable/equatable.dart';
import 'package:salamander_app/data/repositories/wallet_repository.dart';
import 'package:bolt11_decoder/bolt11_decoder.dart';

part 'send_coins_event.dart';
part 'send_coins_state.dart';

class SendCoinsBloc extends Bloc<SendCoinsEvent, SendCoinsState> {
  SendCoinsBloc({required WalletRepository walletRepository})
      : _walletRepository = walletRepository,
        super(const SendCoinsState()) {
    on<ManualEntryRequested>(_onManualEntryRequested);
    on<QRScanRequested>(_onQRScanRequested);
    on<QRCodeRead>(_onQRCodeRead);
    on<InputAddressChanged>(_onInputAddressChanged);
    on<ManualInputConfirmed>(_onManualInputConfirmed);
    on<PasteFromClipboardRequested>(_onPasteFromClipboardRequested);
  }

  final WalletRepository _walletRepository;

  void _onManualEntryRequested(
      ManualEntryRequested event, Emitter<SendCoinsState> emit) {
    emit(SendCoinsManualEntryState.initial);
  }

  void _onQRScanRequested(QRScanRequested event, Emitter<SendCoinsState> emit) {
    emit(SendCoinsQRReadState.initial);
  }

  void _onQRCodeRead(QRCodeRead event, Emitter<SendCoinsState> emit) {
    var code = event.code;
    //TODO: Check if code is bitcoin address or Lightning Invoice
  }

  void _onInputAddressChanged(
      InputAddressChanged event, Emitter<SendCoinsState> emit) {
    var theState = state as SendCoinsManualEntryState;
    emit(theState.copyWith(value: event.address));
  }

  void _onManualInputConfirmed(
      ManualInputConfirmed event, Emitter<SendCoinsState> emit) {
    var theState = state as SendCoinsManualEntryState;
    var input = theState.value;
    if (input.isNotEmpty) {
      var response = verifyInput(input);
      if (response is String) {
      } else if (response is Bolt11PaymentRequest) {
        for (var t in response.tags) {
          print('${t.type}: ${t.data}');
        }
      }
    }
  }

  void _onPasteFromClipboardRequested(
      PasteFromClipboardRequested event, Emitter<SendCoinsState> emit) {
    var copiedtext = event.text;
    var theState = state as SendCoinsManualEntryState;
    emit(theState.copyWith(value: copiedtext));
  }
}

Object verifyInput(String input) {
  if (Address.validateAddress(input, testnet)) {
    return input;
  } else {
    var req = Bolt11PaymentRequest(input);
    return req;
  }
}
