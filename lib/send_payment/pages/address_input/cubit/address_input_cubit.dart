import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:salamander_app/util/btc_input_parser.dart';

part 'address_input_state.dart';

class AddressInputCubit extends Cubit<AddressInputState> {
  AddressInputCubit() : super(const AddressInputState.initial());

  void formInputChanged(String input) {
    emit(state.copyWith(status: AddressInputStatus.editing, input: input));
  }

  void validateAndSubmit() {
    var currentInput = state.input;

    if (currentInput.isNotEmpty) {
      var parsedInput = BTCInputParser.parseInput(currentInput);
      if (parsedInput != null) {
        if (parsedInput is BitcoinAddress) {
          emit(AddressInputState.successWithAddress(parsedInput));
        } else if (parsedInput is LightningInvoice) {
          emit(AddressInputState.successWithInvoice(parsedInput));
        }
      } else {
        // Could't parse. Should emit an error message
        emit(state.copyWith(
            status: AddressInputStatus.failure,
            errorMessage: 'The input format is invalid. '
                'Please enter a valid Bitcoin address or a Lighting invoice'));
      }
    }
  }
}
