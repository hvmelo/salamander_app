import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:salamander_app/data/repositories/wallet/entities/wallet_entity.dart';

@immutable
class Wallet extends Equatable {
  Wallet(this.balance, this.lastUpdated, {required this.id});

  final String id;
  final double balance;
  final DateTime lastUpdated;

  Wallet copyWith({double? balance, DateTime? lastUpdated, String? id}) {
    return Wallet(
      balance ?? this.balance,
      lastUpdated ?? this.lastUpdated,
      id: id ?? this.id,
    );
  }

  @override
  List<Object?> get props => [id, balance, lastUpdated];

  @override
  String toString() {
    return 'Wallet {balance: $balance, id: $id, last updtated: $lastUpdated}';
  }

  WalletEntity toEntity() {
    return WalletEntity(balance, lastUpdated, id);
  }

  static Wallet fromEntity(WalletEntity entity) {
    return Wallet(
      entity.balance,
      entity.lastUpdated,
      id: entity.id,
    );
  }
}
