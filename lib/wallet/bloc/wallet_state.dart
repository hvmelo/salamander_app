part of 'wallet_bloc.dart';

enum WalletUnit { bitcoin, satoshi }
enum WalletStatus { initial, creating, synced, error }

class WalletState extends Equatable {
  const WalletState(
      {this.balance = 0,
      this.unit = WalletUnit.bitcoin,
      this.address = '',
      this.status = WalletStatus.initial,
      this.errorMessage = ''});

  final num balance;
  final WalletUnit unit;
  final WalletStatus status;
  final String address;
  final String? errorMessage;

  WalletState copyWith({
    num? balance,
    WalletUnit? unit,
    String? address,
    WalletStatus? status,
    String? errorMessage,
  }) {
    return WalletState(
        balance: balance ?? this.balance,
        unit: unit ?? this.unit,
        address: address ?? this.address,
        status: status ?? this.status,
        errorMessage: errorMessage ?? this.errorMessage);
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
  List<Object> get props => [balance, unit, address, status];
}
