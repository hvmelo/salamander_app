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
    on<WalletCreate>(_onWalletCreate);
  }

  final WalletRepository _walletRepository;
  StreamSubscription? _walletSubscription;

  Future<void> _onWalletInit(
      WalletInit event, Emitter<WalletState> emit) async {
    Wallet? currentWallet;
    emit(state.copyWith(status: WalletStatus.initial));
    try {
      currentWallet = await _walletRepository.currentWallet;
    } catch (e) {
      emit(state.copyWith(
          status: WalletStatus.error,
          errorMessage: "Can't retrieve wallet data"));
      return;
    }

    await Future<void>.delayed(const Duration(seconds: 1));

    if (currentWallet != null) {
      emit(state.copyWith(
          balance: currentWallet.balance, status: WalletStatus.synced));
      await _walletSubscription?.cancel();
      _walletSubscription = _walletRepository.wallet?.listen((wallet) {
        add(WalletUpdated(wallet));
      });

      if (_walletSubscription == null) {
        emit(state.copyWith(
            status: WalletStatus.error,
            errorMessage: 'An error occurred on wallet subscription'));
        return;
      }
    } else {
      add(WalletCreate());
    }
  }

  Future<void> _onWalletCreate(
      WalletCreate event, Emitter<WalletState> emit) async {
    emit(state.copyWith(status: WalletStatus.creating));

    Wallet? currentWallet;

    try {
      currentWallet = await _walletRepository.createWallet();
    } catch (e) {
      emit(state.copyWith(
          status: WalletStatus.error,
          errorMessage: 'An error occurred during wallet creation'));
      return;
    }

    await Future<void>.delayed(const Duration(seconds: 1));

    currentWallet = null;

    if (currentWallet == null) {
      emit(state.copyWith(
          status: WalletStatus.error,
          errorMessage: 'An error occurred during wallet creation'));
      return;
    }

    emit(state.copyWith(
        balance: currentWallet.balance, status: WalletStatus.synced));
    await _walletSubscription?.cancel();
    _walletSubscription = _walletRepository.wallet?.listen((wallet) {
      add(WalletUpdated(wallet));
    });
    if (_walletSubscription == null) {
      emit(state.copyWith(
          status: WalletStatus.error,
          errorMessage: 'An error occurred on wallet subscription'));
      return;
    }
  }

  void _onWalletUpdated(WalletUpdated event, Emitter<WalletState> emit) {
    var wallet = event.wallet;
    emit(state.copyWith(balance: wallet.balance, status: WalletStatus.synced));
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

  @override
  Future<void> close() {
    _walletSubscription?.cancel();
    return super.close();
  }
}

extension on double {
  double toSatoshi() => this * 100000000;
  double toBTC() => this / 100000000;
}
