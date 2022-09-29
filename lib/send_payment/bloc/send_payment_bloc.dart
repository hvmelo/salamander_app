import 'package:bloc/bloc.dart';
import 'package:bolt11_decoder/bolt11_decoder.dart';
import 'package:coinslib/coinslib.dart';
import 'package:equatable/equatable.dart';
import 'package:salamander_app/data/repositories/wallet_repository.dart';

part 'send_payment_event.dart';
part 'send_payment_state.dart';

class SendPaymentBloc extends Bloc<SendPaymentEvent, SendPaymentState> {
  SendPaymentBloc({required WalletRepository walletRepository})
      : _walletRepository = walletRepository,
        super(const SendPaymentState()) {
    on<ManualAddressEntryRequested>(_onManualAddressEntryRequested);
    on<QRScanRequested>(_onQRScanRequested);
    on<QRCodeRead>(_onQRCodeRead);
    on<InputAddressChanged>(_onInputAddressChanged);
    on<InputAddressSubmitted>(_onInputAddressSubmitted);
    on<SubmissionFailureMessageDisplayed>(_onSubmissionFailureMessageDisplayed);
    on<PasteFromClipboardRequested>(_onPasteFromClipboardRequested);
  }

  final WalletRepository _walletRepository;

  void _onManualAddressEntryRequested(
      ManualAddressEntryRequested event, Emitter<SendPaymentState> emit) {
    var address = event.address;
    emit(address != null
        ? SendPaymentEnterAddressState(address: address)
        : SendPaymentEnterAddressState.initial);
  }

  void _onQRScanRequested(
      QRScanRequested event, Emitter<SendPaymentState> emit) {
    emit(SendPaymentQRReadState.initial);
  }

  void _onQRCodeRead(QRCodeRead event, Emitter<SendPaymentState> emit) {
    var code = event.code;
    //TODO: Check if code is bitcoin address or Lightning Invoice
  }

  /// Manual Entry Methods

  void _onInputAddressChanged(
      InputAddressChanged event, Emitter<SendPaymentState> emit) {
    var theState = state as SendPaymentEnterAddressState;
    emit(theState.copyWith(
        address: event.address,
        status: SendPaymentAddressFormStatus.editing,
        errorMessage: null));
  }

  void _onInputAddressSubmitted(
      InputAddressSubmitted event, Emitter<SendPaymentState> emit) {
    var theState = state as SendPaymentEnterAddressState;
    var input = theState.address;
    if (input.isNotEmpty) {
      var parsedInput = parseInput(input);
      if (parsedInput != null) {
        if (parsedInput is String) {
          emit(SendPaymentEnterAmountState(address: input, amountInSats: 0));
        } else if (parsedInput is Bolt11PaymentRequest) {
          for (var t in parsedInput.tags) {
            print('${t.type}: ${t.data}');
          }
        }
      } else {
        // Could't parse. Should emit an error message
        emit(theState.copyWith(
            status: SendPaymentAddressFormStatus.submissionFailure,
            errorMessage: 'The input format is invalid. '
                'Please enter a valid Bitcoin address or a Lighting invoice'));
      }
    }
  }

  void _onPasteFromClipboardRequested(
      PasteFromClipboardRequested event, Emitter<SendPaymentState> emit) {
    var copiedtext = event.text;
    var theState = state as SendPaymentEnterAddressState;
    emit(theState.copyWith(address: copiedtext));
  }

  void _onSubmissionFailureMessageDisplayed(
      SubmissionFailureMessageDisplayed event, Emitter<SendPaymentState> emit) {
    var theState = state as SendPaymentEnterAddressState;
    emit(theState.copyWith(
        status: SendPaymentAddressFormStatus.editing, errorMessage: null));
  }
}

Object? parseInput(String input) {
  if (Address.validateAddress(input, testnet)) {
    return input;
  } else {
    try {
      var req = Bolt11PaymentRequest(input);
      if (req.prefix.name != 'lntb') {
        /* (lnbc for Bitcoin mainnet, lntb for Bitcoin testnet, lntbs for 
            Bitcoin signet, and lnbcrt for Bitcoin regtest) */
        return null;
      }
      return req;
    } catch (e) {
      return null;
    }
  }
}
