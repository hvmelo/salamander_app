import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:salamander_app/data/repositories/authentication_repository.dart';
import 'package:salamander_app/data/repositories/wallet/entities/wallet_entity.dart';

@immutable
class Wallet extends Equatable {
  Wallet(
      {required this.ownerId,
      required this.balance,
      required this.lastUpdated,
      this.id});

  final String ownerId;
  final String? id;
  final double balance;
  final DateTime lastUpdated;

  Wallet copyWith(
      {String? ownerId, double? balance, DateTime? lastUpdated, String? id}) {
    return Wallet(
      ownerId: ownerId ?? this.ownerId,
      balance: balance ?? this.balance,
      lastUpdated: lastUpdated ?? this.lastUpdated,
      id: id ?? this.id,
    );
  }

  @override
  List<Object?> get props => [ownerId, id, balance, lastUpdated];

  @override
  String toString() {
    return 'Wallet {owner id: $ownerId, balance: $balance, id: $id, last updated: $lastUpdated}';
  }

  WalletEntity toEntity() {
    return WalletEntity(ownerId, balance, lastUpdated, id ?? '');
  }

  static Wallet fromEntity(WalletEntity entity) {
    return Wallet(
      ownerId: entity.ownerId,
      balance: entity.balance,
      lastUpdated: entity.lastUpdated,
      id: entity.id,
    );
  }
}
