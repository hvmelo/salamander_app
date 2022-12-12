import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:salamander_app/data/repositories/transaction_fees/models/onchain_tx_fees.dart';
import 'package:salamander_app/data/repositories/transaction_fees/transaction_fees_repository.dart';
import 'package:salamander_app/data/repositories/wallet/wallet_repository.dart';
import 'package:salamander_app/util/btc_input_parser.dart';

part 'on_chain_payment_confirmation_state.dart';

class OnChainPaymentConfirmationCubit
    extends Cubit<OnChainPaymentConfirmationState> {
  OnChainPaymentConfirmationCubit({
    required BitcoinAddress address,
    required int amountInSats,
    required FeePriority selectedPriority,
    required int contractedTxFee,
    required int contractedTotalFee,
    required WalletRepository walletRepository,
    required TransactionFeesRepository feesRepository,
  })  : _walletRepository = walletRepository,
        _feesRepository = feesRepository,
        super(OnChainPaymentConfirmationState._(
          address: address,
          amountInSats: amountInSats,
          selectedPriority: selectedPriority,
          contractedTxFee: contractedTxFee,
          contractedTotalFee: contractedTotalFee,
        ));

  final TransactionFeesRepository _feesRepository;
  final WalletRepository _walletRepository;

  StreamSubscription? _walletSubscription;
  StreamSubscription? _feesSubscription;

  void init() {
    _walletSubscription = _walletRepository.wallet?.listen((wallet) {
      if (wallet.balance != null) {
        var balanceInSats = wallet.balance!['total_settled'] as int;
        if (state.currentBalance != null &&
            state.currentBalance != balanceInSats) {
          if (balanceInSats < state.amountInSats + state.contractedTotalFee) {
            emit(state.copyWith(
                status: OnChainPaymentConfirmationStatus.valueChanged,
                errorMessage:
                    '''Your balance has changed and the current sum is insufficient for this payment. Please select a new amount or a lower fee priority.'''));
          } else {
            emit(state.copyWith(currentBalance: balanceInSats));
          }
        } else {
          emit(state.copyWith(
              currentBalance: balanceInSats,
              status: OnChainPaymentConfirmationStatus.readyForPayment));
        }
      } else {
        emit(state.copyWith(
            status: OnChainPaymentConfirmationStatus.failure,
            errorMessage: 'Can\'t read wallet'));
      }
    });

    _feesSubscription = _feesRepository.onChainTxFees?.listen((fees) {
      var newTotalFee = fees.totalTxFeeByPriority[state.selectedPriority];
      if (newTotalFee != state.contractedTotalFee) {
        emit(state.copyWith(
            status: OnChainPaymentConfirmationStatus.valueChanged,
            errorMessage:
                '''Applied fees have changed. Please select a new amount or a lower fee priority again.'''));
      }
    });
  }

  @override
  Future<void> close() {
    _walletSubscription?.cancel();
    _feesSubscription?.cancel();
    return super.close();
  }
}
