import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salamander_app/data/repositories/wallet/wallet_repository.dart';
import 'package:salamander_app/data/repositories/wallet_repository.dart';

part 'wallet_event.dart';
part 'wallet_state.dart';

class WalletBloc extends Bloc<WalletEvent, WalletState> {
  WalletBloc({required WalletRepository walletRepository})
      : _walletRepository = walletRepository,
        super(const WalletState()) {
    on<WalletUnitChanged>(_onWalletUnitChanged);
    on<WalletUpdated>(_onWalletUpdated);
    on<WalletInit>(_onWalletInit);
  }

  final WalletRepository _walletRepository;
  StreamSubscription? _walletSubscription;

  void _onWalletInit(WalletInit event, Emitter<WalletState> emit) {
    _walletSubscription?.cancel();
    _walletSubscription = _walletRepository.wallet().listen((wallet) {
      add(WalletUpdated(wallet));
    });
  }

  void _onWalletUpdated(WalletUpdated event, Emitter<WalletState> emit) {
    var wallet = event.wallet;
    emit(state.copyWith(balance: wallet.balance));
  }

  void _onWalletUnitChanged(
      WalletUnitChanged event, Emitter<WalletState> emit) {
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
