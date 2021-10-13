import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shopping_cart/data/wallet_repository.dart';

part 'wallet_state.dart';

class WalletCubit extends Cubit<WalletState> {
  WalletCubit(this._walletRepository) : super(const WalletState());

  final WalletRepository _walletRepository;

  StreamSubscription<double>? _balanceSubscription;

  void startSyncing() async {
    var isSynced = await _walletRepository.startSyncing();
    if (isSynced) {
      await _balanceSubscription?.cancel();
      _balanceSubscription = _walletRepository.balance.listen((newBalance) {
        if (state.unit == WalletUnit.satoshi) {
          newBalance = newBalance.toSatoshi();
        }
        emit(
          state.copyWith(
            balance: newBalance,
            status: WalletStatus.synced,
          ),
        );
      });
    } else {
      emit(const WalletState(status: WalletStatus.error));
    }
  }

  void toggleUnit() {
    if (state.unit == WalletUnit.satoshi) {
      emit(state.copyWith(
          balance: state.balance.toBTC(), unit: WalletUnit.bitcoin));
    } else {
      emit(state.copyWith(
          balance: state.balance.toSatoshi(), unit: WalletUnit.satoshi));
    }
  }
}

extension on double {
  double toSatoshi() => this * 100000000;
  double toBTC() => this / 100000000;
}
