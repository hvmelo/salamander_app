import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:salamander_app/data/repositories/transaction_fees/transaction_fees_repository.dart';
import 'package:salamander_app/data/repositories/transaction_fees_repository.dart';
import 'package:salamander_app/data/repositories/wallet_repository.dart';

part 'amount_input_state.dart';

class AmountInputCubit extends Cubit<AmountInputState> {
  AmountInputCubit(
      {required WalletRepository walletRepository,
      required TransactionFeesRepository feesRepository})
      : _walletRepository = walletRepository,
        _feesRepository = feesRepository,
        super(AmountInputState.initial());

  final TransactionFeesRepository _feesRepository;
  final WalletRepository _walletRepository;

  StreamSubscription? _walletSubscription;
  StreamSubscription? _feesSubscription;

  void init() {
    _walletSubscription = _walletRepository.wallet?.listen((wallet) {
      if (wallet.balance != null) {
        var balanceInSats = wallet.balance!['total_settled'] as int;
        emit(state.copyWith(
            status: checkStatus(newBalance: balanceInSats),
            balance: balanceInSats));
      } else {
        emit(state.copyWith(
            status: AmountInputStatus.failure,
            errorMessage: 'Can\'t read wallet'));
      }
    });

    _feesSubscription = _feesRepository.onChainTxFees?.listen((fees) {
      emit(state.copyWith(
          status: checkStatus(newTotalFeeByPriority: fees.totalTxFeeByPriority),
          txFeeByPriority: fees.txFeeByPriority,
          totalFeeByPriority: fees.totalTxFeeByPriority));
    });
  }

  void amountInputChanged(String amount) {
    var amt = int.tryParse(amount);
    if (amt != null) {
      emit(state.copyWith(status: checkStatus(newAmount: amt), amount: amt));
    }
  }

  void selectedPriorityChanged(FeePriority feePriority) {
    emit(state.copyWith(
        status: checkStatus(newSelectedPriority: feePriority),
        selectedPriority: feePriority));
  }

  AmountInputStatus checkStatus({
    int? newAmount,
    int? newBalance,
    Map<FeePriority, int>? newTotalFeeByPriority,
    FeePriority? newSelectedPriority,
  }) {
    var amount = newAmount ?? state.amount;
    var balance = newBalance ?? state.balance;
    var totalFeeByPriority = newTotalFeeByPriority ?? state.totalFeeByPriority;
    var selectedPriority = newSelectedPriority ?? state.selectedPriority;

    if (amount > 0 && balance != null && totalFeeByPriority != null) {
      var fee = totalFeeByPriority[selectedPriority];
      if (fee != null && balance >= amount + fee) {
        return AmountInputStatus.editingReady;
      }
    }
    return AmountInputStatus.editingNotReady;
  }

  void validateAndSubmit() {
    emit(state.copyWith(status: AmountInputStatus.success));
  }

  @override
  Future<void> close() {
    _walletSubscription?.cancel();
    _feesSubscription?.cancel();
    return super.close();
  }
}
