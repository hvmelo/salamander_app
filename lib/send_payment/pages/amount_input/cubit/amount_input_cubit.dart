import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:salamander_app/data/repositories/wallet_repository.dart';

part 'amount_input_state.dart';

class AmountInputCubit extends Cubit<AmountInputState> {
  AmountInputCubit({required WalletRepository walletRepository})
      : _walletRepository = walletRepository,
        super(const AmountInputState.initial());

  final WalletRepository _walletRepository;
  StreamSubscription? _walletSubscription;

  void init() {
    _walletSubscription = _walletRepository.wallet?.listen((wallet) {
      if (wallet.balance != null) {
        var balanceInSats = wallet.balance!['total_settled'] as num;
        emit(state.copyWith(
            status: AmountInputStatus.editing, balance: balanceInSats));
      } else {
        emit(state.copyWith(
            status: AmountInputStatus.failure,
            errorMessage: 'Can\'t read wallet'));
      }
    });
  }

  void amountInputChanged(String amount) {
    var amt = num.tryParse(amount);
    if (amt != null) {
      emit(state.copyWith(status: AmountInputStatus.editing, amount: amt));
    }
  }

  @override
  Future<void> close() {
    _walletSubscription?.cancel();
    return super.close();
  }
}
