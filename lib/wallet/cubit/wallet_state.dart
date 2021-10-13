part of 'wallet_cubit.dart';

enum WalletUnit { bitcoin, satoshi }
enum WalletStatus { initial, synced, error }

@immutable
class WalletState extends Equatable {
  const WalletState({
    this.balance = 0,
    this.unit = WalletUnit.bitcoin,
    this.status = WalletStatus.initial,
  });

  final double balance;
  final WalletUnit unit;
  final WalletStatus status;

  WalletState copyWith({
    double? balance,
    WalletUnit? unit,
    WalletStatus? status,
  }) {
    return WalletState(
      balance: balance ?? this.balance,
      unit: unit ?? this.unit,
      status: status ?? this.status,
    );
  }

  String get balanceStr {
    switch (unit) {
      case WalletUnit.satoshi:
        return balance.toStringAsFixed(0);
      default:
        return balance.toStringAsFixed(8);
    }
  }

  String get getUnitStr {
    switch (unit) {
      case WalletUnit.satoshi:
        return 'sats';
      default:
        return 'BTC';
    }
  }

  @override
  List<Object> get props => [balance, unit, status];
}
