import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'amount_input_state.dart';

class AmountInputCubit extends Cubit<AmountInputState> {
  AmountInputCubit() : super(const AmountInputState.initial());

  void amountInputChanged(String amount) {
    emit(state.copyWith(status: AmountInputStatus.editing, amount: amount));
  }
}
