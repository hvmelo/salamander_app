part of 'wallet_bloc.dart';

abstract class WalletEvent extends Equatable {
  const WalletEvent();

  @override
  List<Object> get props => [];
}

class WalletInit extends WalletEvent {}

class WalletCreate extends WalletEvent {}

class WalletUpdated extends WalletEvent {
  const WalletUpdated(this.wallet);
  final Wallet wallet;

  @override
  List<Object> get props => [wallet];
}

class WalletUnitChanged extends WalletEvent {}
