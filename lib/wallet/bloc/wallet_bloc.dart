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
          balance: unitCorrectedBalance(currentWallet),
          status: WalletStatus.synced));
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

    if (currentWallet == null) {
      emit(state.copyWith(
          status: WalletStatus.error,
          errorMessage: 'An error occurred during wallet creation'));
      return;
    }

    emit(state.copyWith(
        balance: unitCorrectedBalance(currentWallet),
        status: WalletStatus.synced));
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
    emit(state.copyWith(balance: unitCorrectedBalance(wallet)));
  }

  void _onWalletUnitChanged(
      WalletUnitChanged event, Emitter<WalletState> emit) {
    if (state.unit == WalletUnit.satoshi) {
      emit(state.copyWith(
          balance: toBTC(state.balance), unit: WalletUnit.bitcoin));
    } else {
      emit(state.copyWith(
          balance: toSatoshi(state.balance), unit: WalletUnit.satoshi));
    }
  }

  num unitCorrectedBalance(Wallet wallet) {
    var balanceInSats = wallet.balance != null
        ? wallet.balance!['total_settled'] as num
        : 0 as num;

    var correctedBalance =
        state.unit == WalletUnit.bitcoin ? toBTC(balanceInSats) : balanceInSats;

    return correctedBalance;
  }

  double toBTC(double balanceInSats) {
    return balanceInSats / 100000000;
  }

  double toSatoshi(double balanceInBTC) {
    return balanceInBTC * 100000000;
  }

  @override
  Future<void> close() {
    _walletSubscription?.cancel();
    return super.close();
  }
}
