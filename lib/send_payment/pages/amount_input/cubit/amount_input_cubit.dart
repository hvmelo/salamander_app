import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'amount_input_state.dart';

class AmountInputCubit extends Cubit<AmountInputState> {
  AmountInputCubit() : super(const AmountInputState.initial());

  void amountInputChanged(String amount) {
    var amtStr = state.amount != 0 ? state.amount.toString() + amount : amount;
    var amt = num.tryParse(amtStr);
    if (amt != null) {
      emit(state.copyWith(status: AmountInputStatus.editing, amount: amt));
    }
  }
}
